//
//  ViewMode.swift
//  Breakout
//
//  Created by Tenzin Norden on 12/3/23.
//

import Foundation
import SwiftUI

@Observable
class GameState {
    var currentLvl = 0
    var isGameWon: Bool = false
    var isGameOver: Bool = false
    var navigationPath = NavigationPath()
}
