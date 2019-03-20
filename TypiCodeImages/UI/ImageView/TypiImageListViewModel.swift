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
    case ready([ImageProtocol])
    case error(String)

    func images() -> [ImageProtocol] {
        switch self {
        case .loading, .error:
            return [ImageProtocol]()
        case .ready(let images):
            return images
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
                    self.state.accept(.ready(updatedImages))
                case .failure(let error):
                    self.state.accept(.error(error.message))
                }
            })
            .disposed(by: disposeBag)
    }

    /// number of sections in tableView
    ///
    /// - Returns: `Int`
    func numberOfSections() -> Int {
        return 1
    }

    /// number of rows for a given section
    ///
    /// - Parameter forSection: section index
    /// - Returns: `Int`
    func numberOfRows(forSection: Int) -> Int {
        return state.value.images().count
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
        return "Album"
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
        guard state.value.images().count > forIndex.row else {
            return nil
        }
        return state.value.images()[forIndex.row]
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
