//
//  GPViewController.swift
//  GPVideoEditor
//
//  Created by Glenn Posadas on 11/09/2019.
//  Copyright © 2019 Glenn Posadas. All rights reserved.
//

import UIKit

/** The base controller. Contains some common methods used across the app.
 */
class GPViewController: UIViewController {

    // MARK: - Properties
    
    /// The completion callback for the ```alert```.
    typealias GPAlertCallBack = ((_ userDidTapOk: Bool) -> Void)
    
    // MARK: - Functions
    
    /**
     Presents an alertController with completion.
     - parameter title: The title of the alert.
     - parameter message: The body of the alert, nullable, since we can just sometimes use the title parameter.
     - parameter okButtonTitle: the title of the okay button.
     - parameter cancelButtonTitle: The title of the cancel button, defaults to nil, nullable.
     - parameter completion: The `GPAlertCallBack`, returns Bool. True when the user taps on the OK button, otherwise false.
     */
    func alert(
        title: String,
        message: String? = nil,
        okayButtonTitle: String,
        cancelButtonTitle: String? = nil,
        withBlock completion: GPAlertCallBack?) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: okayButtonTitle, style: .default) { _ in
            completion?(true)
        }
        alertController.addAction(okAction)
        
        if let cancelButtonTitle = cancelButtonTitle {
            let cancelAction = UIAlertAction(title: cancelButtonTitle, style: .default) { _ in
                completion?(false)
            }
            alertController.addAction(cancelAction)
        }
        
        alertController.view.tintColor = .black
        present(alertController, animated: true, completion: nil)
    }
    
    // MARK: Navigation Bar Utilities
    
    /// Shows the navigation bar.
    func showNavBar(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    /// Hides the navigation bar.
    func hideNavBar(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    // MARK: Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

// MARK: - BaseViewModelDelegate

extension GPViewController: BaseViewModelDelegate {
    func presentAlert(title: String, message: String, okayButtonTitle: String, cancelButtonTitle: String?, withBlock completion: GPViewController.GPAlertCallBack?) {
        DispatchQueue.main.async {
            self.alert(title: title, message: message, okayButtonTitle: okayButtonTitle, cancelButtonTitle: cancelButtonTitle, withBlock: completion)
        }
    }
}
