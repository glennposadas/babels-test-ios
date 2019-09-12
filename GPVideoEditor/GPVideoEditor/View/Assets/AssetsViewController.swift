//
//  AssetsViewController.swift
//  GPVideoEditor
//
//  Created by Glenn Posadas on 11/09/2019.
//  Copyright © 2019 Glenn Posadas. All rights reserved.
//

import Photos
import UIKit

/** The camera roll screen. Contains the Photos and Videos from the device.
 */
class AssetsViewController: GPViewController {

    // MARK: - Properties
    
    private var viewModel: AssetsViewModel!
    
    // MARK: - Functions
    // MARK: Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel = AssetsViewModel(assetsController: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel.viewWillAppear()
    }
}

// MARK: - AssetsDelegate

extension AssetsViewController: AssetsDelegate {
    func assetsViewModel(_ viewModel: AssetsViewModel, loadedNewAssets assets: [PHAsset]) {
        
    }
}
