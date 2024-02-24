//
//  MagnifierView.swift
//  UI_Test_Implementation
//
//  Created by Daniel Iskandar on 2/21/24.
//

import SwiftUI

struct MagnifierView: View {
    @StateObject private var viewModel = AppViewModel()

    var body: some View {
        jContentView()
            .environmentObject(viewModel)
            .task {
                await viewModel.requestDataScannerAccessStatus() // Invoked on app launch
            }

//        jContentView()
//            .environmentObject(viewModel)
//            .onAppear {
//                // Request camera and scanner access when the view appears
//                task {
//                    await viewModel.requestDataScannerAccessStatus() // Invoked on app launch
//                }
//            }
    }
}

struct MagnifierView_Previews: PreviewProvider {
    static var previews: some View {
        MagnifierView()
    }
}
