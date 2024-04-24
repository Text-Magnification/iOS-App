//
//  SharedSettings.swift
//  UI_Test_Implementation
//
//  Created by Justin Lu on 3/5/24.
//

import Foundation
import SwiftUI

import Combine // DarkMode

class SharedSettings: ObservableObject {
    @Published var shouldRemoveOverlays = false
    @Published var isFrozen = false
    func toggleFreeze() {
        isFrozen.toggle()
    }
    
    @Published var multipleItems: Bool = false
    @Published var experimentalMode: Bool = true // I do not like having to do this every time
    
    //DarkMode
    @Published var isDarkModeEnabled: Bool = true {
        didSet {
            NotificationCenter.default.post(name: .didChangeDarkMode, object: nil)
        }
    }
    
    static let allFonts: [String] = UIFont.familyNames.flatMap { familyName -> [String] in
        UIFont.fontNames(forFamilyName: familyName).sorted()
    }
    @Published var fontChoice: UIFont = UIFont(name: "Helvetica-Bold", size: 19) ?? UIFont.systemFont(ofSize: 19)
    @Published var fontIndex: Int = 140 // Helvetica-Bold
    
    static let allFontSizes: [Int] = [14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28]
    @Published var fontSizeIndex: Int = 5 // Size 19
    @Published var fontSize: Int = 19
    
    static let allARColorStrings: [String] = ["White", "Black", "Red", "Blue", "Green", "Cyan", "Mint"]
    static let allARColors: [UIColor] = [.white, .black, .systemRed, .systemBlue, .systemGreen, .cyan, .systemMint]
    @Published var ARColorIndex: Int = 0 // White
    @Published var ARColor: UIColor = .white
    
    // MAIN THEME
    @Published var THEME = UIColor(red:7/255,green:90/255,blue:98/255,alpha:1)
    @Published var DARKTHEME = UIColor(red:42/255,green:42/255,blue:42/255,alpha:1)
    
    // ICON "LIGHT TOOTHPASTE" COLOR
    @Published var ICON = UIColor(red: 53/255, green: 194/255, blue: 192/255, alpha: 1)
    @Published var DARKICON = UIColor(red: 53/255, green: 194/255, blue: 192/255, alpha: 1)
    
    // COLORS FOR BUTTONS AND STUFF
    @Published var CUSTOMCYAN = UIColor(red: 62/255, green: 255/255, blue: 255/255, alpha: 1)
    @Published var CUSTOMWHITE = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
}

//DarkMode
extension Notification.Name {
    static let didChangeDarkMode = Notification.Name("didChangeDarkMode")
}
