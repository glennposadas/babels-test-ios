//
//  AssetsViewModel.swift
//  GPVideoEditor
//
//  Created by Glenn Posadas on 11/09/2019.
//  Copyright © 2019 Glenn Posadas. All rights reserved.
//

import Photos
import UIKit

/** The protocol of `AssetsViewModel`.
 */
protocol AssetsDelegate: class {
    /// Newly loaded local assets.
    func assetsViewModel(_ viewModel: AssetsViewModel, loadedNewAssets assets: [PHAsset])
}

/** The viewModel of `AssetsViewController`.
 */
class AssetsViewModel: BaseViewModel {

    // MARK: - Properties
    
    private weak var delegate: AssetsDelegate?
    
    private var assets = [PHAsset]()
    
    // MARK: - Functions
    
    /// Begin fetching local assets.
    private func getAssets() {
        //let fetcher = PHAsset.fetchAssets(with: PHAssetMediaType.image, options: <#T##PHFetchOptions?#>)
        //todo: use predicate instead.
    }
    
    init(assetsController: AssetsDelegate?) {
        super.init()
        
        self.delegate = assetsController
    }
    
    /// Invoked by controller's life cycle viewWillAppear.
    /// It's best to relaod the local assets each time the screen appears.
    func viewWillAppear() {
        self.getAssets()
    }
}
