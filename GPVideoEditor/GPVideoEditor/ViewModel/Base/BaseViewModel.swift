//
//  BaseViewModel.swift
//  GPVideoEditor
//
//  Created by Glenn Posadas on 11/09/2019.
//  Copyright © 2019 Glenn Posadas. All rights reserved.
//

import UIKit

/**
 The Base Delegate of all ViewModels.
 */
@objc protocol BaseViewModelDelegate: class {
    /// Presents an alert/
    @objc optional func presentAlert(title: String, message: String, okayButtonTitle: String, cancelButtonTitle: String?, withBlock completion: GPViewController.GPAlertCallBack?)
}

/**
 The base viewModel of all viewModels.
 */
class BaseViewModel: NSObject {

}
