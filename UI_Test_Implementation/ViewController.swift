//
//  ViewController.swift
//  UI_Test_Implementation
//
//  Created by Daniel Iskandar on 2/18/24.
//


import UIKit
import SwiftUI

struct ContentView: View{
    @EnvironmentObject var sharedSettings : SharedSettings
    @State private var selectedTab = 0 //First tab is default
    
    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationView{
                WelcomeView(selectedTab: $selectedTab)
            }
            .tabItem {
                Image("ic-house")
//                Image(systemName: "house.fill")
                    .renderingMode(.template)

            }
            .tag(0) //WelcomeView tab
            
            NavigationView(){
                TextMagnifierView()
            }
            .tabItem {
                Image("ic-magnifier")
//                Image(systemName: "magnifyingglass")
                    .renderingMode(.template)

            }
            .tag(1) // TextMagnifierView tab
            
            
            NavigationView(){
                SettingsView()
            }
            .tabItem {
                Image("ic-gear")
                    .renderingMode(.template)
                    .resizable()

            }
            .tag(2)
        }
        
        .accentColor(.purple) // Sets Active Tabview icon color
        .onAppear {
            let appearance = UITabBarAppearance()
            appearance.backgroundColor = UIColor(red: 55/255, green: 32/255, blue: 90/255, alpha: 1)
            
            
            appearance.stackedLayoutAppearance.normal.iconColor = .white // GENERAL ICON COLOR
            appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.white]
            
            appearance.stackedLayoutAppearance.selected.iconColor = .white // ACTIVE TABCOLOR
            
            appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.white] // Same color as iconColor
            
            UITabBar.appearance().standardAppearance = appearance
            UITabBar.appearance().scrollEdgeAppearance = appearance
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

