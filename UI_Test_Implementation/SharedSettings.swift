//
//  SharedSettings.swift
//  UI_Test_Implementation
//
//  Created by Justin Lu on 3/5/24.
//

import Foundation
class SharedSettings: ObservableObject {
    @Published var multipleItems:Bool = false
    @Published var experimentalMode:Bool = false
}
