//
//  StringFile.swift
//  LocaLint
//
//  Created by Vincent on 08/05/2018.
//  Copyright © 2018 Vincent. All rights reserved.
//

import Foundation

struct StringFile {
    
    typealias LocalizedString = (key: String, value: String)
    
    let localizedStrings: [LocalizedString]
    
    init?(fileURL: URL) {
        guard let fileContent = try? String(contentsOf: fileURL),
            let regex = try? NSRegularExpression(pattern: "\"(.*)\"[ ]*=[ ]*\"(.*)\";", options: [])else { return nil }
        
        let lines = fileContent.components(separatedBy: .newlines)
        
        self.localizedStrings = lines.map { line -> LocalizedString? in
            
            guard let match = regex.firstMatch(in: line,
                                               options: [],
                                               range: NSRange(location: 0, length: line.count)),
                match.numberOfRanges == 3 else { return nil }
            
            let keyRange = match.range(at: 1)
            let valueRange = match.range(at: 2)
            
            let key = (line as NSString).substring(with: keyRange)
            let value = (line as NSString).substring(with: valueRange)
            
            return LocalizedString(key: key, value: value)
            }.compactMap { $0 }
    }
    
    func isKeyDefined(_ key: String) -> Bool {
        return localizedStrings.contains(where: { $0.key == key })
    }
}
