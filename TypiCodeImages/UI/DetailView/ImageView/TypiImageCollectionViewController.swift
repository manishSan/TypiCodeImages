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
import NVActivityIndicatorView

/// Image list view controller
class TypiImageCollectionViewController: UIViewController {
    /// viewModel
    let viewModel: TypiImageListViewModelProtocol

    /// tabelView
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.headerReferenceSize = CGSize(width: 400, height: 60)
        let collection = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collection.delegate = self
        collection.dataSource = self
        collection.register(TypiImageCollectionViewCell.self, forCellWithReuseIdentifier: "collectionViewImageCell")
        collection.register(TypiImageCollectionViewHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "collectionViewHeader")
        collection.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "collectionViewFooter")
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

    /// activit indicator
    let activityIndicator = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 20, height: 20),
                                                    type: NVActivityIndicatorType.ballRotateChase,
                                                    color: .black,
                                                    padding: nil)

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
        view.addSubview(activityIndicator)
        activityIndicator.center = view.center
        activityIndicator.stopAnimating()
    }

    /// setup constraints
    func setUpConstraints() {
        collectionView.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.leading).offset(2)
            make.trailing.equalTo(view.snp.trailing).offset(-2)
            make.top.equalTo(view.snp.top).offset(2)
            make.bottom.equalTo(view.snp.bottom).offset(-2)
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
            activityIndicator.startAnimating()
        case .error:
            activityIndicator.stopAnimating()
        case .ready:
            activityIndicator.stopAnimating()
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
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewImageCell", for: indexPath) as? TypiImageCollectionViewCell {
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
        return UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.select(index: indexPath)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 400, height: 40)
    }

    func collectionView(collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: 400, height: 10)
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            if let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "collectionViewHeader", for: indexPath) as? TypiImageCollectionViewHeader {
                headerView.label.text = viewModel.title(forSection: indexPath.section)
                return headerView
            }
        case UICollectionView.elementKindSectionFooter:
            return collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "collectionViewFooter", for: indexPath)
        default:
            return UICollectionReusableView()
        }
        return UICollectionReusableView()
    }
}

extension TypiImageCollectionViewController: UICollectionViewDelegate {}

extension TypiImageCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemsPerRow: CGFloat = 3
        let hardCodedPadding: CGFloat = 4
        let itemWidth = (collectionView.bounds.width / itemsPerRow) - hardCodedPadding * 2
        let itemHeight = itemWidth
        return CGSize(width: itemWidth, height: itemHeight)
    }
}
