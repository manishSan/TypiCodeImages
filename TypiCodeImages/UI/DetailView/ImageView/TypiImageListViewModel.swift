//
//  TypiImageViewModel.swift
//  TypiCodeImages
//
//  Created by Sanwal, Manish on 3/19/19.
//  Copyright © 2019 Sanwal. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

enum TypiImageListState {
    case loading
    case ready([Int: [ImageProtocol]])
    case error(String)

    func images(forAlbum: Int) -> [ImageProtocol] {
        switch self {
        case .loading, .error:
            return [ImageProtocol]()
        case .ready(let albums):
            return albums[forAlbum] ?? [ImageProtocol]()
        }
    }

    func allAlbums() -> [Int] {
        switch self {
        case .loading, .error:
            return [Int]()
        case .ready(let albums):
            return Array(albums.keys).sorted()
        }
    }
}

protocol TypiImageListViewModelProtocol {
    /// the current state of UI
    var state: BehaviorRelay<TypiImageListState> { get }

    /// get Images to load on UI
    func fetchImageList()

    /// number of sections in tableView
    ///
    /// - Returns: `Int`
    func numberOfSections() -> Int

    /// number of rows for a given section
    ///
    /// - Parameter forSection: section index
    /// - Returns: `Int`
    func numberOfRows(forSection: Int) -> Int

    /// title at an index
    ///
    /// - Parameter forIndex: indexPath
    /// - Returns: `String`
    func title(forIndex: IndexPath) -> String

    /// title for section
    ///
    /// - Parameter forSection: Int
    /// - Returns: optional String
    func title(forSection: Int) -> String?

    /// get Image for a given URL
    ///
    /// - Parameter forIndex: indexPath
    /// - Returns: Single<UIImage?>
    func getThumbnailImage(forIndex: IndexPath) -> Single<UIImage?>

    /// selection event
    ///
    /// - Parameter index: IndexPath
    func select(index: IndexPath)
}

struct TypiImageListViewModel: TypiImageListViewModelProtocol {
    /// the state of the view controller
    let state: BehaviorRelay<TypiImageListState> = BehaviorRelay(value: .loading)

    /// api client
    let apiClient: ApiClientProtocol

    /// dispose bag
    let disposeBag = DisposeBag()

    /// a selection closre to send the select event back to coordinator
    let selectionClosure: (ImageProtocol) -> Void

    /// get Images to load on UI
    func fetchImageList() {
        state.accept(.loading)
        apiClient
            .images()
            .asObservable()
            .subscribe(onNext: { result in
                switch result {
                case .success(let updatedImages):
                    self.state.accept(.ready(self.processImageResult(images: updatedImages)))
                case .failure(let error):
                    self.state.accept(.error(error.message))
                }
            })
            .disposed(by: disposeBag)
    }

    /// helper method to pross image array into disctionary
    ///
    /// - Parameter images: an Image array
    /// - Returns: [Int: [ImageProtocol]]
    func processImageResult(images: [ImageProtocol]) -> [Int: [ImageProtocol]] {
        var albumsDict = [Int: [ImageProtocol]]()
        for item in images {
            if var array = albumsDict[item.albumId] {
                array.append(item)
                albumsDict[item.albumId] = array
            } else {
                albumsDict[item.albumId] = [item]
            }
        }
        return albumsDict
    }

    /// number of sections in tableView
    ///
    /// - Returns: `Int`
    func numberOfSections() -> Int {
        return state.value.allAlbums().count
    }

    /// number of rows for a given section
    ///
    /// - Parameter forSection: section index
    /// - Returns: `Int`
    func numberOfRows(forSection: Int) -> Int {
        guard let alubmID = albumID(forSection: forSection) else {
            return 0
        }
        return state.value.images(forAlbum: alubmID).count
    }

    /// title at an index
    ///
    /// - Parameter forIndex: indexPath
    /// - Returns: `String`
    func title(forIndex: IndexPath) -> String {
        guard let image = imageAtIndex(forIndex: forIndex) else {
            return ""
        }
        return image.title
    }

    /// title for section
    ///
    /// - Parameter forSection: Int
    /// - Returns: optional String
    func title(forSection: Int) -> String? {
        guard let albumID = albumID(forSection: forSection) else {
            return nil
        }
        return "Album \(albumID)"
    }

    /// helper method to get album ID for
    ///
    /// - Parameter forSection: Int
    /// - Returns: ablum Id if a valid index is passed else nil
    func albumID(forSection: Int) -> Int? {
        guard numberOfSections() > forSection else {
            return nil
        }
        return state.value.allAlbums()[forSection]
    }

    /// get Image for a given URL
    ///
    /// - Parameter forUrl: an image URL
    /// - Returns: Single<UIImage?>
    func getThumbnailImage(forIndex: IndexPath) -> Single<UIImage?> {
        guard let image = imageAtIndex(forIndex: forIndex) else {
            return Single.just(nil)
        }
        return apiClient.image(forUrl: image.thumbnailUrl)
    }

    /// a helper method to find the Image object at an index, return nil if index is out of bound
    private func imageAtIndex(forIndex: IndexPath) -> ImageProtocol? {
        guard let alubmID = albumID(forSection: forIndex.section) else {
            return nil
        }
        let albumImages = state.value.images(forAlbum: alubmID)
        guard albumImages.count > forIndex.row else {
            return nil
        }
        return albumImages[forIndex.row]
    }

    /// selection event
    ///
    /// - Parameter index: IndexPath
    func select(index: IndexPath) {
        if let image = imageAtIndex(forIndex: index) {
            selectionClosure(image)
        }
    }
}
