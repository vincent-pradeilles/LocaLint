//
//  LinterConfiguration.swift
//  LocaLint
//
//  Created by Vincent on 08/05/2018.
//  Copyright © 2018 Vincent. All rights reserved.
//

import Foundation

struct TargetConfiguration: Decodable {
    let name: String
    
    let swiftFilesDirectoriesRelativePaths: [String]
    let localizableFileRelativePath: String
    
    let localizationPattern: String?
}

struct LinterConfiguration: Decodable {
    let targets: [TargetConfiguration]
}
