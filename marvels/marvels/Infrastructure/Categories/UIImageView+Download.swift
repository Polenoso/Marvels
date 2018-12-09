//
//  UIImageView+Download.swift
//  marvels
//
//  Created by Aitor Pagán on 08/12/2018.
//  Copyright © 2018 Aitor Pagán. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    
    fileprivate static func placeholder() -> UIImage {
        let image = #imageLiteral(resourceName: "empty")
        return image
    }
    
    func setImage(url: URL?) {
        self.kf.setImage(with: url, placeholder: UIImageView.placeholder(), options: nil, progressBlock: nil, completionHandler: nil)
    }
}
