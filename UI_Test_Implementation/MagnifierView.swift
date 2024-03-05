import SwiftUI

struct MagnifierView: View {
    @StateObject private var viewModel = AppViewModel()

    var body: some View {
        ScannerHudView()
            .environmentObject(viewModel)
            .task {
                await viewModel.requestDataScannerAccessStatus() // Invoked on app launch
            }
    }
}

struct MagnifierView_Previews: PreviewProvider {
    static var previews: some View {
        MagnifierView()
    }
}
