//
//  StringFile.swift
//  LocaLint
//
//  Created by Vincent on 08/05/2018.
//  Copyright © 2018 Vincent. All rights reserved.
//

import Foundation

struct StringFile {
    let localizedStrings: [String: String]
    
    init?(fileURL: URL) {
        guard let fileContent = NSDictionary(contentsOf: fileURL) as? [String: String] else { return nil }
        
        self.localizedStrings = fileContent
    }
}
