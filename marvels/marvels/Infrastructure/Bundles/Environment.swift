//
//  Environment.swift
//  marvels
//
//  Created by Aitor Pagán on 06/12/2018.
//  Copyright © 2018 Aitor Pagán. All rights reserved.
// source Code from https://medium.freecodecamp.org/managing-different-environments-and-configurations-for-ios-projects-7970327dd9c9
//

import Foundation

public enum PlistKey : String {
    case marvelBaseUrl = "marvel_base_url"
    case marvelApiKey = "marvel_api_key"
    case marvelPrivateKey = "marvel_private_key"
    case marvelApiVersion = "marvel_api_version"
}
public struct Environment {
    
    fileprivate static var infoDict: [String: Any]  {
        get {
            if let dict = Bundle.main.infoDictionary {
                return dict
            }else {
                fatalError("Plist file not found")
            }
        }
    }
    public static func configuration(_ key: PlistKey) -> String {
        switch key {
        case .marvelApiKey:
            return infoDict[PlistKey.marvelApiKey.rawValue] as! String
        case .marvelPrivateKey:
            return infoDict[PlistKey.marvePrivateKey.rawValue] as! String
        case .marvelBaseUrl:
            return infoDict[PlistKey.marvelBaseUrl.rawValue] as! String
        case .marvelApiVersion:
            return infoDict[PlistKey.marvelApiVersion.rawValue] as! String
        }
    }
}
