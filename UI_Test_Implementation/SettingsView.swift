
import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject var sharedSettings: SharedSettings
    
    init() {
            // Customize navigation bar appearance
            let appearance = UINavigationBarAppearance()
//            appearance.backgroundColor = UIColor(red:7/255,green:110/255,blue:118/255,alpha:1)
            appearance.backgroundColor = UIColor(red: 53/255, green: 194/255, blue: 192/255, alpha: 1)

        
            appearance.titleTextAttributes = [.foregroundColor: UIColor.white] // Changes the title color
            appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white] // If using large titles
            
            // Apply the appearance to the navigation bar
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().compactAppearance = appearance // For compact height
            UINavigationBar.appearance().scrollEdgeAppearance = appearance // For large titles
        }
    
    
    var body: some View {
        ZStack {
            Color(sharedSettings.isDarkModeEnabled ? sharedSettings.DARKTHEME : sharedSettings.THEME) // Settings color
                .ignoresSafeArea()
            
            Form {
                Section {
                    Picker(selection: $sharedSettings.fontIndex, label:
                            Text("Font")) {
                        ForEach(0 ..< SharedSettings.allFonts.count, id: \.self) { index in
                            Text(SharedSettings.allFonts[index]).tag(index)
                        }
                    }
                            .onChange(of: sharedSettings.fontIndex) { newIndex in
                                let fontName = SharedSettings.allFonts[newIndex]
                                sharedSettings.fontChoice = UIFont(name: fontName, size: CGFloat(sharedSettings.fontSize)) ?? UIFont.systemFont(ofSize: CGFloat(sharedSettings.fontSize))
                            }
                    
                    Picker(selection: $sharedSettings.fontSizeIndex, label:
                            Text("Font Size")) {
                        ForEach(0 ..< SharedSettings.allFontSizes.count, id: \.self) { index in
                            Text(String(SharedSettings.allFontSizes[index])).tag(index)
                        }
                    }
                            .onChange(of: sharedSettings.fontSizeIndex) { newIndex in
                                let newSize = SharedSettings.allFontSizes[newIndex]
                                sharedSettings.fontChoice = sharedSettings.fontChoice.withSize(CGFloat(newSize))
                            }
                    
                    Picker(selection: $sharedSettings.ARColorIndex, label:
                            Text("AR Text Color")) {
                        ForEach(0 ..< SharedSettings.allARColorStrings.count, id: \.self) { index in
                            Text(SharedSettings.allARColorStrings[index]).tag(index)
                        }
                    }
                            .onChange(of: sharedSettings.ARColorIndex) {newIndex in
                                let newColor = SharedSettings.allARColors[newIndex] // NOT THE STRINGS THIS TIME, ACTUAL UICOLORS
                                sharedSettings.ARColor = newColor
                            }
                }
                
                    
                //Creates toggle button and bounds dark mode toggle state
                //Then listens for the toggle and deactivates the darkmode
                Section {
                    Toggle("Dark Mode", isOn: $sharedSettings.isDarkModeEnabled).font(.title3)
                    //Changes app interface on the root view and sets style to
                    //dark or light. Changes appearance of UI elements across the app
                        .onChange(of: sharedSettings.isDarkModeEnabled) { isEnabled in
                            UIApplication.shared.windows.first?.rootViewController?.view.overrideUserInterfaceStyle = isEnabled ? .dark : .light
                            
                        }
                    Text("Toggle dark mode theme").font(.caption)
                }
                

                
                Section {
                    Toggle("Detect Multiple Items", isOn: $sharedSettings.multipleItems).font(.title3)
                    Text("Enabling this allows TextMag to detect multiple text items at once").font(.caption)
                }
                
                Section {
                    Toggle ("Show AR Text (Experimental)", isOn: $sharedSettings.experimentalMode).font(.title3)
                    Text("Enabling this allows TextMag to digitally zoom detected text on-screen").font(.caption)
                    Text("WARNING: Enabling both 'Show AR Text' & 'Detect Multiple Items' can result in overlapping text!").font(.caption).fontWeight(.bold)
                }
                    
            }
            .scrollContentBackground(.hidden)
                
        }
//        .toolbar{
//            ToolbarItem(placement: .principal) {
//                Text("Settings")
//                    .font(Font.navTitle)
//                    .foregroundColor(.white)
//            }
//        }
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

