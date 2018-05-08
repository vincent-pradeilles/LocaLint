//
//  Sequence+Extension.swift
//  LocaLint
//
//  Created by Vincent on 08/05/2018.
//  Copyright © 2018 Vincent. All rights reserved.
//

import Foundation

extension Sequence where Element: Equatable {
    func duplicatesRemoved() -> [Element] {
        return reduce([], { $0.contains($1) ? $0 : $0 + [$1] })
    }
}
