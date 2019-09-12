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
    @IBOutlet weak var label_NavBarTitle: UILabel!
    @IBOutlet weak var label_ToolBarTitle: UILabel!
    @IBOutlet weak var view_NavBarContainer: UIView!
    @IBOutlet weak var view_ToolBarContainer: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Functions
    
    private func setupBindings() {
        self.collectionView.delegate = self.viewModel
        self.collectionView.dataSource = self.viewModel
    }
    
    private func setupUI() {
        self.view_NavBarContainer.backgroundColor = .white
        self.view_ToolBarContainer.backgroundColor = .white
        
        // TODO: Localize.
        self.label_NavBarTitle.text = "Camera Roll"
        self.label_ToolBarTitle.text = "Edit Video"
    }
    
    // MARK: Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel = AssetsViewModel(assetsController: self)
        self.setupUI()
        self.setupBindings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel.viewWillAppear()
    }
}

// MARK: - AssetsDelegate

extension AssetsViewController: AssetsDelegate {
    func assetsViewModel(_ viewModel: AssetsViewModel, loadedNewAssets assets: [PHAsset]) {
        // TODO: Perhaps use diff algorithm?
        print("loadedNewAssets...")
        self.collectionView.reloadData()
    }
}
