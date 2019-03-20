//
//  TypiImageCollectionViewController.swift
//  TypiCodeImages
//
//  Created by manish on 3/19/19.
//  Copyright © 2019 Sanwal. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import SnapKit

/// Image list view controller
class TypiImageCollectionViewController: UIViewController {
    /// viewModel
    let viewModel: TypiImageListViewModelProtocol

    /// tabelView
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 75, height: 75)
        let collection = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        //collection.delegate = self
        collection.dataSource = self
        collection.register(TypiImageCollectionViewCell.self, forCellWithReuseIdentifier: "collectionViewImageCell")
        collection.refreshControl = self.refreshControl
        collection.backgroundColor = .white
        return collection
    }()

    /// refresg control
    lazy var refreshControl: UIRefreshControl = {
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(refreshImages(_:)), for: .valueChanged)
        return refresh
    }()

    /// dispose bag
    let disposeBag = DisposeBag()

    /// initializer
    ///
    /// - Parameter viewModel: viewModel
    init(viewModel: TypiImageListViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// viewDidLoad override
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchImageList()
        setupView()
        setUpConstraints()
        bindView()
    }

    /// setUpview
    func setupView() {
        self.edgesForExtendedLayout = []
        view.addSubview(collectionView)
    }

    /// setup constraints
    func setUpConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.snp.edges)
        }
    }

    /// bind view model upates to the UI
    func bindView() {
        viewModel
            .state
            .asDriver()
            .drive(onNext: { [weak self] state in
                self?.handle(state: state)
            })
            .disposed(by: disposeBag)
    }

    /// react to the state chanegs.
    ///
    /// - Parameter state: `TypiImageListState`
    func handle(state: TypiImageListState) {
        switch state {
        case .loading:
            break
        case .error:
            break
        case .ready:
            self.collectionView.reloadData()
        }
        self.refreshControl.endRefreshing()
    }

    /// refresh images
    ///
    /// - Parameter _: sender
    @objc func refreshImages(_ sender: Any) {
        viewModel.fetchImageList()
    }
}

extension TypiImageCollectionViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.numberOfSections()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return viewModel.numberOfRows(forSection: section)

    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewImageCell", for: indexPath) as! TypiImageCollectionViewCell
        cell.imageView.image = Asset.placeholder.image
        cell.imageView.contentMode = .scaleAspectFill
        viewModel
            .getThumbnailImage(forIndex: indexPath)
            .asDriver(onErrorJustReturn: nil)
            .drive(onNext: { image in
                cell.imageView.image = image
            })
            .disposed(by: disposeBag)

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 150)
//        let itemsPerRow: CGFloat = 5
//        let hardCodedPadding: CGFloat = 1
//        let itemWidth = (collectionView.bounds.width / itemsPerRow) - hardCodedPadding
//        let itemHeight = itemWidth
//        return CGSize(width: itemWidth, height: itemHeight)
    }
}
