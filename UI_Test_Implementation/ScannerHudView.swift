import SwiftUI
import VisionKit

struct ScannerHudView: View {
    
    @EnvironmentObject var sharedSettings: SharedSettings
    @EnvironmentObject var vm: AppViewModel
    @Environment(\.presentationMode) var presentationMode
    
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
            Text("No iPhone camera detected")
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
        recognizesMultipleItems: sharedSettings.multipleItems)
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
    
    
    // Top half of the lower translucent view
    private var headerView: some View {
        VStack {
            HStack {
                Spacer().frame(width: 1)
                
                // TEMPORARY BACK BUTTON WORKAROUND
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()  // Dismiss the current view
                }) {
                    HStack {
                        Image(systemName: "chevron.left") // Arrow icon
                            .foregroundColor(Color(UIColor.systemBlue))
                        Text("Back") // Text label
                            .foregroundColor(Color(UIColor.systemBlue))
                    }
                    .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                    .cornerRadius(8)
                }
                
                Spacer()
                
                // FREEZE TEXT BUTTON
                Button(action: {
                    UINotificationFeedbackGenerator().notificationOccurred(.success)
                    vm.frozenRecognizedItems = vm.recognizedItems
                    sharedSettings.toggleFreeze()
                    
                    if !sharedSettings.isFrozen {
                        vm.recognizedItems = []
                        sharedSettings.shouldRemoveOverlays = true
                    }
                }) {
                    Text(sharedSettings.isFrozen ? "Unfreeze" : "Freeze")
                        .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                        .background(.purple)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                
                Spacer()
                Spacer().frame(width: 20.25)
                // CLEAR TEXT BUTTON
                Button("Clear") {
                    UINotificationFeedbackGenerator().notificationOccurred(.success)
                    vm.clearRecognizedItems() // Calls function to clear recognized items
                }
                .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(8)
                

            }
            .padding(.top)
        }
        .padding(.horizontal)
//        .navigationTitle("Scan")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    // Entire translucent bottom view - notice that "headerView" is placed here at the "top"
    private var bottomContainerView: some View {
        VStack {
            headerView
            
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 16) {
                    ForEach(sharedSettings.isFrozen ? vm.frozenRecognizedItems : vm.recognizedItems) { item in
                        switch item {
                            
                        case .text(let text):
                            Text(text.transcript).font(Font(sharedSettings.fontChoice)) // Use the user-listed font
                            
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
