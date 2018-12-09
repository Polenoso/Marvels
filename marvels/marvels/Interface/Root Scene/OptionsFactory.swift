//
//  OptionsFactory.swift
//  marvels
//
//  Created by Aitor Pagán on 09/12/2018.
//  Copyright © 2018 Aitor Pagán. All rights reserved.
//

import UIKit

struct OptionsData {
    let title: String
    let viewController: UIViewController
}

class OptionsFactory: NSObject {
    
    private static var options: [UIViewController.Type] = [SeriesViewController.self]
    
    static func makeAvailableOptions() -> [OptionsData] {
        var optionsData: [OptionsData] = []
        for type in OptionsFactory.options {
            if let (title,vc) = OptionsFactory.instantiateVC(type), vc != nil {
                optionsData.append(OptionsData(title: title, viewController: vc!))
            }
        }
        
        return optionsData
    }
    
    private static func instantiateVC(_ type:UIViewController.Type) -> (String,UIViewController?)? {
        
        if type == SeriesViewController.self {
            let storyboard = UIStoryboard.init(name: "SeriesScene", bundle: Bundle.main)
            let vc = storyboard.instantiateViewController(withIdentifier: "SeriesViewController")
            return ("Marvel Series", vc)
        }
        
        return nil
    }
}
