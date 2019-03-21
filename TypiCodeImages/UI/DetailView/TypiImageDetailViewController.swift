//
//  TypiImageDetailViewController.swift
//  TypiCodeImages
//
//  Created by Sanwal, Manish on 3/19/19.
//  Copyright © 2019 Sanwal. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import RxSwift

class TypiImageDetailViewController: UIViewController {

    let titleLabel: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    let albumLabel: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()

    let imageView: UIImageView = {
        let view = UIImageView(frame: CGRect.zero)
        view.contentMode = .scaleAspectFit
        return view
    }()

    let viewModel: TypiImageDetailViewModelProtocol

    let disposeBag = DisposeBag()

    init(viewModel: TypiImageDetailViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        setUpConstraints()
    }

    func setUpUI() {
        view.addSubview(imageView)
        view.backgroundColor = .white
        imageView.image =  Asset.placeholder.image
        viewModel
            .getFullImage()
            .asDriver(onErrorJustReturn: nil)
            .drive(onNext: { [weak self] image in
                self?.imageView.image = image
            })
            .disposed(by: disposeBag)

        titleLabel.text = viewModel.image.title
        view.addSubview(titleLabel)
    }

    func setUpConstraints() {
        imageView.snp.makeConstraints { make in
            make.center.equalTo(view.snp.center)
            make.width.equalTo(view.snp.width)
        }

        titleLabel.snp.makeConstraints { make in
            make.width.equalTo(view.snp.width).offset(-20)
            make.bottom.equalTo(view.snp.bottom).offset(-40)
            make.left.equalTo(view.snp.left).offset(10)
        }
    }
}
