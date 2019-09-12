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
    private var datasource = [(PHAsset, Bool)]()
    
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
            imagesAndVideos.enumerateObjects({ (asset, index, _) in
                print("index: \(index)")
                self.datasource.append((asset, false))
            })
            self.delegate?.assetsViewModel(self, loadedNewAssets: [])
            print("newAssets: \(self.datasource.count)")
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

// MARK: - UICollectionViewDelegateFlowLayout

extension AssetsViewModel: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfColumns: CGFloat = 3.0
        let screenWidth: CGFloat = UIScreen.main.bounds.width
        let spacing: CGFloat = 2.0
        return CGSize(width: (screenWidth / numberOfColumns) - spacing , height: 220.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2.0
    }
}

// MARK: - UICollectionViewDelegate

extension AssetsViewModel: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = indexPath.item
        let asset = self.datasource[item].0
        self.datasource[item].1 = !self.datasource[item].1
        
        if let cell = collectionView.cellForItem(at: indexPath) as? AssetCollectionViewCell {
            cell.setupCell(asset, isChecked: self.datasource[item].1)
        }
    }
}


// MARK: - UICollectionViewDataSource

extension AssetsViewModel: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell: AssetCollectionViewCell?
        cell = collectionView.dequeueReusableCell(withReuseIdentifier: AssetCollectionViewCell.identifier, for: indexPath) as? AssetCollectionViewCell
        
        if cell == nil { cell = AssetCollectionViewCell() }
        
        let item = indexPath.item
        let asset = self.datasource[item].0
        let isChecked = self.datasource[item].1
        cell?.setupCell(asset, isChecked: isChecked)
        
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.datasource.count
    }
}
