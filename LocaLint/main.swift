//
//  main.swift
//  LocaLint
//
//  Created by Vincent on 08/05/2018.
//  Copyright © 2018 Vincent. All rights reserved.
//

import Foundation

guard let configuration = FileManager.default.loadConfiguration() else { fatalError("No configuration file found.") }

configuration.targets.forEach { target in
    LocalizableLinter(from: target)?.lint()
}
