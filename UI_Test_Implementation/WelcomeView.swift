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
                Color(sharedSettings.isDarkModeEnabled ? .black : UIColor(red: 55/255, green: 32/255, blue: 90/255, alpha: 1))
                    .ignoresSafeArea()

                GeometryReader { geometry in
                    Spacer()
                    VStack(spacing: 8) { // Adjust spacing as needed
                        
                        Spacer()
                        ZStack {
                            Image("icontest")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 300, height: 300)
                                .cornerRadius(50)
                                .background(Color(sharedSettings.isDarkModeEnabled ? .black : UIColor(red: 55/255, green: 32/255, blue: 90/255, alpha: 1)))
                            
                            // CONTAINING BODY TEXT
                            VStack {
                                Spacer().frame(height: 250)
                                VStack {
                                    Text("TextMag")
                                        .font(Font.welcomeText)
                                        .foregroundColor(.white)
                                        .bold()
                                    
//                                    Text("version 0.2.0-beta")
//                                        .font(Font.welcomeTextSmall)
//                                        .foregroundColor(.white)
//                                        .bold()
                                }
                                .padding()
                                .background(Rectangle()
                                    .foregroundColor(Color(UIColor(red: 53/255, green: 194/255, blue: 192/255, alpha: 1)))
                                    .cornerRadius(15)
                                    .shadow(radius: 10))
                                .padding()
                            }
                        }
                        
                        
                        Spacer()
                        
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
                                .cornerRadius(25)
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
                                .cornerRadius(25)
                        }
                        .shadow(radius: 10)
                        Spacer()
                    }
                    .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                }
            }
            .toolbar{
                ToolbarItem(placement: .principal){
//                    Text("Home")
//                        .font(Font.navTitle)
//                        .foregroundColor(.white)
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
