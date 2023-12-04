//
//  Helper.swift
//  Breakout
//
//  Created by Tenzin Norden on 12/3/23.
//

import Foundation

// level file names
let lvl1 = "level_1"
let lvl2 = "level_2"

let lvlList = [lvl1, lvl2]

enum Brick: String {
    case b = "bluebrick"
    case r = "redbrick"
    case y = "yellowbrick"
    case x = "space"
}

func readTextFile(named fileName: String) -> String {
    if let fileURL = Bundle.main.url(forResource: fileName, withExtension: "txt") {
        do {
            let fileContents = try String(contentsOf: fileURL)
            return fileContents
        } catch {
            return "Error reading file: \(error.localizedDescription)"
        }
    } else {
        return "File not found"
    }
}
