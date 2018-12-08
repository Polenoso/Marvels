//
//  UIViewController+Display.swift
//  marvels
//
//  Created by Aitor Pagán on 07/12/2018.
//  Copyright © 2018 Aitor Pagán. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    static let loadingViewTag = 1919
    
    func displayDiscardableAlertError(_ error: Error) {
        
        displayErrorMessage(error.localizedDescription, title: "")
    }
    
    func displayErrorMessage(_ error: String?, title: String?) {
        let alert = UIAlertController(title: title, message: error, preferredStyle: .alert)
        let action = UIAlertAction(title: "ok", style: .default, handler: nil)
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    func displayLoading() {
        let view = UIView(frame: self.view.bounds)
        view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        view.tag = UIViewController.loadingViewTag
        let progressView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.white)
        view.addSubview(progressView)
        progressView.center = view.center
        self.view.addSubview(view)
        progressView.startAnimating()
    }
    
    func hideLoading() {
        if let view = self.view.viewWithTag(UIViewController.loadingViewTag) {
            view.removeFromSuperview()
        }
    }
}
