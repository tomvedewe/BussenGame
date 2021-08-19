//
//  StringExtension.swift
//  Bussen
//
//  Created by Tom Van der Weeën on 12/08/2021.
//

import Foundation

extension String {
    func localized() -> String {
        return NSLocalizedString(self, tableName: "Localizable", bundle: .main, value: self, comment: self)
    }
}
