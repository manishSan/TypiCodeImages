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

class TypiImageDetailViewController: UIViewController {

    let imageView = UIImageView(frame: CGRect.zero)

    let viewModel: TypiImageDetailViewModelProtocol

    init(viewModel: TypiImageDetailViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
         super.viewDidLoad()

    }

    func setUpUI() {
//        self.imageView.image = viewModel.image.thumbnailUrl
    }

}
