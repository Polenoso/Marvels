//
//  String+Tools.swift
//  marvels
//
//  Created by Aitor Pagán on 06/12/2018.
//  Copyright © 2018 Aitor Pagán. All rights reserved.
//

import Foundation
import CryptoSwift

extension String {
    func md5Digest() -> String {
        return self.md5()
    }
}
