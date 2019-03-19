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
}

struct TypiImageListViewModel: TypiImageListViewModelProtocol {
    let state: BehaviorRelay<TypiImageListState> = BehaviorRelay(value: .loading)

    let apiClient: ApiClientProtocol

    let disposeBag = DisposeBag()

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
        return imageAtIndex(forIndex: forIndex).title
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
        return apiClient.image(forUrl: imageAtIndex(forIndex: forIndex).thumbnailUrl)
    }

    private func imageAtIndex(forIndex: IndexPath) -> ImageProtocol {
        return state.value.images()[forIndex.row]
    }
}
