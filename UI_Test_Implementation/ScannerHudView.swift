
import SwiftUI
import VisionKit

struct ScannerHudView: View {
    
    @EnvironmentObject var vm: AppViewModel
    @State private var showingBottomContainer = true // State to control the visibility of bottomContainerView
    
    private let textContentTypes: [(title: String, textContentType: DataScannerViewController.TextContentType?)] = [
        ("All", .none),
        ("URL", .URL),
        ("Phone", .telephoneNumber),
        ("Email", .emailAddress),
        ("Address", .fullStreetAddress)
    ]
    
    var body: some View {
        ZStack {
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
            
            // Conditionally show bottomContainerView
            if showingBottomContainer {
                bottomContainerView
                    .transition(.move(edge: .bottom)) // Slide in from bottom
                    .zIndex(1) // Ensure it's above the main content
            }
        }
        .navigationBarTitle("Scan", displayMode: .inline)
        .navigationBarItems(trailing: Button("Toggle") { // Example toggle button for showing/hiding bottom container
            withAnimation {
                showingBottomContainer.toggle()
            }
        })
    }
    
    private var mainView: some View {
        DataScannerView(
            recognizedItems: $vm.recognizedItems,
            recognizedDataType: vm.recognizedDataType,
            recognizesMultipleItems: vm.recognizesMultipleItems)
            .background(Color.gray.opacity(0.35))
            .ignoresSafeArea()
            .id(vm.dataScannerViewId)
            .onChange(of: vm.scanType) { _ in vm.recognizedItems = [] }
            .onChange(of: vm.textContentType) { _ in vm.recognizedItems = [] }
            .onChange(of: vm.recognizesMultipleItems) { _ in vm.recognizedItems = [] }
    }
    
    private var bottomContainerView: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                Spacer() // Use a spacer to push the content to the bottom half

                // Your bottom container content starts here
                VStack {
                    headerView
                        .frame(height: geometry.size.height * 0.1) // Adjust header height as needed

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
                    .frame(height: geometry.size.height * 0.4) // Adjust scroll view height as needed
                }
                .frame(maxWidth: .infinity)
                .background(.ultraThinMaterial)
                .cornerRadius(15)
//                .padding(.horizontal)
                .shadow(radius: 5)
                // Use the GeometryReader's height to set a fixed height for the bottomContainerView
                .frame(height: geometry.size.height * 0.1, alignment: .bottom) // Adjust this to change the occupied height
            }
//            .edgesIgnoringSafeArea(.bottom) // Extend to the bottom edge of the screen
        }
    }

    
    private var headerView: some View {
        VStack {
            HStack {
                Toggle("Multiple Items", isOn: $vm.recognizesMultipleItems)
                Button("Clear Feed") {
                    vm.clearRecognizedItems()
                }
                .padding(EdgeInsets(top: 8, leading: 10, bottom: 8, trailing: 10))
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(8)
            }
            .padding(.top)
        }
        .padding(.horizontal)
    }
}

