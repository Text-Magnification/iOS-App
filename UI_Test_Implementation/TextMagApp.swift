//
//  TextMagApp.swift
//  TextMag
//
//  Created by Justin Lu on 2/17/24.
//

import SwiftUI

struct TextMagApp: App {
    
    @StateObject private var vm = AppViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(vm)
                .task {
                    await vm.requestDataScannerAccessStatus() // Invoked on app launch
                }
        }
    }
}
