//
//  TypiImageCollectionViewHeader.swift
//  TypiCodeImages
//
//  Created by Sanwal, Manish on 3/20/19.
//  Copyright © 2019 Sanwal. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class TypiImageCollectionViewHeader: UICollectionReusableView {
    let label: UILabel = {
       let lbl = UILabel(frame: CGRect.zero)
        lbl.font = UIFont.boldSystemFont(ofSize: 18)
        lbl.textAlignment = .center
        return lbl
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(label)
        label.snp.makeConstraints { make in
            make.edges.equalTo(self.snp.edges)
        }
        self.backgroundColor = .clear
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
