//
//  SettingsView.swift
//  UI_Test_Implementation
//
//  Created by Daniel Iskandar on 2/19/24.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject var sharedSettings: SharedSettings
    
    init() {
            // Customize navigation bar appearance
            let appearance = UINavigationBarAppearance()
            appearance.backgroundColor = UIColor.systemPurple // can use any color
            appearance.titleTextAttributes = [.foregroundColor: UIColor.white] // Changes the title color
            appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white] // If using large titles
            
            // Apply the appearance to the navigation bar
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().compactAppearance = appearance // For compact height
            UINavigationBar.appearance().scrollEdgeAppearance = appearance // For large titles
        }
    
    var body: some View {
        ZStack {
            Color(.white)
                .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 15) {
                
                Toggle("Detect Multiple Items", isOn: $sharedSettings.multipleItems).font(.title3)
                Text("Enabling this allows TextMag to detect multiple text items at once").font(.caption)
                Spacer().frame(height: 5)
                Toggle ("Show AR Text (Experimental)", isOn: $sharedSettings.experimentalMode).font(.title3)
                Text("Enabling this allows TextMag to digitally zoom detected text on-screen").font(.caption)
                Text("WARNING: Enabling both 'Show AR Text' & 'Detect Multiple Items' can result in overlapping text!").font(.caption).fontWeight(.bold)
                
                //Creates toggle button and bounds dark mode toggle state
                //Then listens for the toggle and deactivates the darkmode
                Toggle("Light Text Mode", isOn: $sharedSettings.isDarkModeEnabled).font(.title3)
                //Changes app interface on the root view and sets style to
                //dark or light. Changes appearance of UI elements across the app
                    .onChange(of: sharedSettings.isDarkModeEnabled) { isEnabled in
                        UIApplication.shared.windows.first?.rootViewController?.view.overrideUserInterfaceStyle = isEnabled ? .dark : .light
                        //This is depreciated but kind of works. To fix the
                        //warning requires a different strategy.
                    }
                Text("Disable this if text is on top of a light background").font(.caption)

                
            }
            .foregroundColor(.black)
            .padding()
            .background(Rectangle()
                .foregroundColor(.white)
                .cornerRadius(15)
                .shadow(radius: 10))
            .padding()
        }
        .toolbar{
            ToolbarItem(placement: .principal) {
                Text("Settings")
                    .font(Font.navTitle)
                    .foregroundColor(.white)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct SettingsView_Previews: PreviewProvider {
    //FIXED PREVIEW CRASHING ISSUES WITH SettingsView
    static var previews: some View {
        // Created an instance of SharedSettings
        let sharedSettings = SharedSettings()
        
        // Injected it into SettingsView using the .environmentObject modifier
        return SettingsView().environmentObject(sharedSettings)
    }
}

