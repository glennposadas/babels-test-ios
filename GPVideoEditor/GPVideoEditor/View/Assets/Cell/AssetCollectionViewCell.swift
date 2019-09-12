//
//  AssetCollectionViewCell.swift
//  GPVideoEditor
//
//  Created by Glenn Posadas on 12/09/2019.
//  Copyright © 2019 Glenn Posadas. All rights reserved.
//

import Photos
import UIKit

class AssetCollectionViewCell: GPCollectionViewCell {
    
    // MARK: - Properties
    
    @IBOutlet weak var imageView_Thumbnail: UIImageView!
    @IBOutlet weak var imageView_Checkmark: UIImageView!
    @IBOutlet weak var label_Duration: UILabel!
    
    // MARK: - Functions
    
    func setupCell(_ asset: PHAsset, isChecked: Bool) {
        self.imageView_Thumbnail.image = asset.thumbnail
        self.label_Duration.text = asset.durationRepresentable
        self.imageView_Checkmark.isHidden = !isChecked
    }
    
    // MARK Overrides
    // ---
}
