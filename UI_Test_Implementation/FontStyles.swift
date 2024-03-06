//
//  FontStyles.swift
//  UI_Test_Implementation
//
//  Created by Daniel Iskandar on 2/18/24.
//

import Foundation
import SwiftUI

extension Font {
    
    static var navTitle: Font {
        
        return Font.custom("Circular", size: 20)
    }
    
    static var welcomeText: Font {
        
        return Font.custom("Circular", size: 45).bold()
    }
    
    static var welcomeTextSmall: Font {
        
        return Font.custom("Circular", size: 20)
    }
    
    static var continueText: Font {
        
        return Font.custom("Circular", size: 20)
    }
    
    static var aboutText: Font {
        
        return Font.custom("Circular", size: 20)
    }
    
    static var devTeamText: Font {
        return Font.custom("Inter-SemiBold", size: 32)
    }
    
    static var missionStatementText: Font {
        return Font.custom("Inter-SemiBold", size: 17)
    }
    
    static var descriptionText: Font {
        return Font.custom("Inter-Regular", size: 17)
    }
    
    static var collegeText: Font {
        return Font.custom("Inter-SemiBold", size: 17)
    }
    
    
    
    
    
}
