//
//  LocalizableLinter.swift
//  LocaLint
//
//  Created by Vincent on 08/05/2018.
//  Copyright © 2018 Vincent. All rights reserved.
//

import Foundation

struct LocalizableLinter {
    let targetConfiguration: TargetConfiguration
    
    let swiftFiles: [SwiftFile]
    let localizableFile: StringFile

    static func make(for target: TargetConfiguration) -> LocalizableLinter? {
        let currentDirectoryURL = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
        
        let swiftFilesURLs = target.swiftFilesDirectoriesRelativePaths.flatMap { FileManager.default.URLsForSwiftFiles(in: $0) }
        let localizableFileURL = URL(fileURLWithPath: target.localizableFileRelativePath, relativeTo: currentDirectoryURL)
        
        let swiftFiles = swiftFilesURLs.map { SwiftFile(fileURL: $0) }.compactMap { $0 }
        
        guard let stringFile = StringFile(fileURL: localizableFileURL) else { return nil }
        
        return LocalizableLinter(targetConfiguration: target,
                                 swiftFiles: swiftFiles,
                                 localizableFile: stringFile)
    }
    
    func lint() {
        print("Linting target \"\(targetConfiguration.name)\"")
        
        checkUsedKeysExist()
        checkExistingKeysAreUsed()
        checkDuplicateKeys()
    }
    
    private func checkUsedKeysExist() {
        swiftFiles.forEach { file in
            file.localizedKeys.forEach { key in
                if !localizableFile.isKeyDefined(key) {
                    print("🚨 \"\(key)\" used in \(file.fileName) does not exist")
                }
            }
        }
    }
    
    private func checkExistingKeysAreUsed() {
        localizableFile.localizedStrings.forEach { (key, _) in
            let keyIsUsedInOneFile = swiftFiles.map { $0.localizedKeys }.reduce(false) { $0 || $1.contains(key) }
            if !keyIsUsedInOneFile {
                print("⚠️ \"\(key)\" is never used")
            }
        }
    }
    
    private func checkDuplicateKeys() {
        let duplicateKeys = localizableFile.localizedStrings.map { $0.key }.filter { key in
            let occurencesOfKey = localizableFile.localizedStrings.reduce(0) { ($1.key == key) ? $0 + 1 : $0 }
            
            return occurencesOfKey > 1
        }
        
        duplicateKeys.duplicatesRemoved().forEach { key in
            print("🚨 \"\(key)\" has duplicate values")
        }
    }
}
