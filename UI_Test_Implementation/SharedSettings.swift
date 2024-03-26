//
//  SharedSettings.swift
//  UI_Test_Implementation
//
//  Created by Justin Lu on 3/5/24.
//

import Foundation
import SwiftUI

class SharedSettings: ObservableObject {
    @Published var multipleItems: Bool = false
    @Published var experimentalMode: Bool = true // I do not like having to do this every time
    @Published var isDarkModeEnabled: Bool = true
    
    
    static let allFonts: [String] = UIFont.familyNames.flatMap { familyName -> [String] in
        UIFont.fontNames(forFamilyName: familyName).sorted()
    }
    
    static let allFontSizes: [Int] = [14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28]
    
    @Published var fontChoice: UIFont = UIFont(name: "Helvetica", size: 19) ?? UIFont.systemFont(ofSize: 19)
    @Published var fontIndex: Int = 139
    
    @Published var fontSizeIndex: Int = 5 // Size 19, 0 = sixe 14
    @Published var fontSize: Int = 19
}
