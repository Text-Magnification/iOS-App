//
//  ViewController.swift
//  UI_Test_Implementation
//
//  Created by Daniel Iskandar on 2/18/24.
//


import UIKit
import SwiftUI

struct TabBarModifier: ViewModifier {
    @EnvironmentObject var sharedSettings: SharedSettings

    func body(content: Content) -> some View {
        content
            .onReceive(sharedSettings.$isDarkModeEnabled) { _ in
                updateTabBarAppearance()
            }
    }

    private func updateTabBarAppearance() {
        let appearance = UITabBarAppearance()
        // BACKGROUND COLOR
        appearance.backgroundColor = sharedSettings.isDarkModeEnabled ? sharedSettings.DARKTHEME : sharedSettings.THEME
        
        // UNSELECTED ICON COLOR
        appearance.stackedLayoutAppearance.normal.iconColor = sharedSettings.CUSTOMWHITE
        // UNSELECTED ICON TEXTATTRIBUTE
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: sharedSettings.CUSTOMWHITE]
        
        // ACTIVE ICON
        appearance.stackedLayoutAppearance.selected.iconColor = sharedSettings.isDarkModeEnabled ? sharedSettings.CUSTOMCYAN : .lightGray
        // ACTIVE ICON TEXTATTRIBUTE
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: sharedSettings.isDarkModeEnabled ? sharedSettings.CUSTOMCYAN : .lightGray]
        
        appearance.shadowImage = nil
        appearance.shadowColor = nil
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
        UITabBar.appearance().backgroundColor = sharedSettings.isDarkModeEnabled ? UIColor.black : UIColor.white
        // Necessary to enforce refresh in some scenarios
        UIApplication.shared.windows.forEach { window in
            window.rootViewController?.setNeedsStatusBarAppearanceUpdate()
            window.subviews.forEach { view in
                view.removeFromSuperview()
                window.addSubview(view)
            }
        }
    }
}

extension View {
    func applyTabBarAppearance() -> some View {
        self.modifier(TabBarModifier())
    }
}

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
                    .renderingMode(.template)
                    .resizable()
                    .frame(height:60)

            }
            .tag(0) //WelcomeView tab
            
            NavigationView(){
                TextMagnifierView()
            }
            .tabItem {
                Image("ic-magnifier")
                    .renderingMode(.template)
                    .resizable()
                    .frame(height:60)

            }
            .tag(1) // TextMagnifierView tab
            
            
            NavigationView(){
                SettingsView()
            }
            .tabItem {
                Image("ic-gear")
                    .renderingMode(.template)
                    .resizable()
                    .frame(height:60)

            }
            .tag(2)
        }
        
        .accentColor(.black) // Sets Active Tabview icon color
        .applyTabBarAppearance()
    }
}


struct ContentView_Previews: PreviewProvider{
    static var previews: some View {
        ContentView().environmentObject(SharedSettings())}
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

