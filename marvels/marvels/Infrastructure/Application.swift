//
//  Application.swift
//  marvels
//
//  Created by Aitor Pagán on 06/12/2018.
//  Copyright © 2018 Aitor Pagán. All rights reserved.
//

import Foundation
import UIKit

enum ApplicationConstants: Double {
    case initializationTimeout = 10.0
}

public final class Application {
    
    static var shared: Application = Application()
    
    private init(){}
    
    func configure(_ window: UIWindow?) {
        //Animate launch screen
        let launchStoryBoard = UIStoryboard(name: "LaunchScreenScene", bundle: Bundle.main)
        let launchController = launchStoryBoard.instantiateInitialViewController() as! LaunchScreenViewController
        window?.rootViewController = launchController
        window?.makeKeyAndVisible()
        
        launchController.startAnimating()
        self.loadInitialConfiguration { (completed, error) in
            if(completed) {
                self.loadRootController(window)
            } else {
                launchController.displayDiscardableAlertError(error!)
            }
        }
        
    }
    
    private func loadRootController(_ window: UIWindow?) {
        let rootStoryBoard = UIStoryboard(name: "RootScene", bundle: Bundle.main)
        let controller = rootStoryBoard.instantiateViewController(withIdentifier: "RootViewController")
        let nc = UINavigationController(rootViewController: controller)
        window?.rootViewController?.willMove(toParent: nil)
        window?.rootViewController?.removeFromParent()
        window?.rootViewController = nc
        window?.makeKeyAndVisible()
    }
    
    private func loadInitialConfiguration(_ completionBlock: @escaping (_ completed:Bool, _ error:Error?) -> ()) {
        let timer = Timer.scheduledTimer(withTimeInterval: ApplicationConstants.initializationTimeout.rawValue, repeats: false) { (_) in
            completionBlock(false, Errors.timeout("It took too much time to load, please try again with a better connection"))
        }
        
        doInitialTasks { (finished, error) in
            timer.invalidate()
            completionBlock(finished,error)
        }
    }
    
    private func doInitialTasks(_ block: @escaping (_ completed:Bool, _ error:Error?) -> ()) {
        //Load any initial data needed
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            block(true,nil)
        }
    }
}
