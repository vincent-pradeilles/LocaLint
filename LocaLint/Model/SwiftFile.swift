//
//  SwiftFile.swift
//  LocaLint
//
//  Created by Vincent on 08/05/2018.
//  Copyright © 2018 Vincent. All rights reserved.
//

import Foundation

struct SwiftFile {
    
    static let defaultPattern = "NSLocalizedString\\([key:]{0,1}[ ]*\"(.*)\"*\\)"
    
    let fileName: String
    let localizedKeys: [String]
    
    init?(fileURL: URL, pattern: String = SwiftFile.defaultPattern) {
        guard let fileContent = try? String(contentsOf: fileURL),
            let regex = try? NSRegularExpression(pattern: pattern, options: []) else { return nil }
        
        let lines = fileContent.components(separatedBy: .newlines)
        
        self.fileName = fileURL.lastPathComponent
        self.localizedKeys = lines.map { line -> [String]? in
            
            guard let match = regex.firstMatch(in: line,
                                               options: [],
                                               range: NSRange(location: 0, length: line.count)),
                match.numberOfRanges > 0 else { return nil }
            
            var results = [String]()
            for i in 1..<match.numberOfRanges {
                let range = match.range(at: i)
                results.append(String((line as NSString).substring(with: range).prefix(while: { $0 != "\"" })))
            }
            
            return results
            }.compactMap { $0 }.flatMap { $0 }
    }
}
