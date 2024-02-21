//
//  ViewController.swift
//  UI_Test_Implementation
//
//  Created by Daniel Iskandar on 2/18/24.
//

//struct ContentView: View {
//    @State private var isShowingWelcomeView: Bool = true
//
//    var body: some View {
//        TabView {
//            NavigationView {
//                if isShowingWelcomeView {
//                    WelcomeView(isShowingWelcomeView: $isShowingWelcomeView)
//                } else {
//                    TextMagnifierView()
//                }
//            }
//            .tabItem {
//                Image(systemName: "house.fill") // Adjust your image
//            }
//            // Other tabs...
//        }
//    }
//}


import UIKit
import SwiftUI

struct ContentView: View{
    @State private var selectedTab = 0 //First tab is default
    
    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationView{
                WelcomeView(selectedTab: $selectedTab)
            }
            .tabItem {
                Image("ic-house")
                    .renderingMode(.template)
            }
            .tag(0) //WelcomeView tab
            
            NavigationView(){
                TextMagnifierView()
            }
            .tabItem {
                Image("ic-leaf")
                    .renderingMode(.template)
            }
            .tag(1) // TextMagnifierView tab
            
            NavigationView(){
                ProfileView()
            }
            .tabItem {
                Image("ic-profile")
                    .renderingMode(.template)
            }
            .tag(2)
            
            NavigationView{
                SavedTextView()
            }
            .tabItem {
                Image("ic-scribble")
                    .renderingMode(.template)
            }
            .tag(3)
            
            NavigationView(){
                SettingsView()
            }
            .tabItem {
                Image("ic-gear")
                    .renderingMode(.template)
            }
            .tag(4)
        }
    }
}




struct ContentView_Previews: PreviewProvider{
    static var previews: some View {
        ContentView()
    }
}


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create an instance of your SwiftUI view
        let swiftUIView = ContentView()
        
        // Create a hosting controller with swiftUIView
        let hostingController = UIHostingController(rootView: swiftUIView)
        
        // Make sure the hostingController's view fits the entire screen or the parent view
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        
        // Add the hosting controller as a child view controller
        self.addChild(hostingController)
        self.view.addSubview(hostingController.view)
        // Set up constraints for the hosting controller's view
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: self.view.topAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            hostingController.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
        ])
        
        // Notify the hosting controller that it has been moved to the current view controller
        hostingController.didMove(toParent: self)
    }
}

