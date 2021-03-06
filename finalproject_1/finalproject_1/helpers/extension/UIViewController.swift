//
//  UIViewController.swift
//  finalproject_1
//
//  Created by Mai on 24/1/2564 BE.
//  Copyright © 2564 BE ICTSUIM. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showLoading() {
        utilities.showLoading()
    }
    
    func hideLoading() {
        utilities.hideLoading()
    }
    
    func showAlert(message: String?, title: String? = nil) {
        let alert = UIAlertController(title: title ?? Message.alert.title, message: message ?? "", preferredStyle: .alert)
        let okAction = UIAlertAction(title: Message.button.ok, style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    func showConfirm(message: String?, title: String? = nil, confirmButtonTitle: String? = nil, handler: ((UIAlertAction) -> Void)? = nil, cancelHandler: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: title ??  Message.alert.title, message: message ?? "", preferredStyle: .alert)
        let okAction = UIAlertAction(title: confirmButtonTitle ?? Message.button.ok, style: .default, handler: handler)
        let cancelAction = UIAlertAction(title: Message.button.cancel, style: .default, handler: cancelHandler)
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}

