//
//  StringExt.swift
//  BBquotes
//
//  Created by Yaakov Haimoff on 12.11.2025.
//

import Foundation

extension String {
    func removeSpaces() -> String {
        self.replacingOccurrences(of: " " as String, with: "")
    }
    
    func removeSpacesAndCaces() -> String {
        self.removeSpaces().lowercased()
    }
}
