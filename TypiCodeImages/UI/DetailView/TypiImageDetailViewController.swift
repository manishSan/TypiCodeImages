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

    let imageView = UIImageView(frame: CGRect.zero)

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
        imageView.image =  Asset.placeholder.image
        viewModel
            .getFullImage()
            .asDriver(onErrorJustReturn: nil)
            .drive(onNext: { [weak self] image in
                self?.imageView.image = image
            })
            .disposed(by: disposeBag)
    }

    func setUpConstraints() {
        imageView.snp.makeConstraints { make in
            make.edges.equalTo(view.snp.edges)
        }
    }
}
