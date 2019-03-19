//
//  TypiImageViewController.swift
//  TypiCodeImages
//
//  Created by Sanwal, Manish on 3/19/19.
//  Copyright © 2019 Sanwal. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import SnapKit

/// Image list view controller
class TypiImageListViewController: UIViewController {
    /// viewModel
    let viewModel: TypiImageListViewModelProtocol

    /// tabelView
    var tableView = UITableView(frame: CGRect.zero)

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
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CellIdentifier")
        view.addSubview(tableView)
    }

    /// setup constraints
    func setUpConstraints() {
        tableView.snp.makeConstraints { make in
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
        case .error(let string):
            break
        case .ready:
            self.tableView.reloadData()
        }
    }
}

// MARK: - UITabelView delegate
extension TypiImageListViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(forSection: section)
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.title(forSection: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier", for: indexPath) as UITableViewCell
        cell.textLabel?.text = viewModel.title(forIndex: indexPath)
        cell.textLabel?.numberOfLines = 0
        cell.accessoryType = .disclosureIndicator
        viewModel
            .getThumbnailImage(forIndex: indexPath)
            .asDriver(onErrorJustReturn: nil)
            .drive(onNext: { image in
                cell.imageView?.image = image
            })
            .disposed(by: disposeBag)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
//        viewModel.select(index: indexPath)
    }
}
