//
//  FileManager+Extension.swift
//  LocaLint
//
//  Created by Vincent on 08/05/2018.
//  Copyright © 2018 Vincent. All rights reserved.
//

import Foundation

extension FileManager {
    func URLsForSwiftFiles(in path: String) -> [URL] {
        guard let baseURL = URL(string: path, relativeTo: URL(string: self.currentDirectoryPath)) else { return [] }
        
        let enumerator = FileManager.default.enumerator(at: baseURL,
                                                        includingPropertiesForKeys: nil,
                                                        options: [.skipsHiddenFiles],
                                                        errorHandler: nil)!
        
        var swiftFilesURLs = [URL]()
        
        for case let fileURL as URL in enumerator {
            if fileURL.pathExtension.uppercased() == "SWIFT" {
                swiftFilesURLs.append(fileURL)
            }
        }
        
        return swiftFilesURLs
    }
    
    func loadConfiguration() -> LinterConfiguration? {
        let currentDirectoryURL = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
        let localizableFileURL = URL(fileURLWithPath: "LocaLint.json", relativeTo: currentDirectoryURL)
        
        guard let configurationFileData = try? Data(contentsOf: localizableFileURL) else { return nil }
        
        return try? JSONDecoder().decode(LinterConfiguration.self, from: configurationFileData)
    }
}
