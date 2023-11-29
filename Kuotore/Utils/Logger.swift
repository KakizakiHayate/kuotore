//
//  Logger.swift
//  Kuotore
//
//  Created by 柿崎逸 on 2023/11/29.
//

import Foundation
import os

public enum Logger {
    public static let standard: os.Logger = .init(
        subsystem: Bundle.main.bundleIdentifier!,
        category: LogCategory.standard.rawValue
    )
}

// MARK: - Privates
private enum LogCategory: String {
     case standard = "Standard"
}
