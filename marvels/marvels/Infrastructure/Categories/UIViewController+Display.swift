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
    
    func displayDiscardableAlertError(_ error: Error) {
        
        let alert = UIAlertController(title: "", message: error.localizedDescription, preferredStyle: .alert)
        let action = UIAlertAction(title: "ok", style: .default, handler: nil)
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
}
