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
protocol AssetsDelegate: BaseViewModelDelegate {
    /// Newly loaded local assets.
    func assetsViewModel(_ viewModel: AssetsViewModel, loadedNewAssets assets: [PHAsset])
}

/** The viewModel of `AssetsViewController`.
 */
class AssetsViewModel: BaseViewModel {
    
    // MARK: - Properties
    
    private weak var delegate: AssetsDelegate?
    
    /**
     A tuple as a datasource.
     - 0 for the PHAsset object.
     - .1 isChecked.
     */
    private var assets = [PHAsset]()
    
    typealias EmptyCallBack = (() -> (Void))
    
    // MARK: - Functions
    
    /// Checks for authorization status.
    /// TODO: Redirect user to SETTINGS.
    private func checkAuthorizationForPhotoLibrary(_ completion: @escaping EmptyCallBack) {
        let status = PHPhotoLibrary.authorizationStatus()
        if (status == PHAuthorizationStatus.authorized) {
            // Access has been granted.
            completion()
        } else {
            PHPhotoLibrary.requestAuthorization { [weak self] status in
                switch status {
                case .authorized: completion()
                default: self?.delegate?.presentAlert?(
                    title: appName,
                    message: "We need your permission to access your camera roll.",
                    okayButtonTitle: "GO TO SETTINGS",
                    cancelButtonTitle: "CANCEL",
                    withBlock: nil
                    )
                }
            }
        }
    }
    
    /// Begin fetching local assets.
    private func getAssets() {
        self.checkAuthorizationForPhotoLibrary {
            let fetchOptions = PHFetchOptions()
            fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate",ascending: false)]
            fetchOptions.predicate = NSPredicate(format: "mediaType = %d || mediaType = %d", PHAssetMediaType.image.rawValue, PHAssetMediaType.video.rawValue)
            let imagesAndVideos = PHAsset.fetchAssets(with: fetchOptions)
            imagesAndVideos.enumerateObjects({ (asset, _, _) in
                self.assets.append(asset)
            })
            self.delegate?.assetsViewModel(self, loadedNewAssets: [])
            print("asset ocunt: \(self.assets.count)")
        }
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

// MARK: - UICollectionViewDelegate

extension AssetsViewModel: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}


// MARK: - UICollectionViewDataSource

extension AssetsViewModel: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell: AssetCollectionViewCell?
        cell = collectionView.dequeueReusableCell(withReuseIdentifier: AssetCollectionViewCell.identifier, for: indexPath) as? AssetCollectionViewCell
        
        if cell == nil { cell = AssetCollectionViewCell() }
        
        let item = indexPath.item
        let asset = self.assets[item]
        cell?.setupCell(asset, isChecked: false)
        
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.assets.count
    }
}
