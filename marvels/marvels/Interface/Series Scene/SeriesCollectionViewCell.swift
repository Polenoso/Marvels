//
//  SeriesCollectionViewCell.swift
//  marvels
//
//  Created by Aitor Pagán on 08/12/2018.
//  Copyright © 2018 Aitor Pagán. All rights reserved.
//

import UIKit
import Kingfisher

class SeriesCollectionViewCell: UICollectionViewCell {
    
    static let nibName = "SeriesCollectionViewCell"
    static let reuseIdentifier = "SeriesCollectionViewCellReusableIdentifier"
    
    @IBOutlet var backgroundContainerView: UIView!
    @IBOutlet var serieImageView: UIImageView!
    @IBOutlet var serieTitleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundContainerView.applyRadius(with: 8.0, border: 0.0, color: UIColor.black)
        self.applyShadow(with: UIColor.black, offset: CGSize(width: 0, height: 10), radius: 4.0, opacity: 0.5)
    }
    
    func updateUI(item: SeriesModels.GetSeries.Displayed) {
        serieTitleLabel.text = item.title
        serieImageView.setImage(url: item.image)
    }

}
