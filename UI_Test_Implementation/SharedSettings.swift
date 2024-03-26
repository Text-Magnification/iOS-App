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
    
    @Published var fontChoice: UIFont = UIFont(name: "Helvetica", size: 19) ?? UIFont.systemFont(ofSize: 19)
    @Published var fontIndex: Int = 0
    
}
