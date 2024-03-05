import SwiftUI
import VisionKit

struct ScannerHudView: View {
    
    @EnvironmentObject var vm: AppViewModel
    
    private let textContentTypes: [(title: String, textContentType: DataScannerViewController.TextContentType?)] = [
        ("All", .none),
        ("URL", .URL),
        ("Phone", .telephoneNumber),
        ("Email", .emailAddress),
        ("Address", .fullStreetAddress)
    ]
    
    var body: some View {
        switch vm.dataScannerAccessStatus {
        case .scannerAvailable:
            mainView
        case .cameraNotAvailable:
            Text("Camera not available")
        case .scannerNotAvailable:
            Text("Scanner not available")
        case .cameraAccessNotGranted:
            Text("Please grant TextMag camera access!")
        case .notDetermined:
            Text("Obtaining permissions...")
        }
    }
    
    private var mainView: some View {
        DataScannerView(
            recognizedItems: $vm.recognizedItems,
            recognizedDataType: vm.recognizedDataType,
            recognizesMultipleItems: vm.recognizesMultipleItems)
        .background { Color.gray.opacity(0.35) }
        .ignoresSafeArea()
        .id(vm.dataScannerViewId)
        .sheet(isPresented: .constant(true)) { // THIS IS PREVENTING THE BACK BUTTON FROM WORKING
            bottomContainerView
                .background(.ultraThinMaterial)
                .presentationDetents([.medium, .fraction(0.25)])
                .presentationDragIndicator(.visible)
                .interactiveDismissDisabled()
                .onAppear {
                    guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                          let controller = windowScene.windows.first?.rootViewController?.presentedViewController else {
                        return
                    }
                    controller.view.backgroundColor = .clear
                }
        }
        .onChange(of: vm.scanType) { _ in vm.recognizedItems = [] }
        .onChange(of: vm.textContentType) { _ in vm.recognizedItems = [] }
        .onChange(of: vm.recognizesMultipleItems) { _ in vm.recognizedItems = []}
    }
    
    // Top half of the bottom 'translucent' view
    private var headerView: some View {
        VStack {
            HStack {
                Toggle("Multiple Items", isOn: $vm.recognizesMultipleItems)
                Button("Clear Feed") {
                            vm.clearRecognizedItems() // Calls function to clear recognized items
                        }
                        .padding(EdgeInsets(top: 8, leading: 10, bottom: 8, trailing: 10))
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(8)

            }
            .padding(.top)
            
//            Picker("Text content type", selection: $vm.textContentType) {
//                ForEach(textContentTypes, id: \.self.textContentType) { option in
//                    Text(option.title).tag(option.textContentType)
//                }
//            }
//            .pickerStyle(.segmented)
        }
        .padding(.horizontal)
        .navigationTitle("Scan")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private var bottomContainerView: some View {
        VStack {
            headerView
            
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 16) {
                    ForEach(vm.recognizedItems) { item in
                        switch item {
                            
                        case .text(let text):
                            Text(text.transcript)
                            
                        default:
                            Text("Unknown")
                        }
                    }
                }
                .padding()
            }
        }
    }
}
