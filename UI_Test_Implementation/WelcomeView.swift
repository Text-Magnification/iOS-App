//
//  WelcomeView.swift
//  UI_Test_Implementation
//
//  Created by Daniel Iskandar on 2/19/24.
//

import SwiftUI
enum Theme {
    static let primary = Color("Primary")
}

struct WelcomeView: View {
    // Dark mode
//    @Environment(\.colorScheme) var colorScheme //Detects current color scheme
    @EnvironmentObject var sharedSettings: SharedSettings
    
    @Binding var selectedTab: Int
    
    init(selectedTab: Binding<Int>) {
            self._selectedTab = selectedTab
            // Customize navigation bar appearance
            let appearance = UINavigationBarAppearance()
            appearance.backgroundColor = UIColor.systemPurple// can use any color
            appearance.titleTextAttributes = [.foregroundColor: UIColor.white] // Changes the title color
            appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white] // If using large titles
            
            // Apply the appearance to the navigation bar
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().compactAppearance = appearance // For compact height
            UINavigationBar.appearance().scrollEdgeAppearance = appearance // For large titles
        }

    var body: some View {
        NavigationStack{
            ZStack {
//                Color("Background")
//                    .ignoresSafeArea()
                Color(sharedSettings.isDarkModeEnabled ? .black : .white)
                    .ignoresSafeArea()

                GeometryReader { geometry in
                    Spacer()
                    VStack(spacing: 8) { // Adjust spacing as needed
                        Spacer()
                        
                        VStack {
                            Text("TextMag")
                                .font(Font.welcomeText)
//                                .foregroundColor(.primary)
                                .foregroundColor(sharedSettings.isDarkModeEnabled ? .white : .black)
                                .bold()
                            
                            Text("version 0.2.0-beta")
                                .font(Font.welcomeTextSmall)
                                .foregroundColor(sharedSettings.isDarkModeEnabled ? .white : .black)
                                .bold()
                        }
                        .padding()
                        .background(Rectangle()
                            .foregroundColor(sharedSettings.isDarkModeEnabled ? Color(UIColor.systemGray4) : .white)
                            .cornerRadius(15)
                            .shadow(radius: 10))
                        .padding()
                        
                        Button(action: {
                            UINotificationFeedbackGenerator().notificationOccurred(.success)
                            self.selectedTab = 1
                        }) {
                            HStack {
                                Image("ic-magnifier")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 50)
                                Text("Continue")
                                    .foregroundColor(.black)
                                    .font(Font.navTitle)
                                    .bold()
                            }
                                .frame(width: 350, height: 100)
                                .background(sharedSettings.isDarkModeEnabled ? .purple : .purple)
                                .foregroundColor(.white)
                                .font(Font.navTitle)
                                .cornerRadius(15)
                        }
                        .shadow(radius: 10)
                        
                        Button(action: {
                        }) {
                            NavigationLink(destination: DeveloperInfoView()) {
                                HStack {
                                    Image("ic-cap")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 50)
                                    Text("About")
                                        .foregroundColor(.black)
                                        .font(Font.navTitle)
                                        .bold()
                                }
                            }
                                .frame(width: 350, height: 100)
                                .background(sharedSettings.isDarkModeEnabled ? .gray : .gray)
                                .foregroundColor(.white)
                                .font(Font.navTitle)
                                .cornerRadius(15)
                        }
                        .shadow(radius: 10)
                        Spacer()
                    }
                    .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                }
            }
            .toolbar{
                ToolbarItem(placement: .principal){
                    Text("Home")
                        .font(Font.navTitle)
                        .foregroundColor(.white)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        let sharedSettings = SharedSettings()
        
        WelcomeView(selectedTab: .constant(0))
            .environmentObject(sharedSettings)
    }
}
