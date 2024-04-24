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
    // CUSTOM BUTTON STUFF
    @State private var isContinuePressed = false
    @State private var isAboutPressed = false
    
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
                Color(sharedSettings.isDarkModeEnabled ? sharedSettings.DARKTHEME : sharedSettings.THEME)
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
                                .background(Color(sharedSettings.isDarkModeEnabled ? sharedSettings.DARKTHEME : sharedSettings.THEME))
                            
                            // CONTAINING BODY TEXT
                            VStack {
                                Spacer().frame(height: 250)
                                VStack {
                                    Text("TextMag")
                                        .font(Font.welcomeText)
                                        .foregroundColor(.white)
                                        .bold()
                                }
                                .padding()
                                .background(Rectangle()
                                    .foregroundColor(Color(sharedSettings.isDarkModeEnabled ? sharedSettings.DARKICON : sharedSettings.ICON))
                                    .cornerRadius(15)
                                    .shadow(radius: 10))
                                .padding()
                            }
                        }
                        
                        
                        Spacer()
                        
                        // CONTINUE BUTTON
                        VStack {
                            ZStack {
                                
                                // GLOWING
                                ZStack {
                                    Capsule()
                                        .frame(width: 290, height: 90)
                                        .foregroundColor(Color(sharedSettings.ICON))
                                        .blur(radius:4)
                                    
                                    Capsule()
                                        .frame(width: 290, height: 90)
                                        .foregroundColor(Color(sharedSettings.ICON))
                                }
                                
                                
                                HStack{
                                    Image("ic-magnifier").resizable().scaledToFit().frame(height:45)
                                    
                                    Text("Continue")
                                        .foregroundColor(.black)
                                        .padding()
                                        .font(Font.navTitle)
                                }
                            }
                            .scaleEffect(isContinuePressed ? 1.05 : 1.0)
                            .opacity(isContinuePressed ? 0.6 : 1.0)
                            .blur(radius:isContinuePressed ? 0.75 : 0.0)
                            .onTapGesture {
//                                        counter += 1
                                UINotificationFeedbackGenerator().notificationOccurred(.success)
                                self.selectedTab = 1
                            }
                            .pressEvents {
                                // On press
                                withAnimation(.easeInOut(duration: 0.1)) {
                                    isContinuePressed = true
                                }
                            } onRelease: {
                                withAnimation {
                                    isContinuePressed = false
                                }
                            }
                        }
                        
                        Spacer().frame(height:10)
                        // ABOUT BUTTON
                        VStack {
                            ZStack {
                                // GLOWING
                                ZStack {
                                    Capsule()
                                        .frame(width: 220, height: 80)
                                        .foregroundColor(.blue)
                                        .blur(radius:4)
                                    
                                    Capsule()
                                        .frame(width: 220, height: 80)
                                        .foregroundColor(.blue)
                                }
                                NavigationLink(destination: DeveloperInfoView()) {
                                    
                                    HStack{
                                        Image("ic-cap").resizable().scaledToFit().frame(height:45)
                                        
                                        Text("About")
                                            .foregroundColor(.black)
                                            .padding()
                                            .font(Font.navTitle)
                                    }
                                }
                            }
                            .scaleEffect(isAboutPressed ? 1.05 : 1.0)
                            .opacity(isAboutPressed ? 0.6 : 1.0)
                            .blur(radius:isAboutPressed ? 0.75 : 0.0)
                            .onTapGesture {
                                UINotificationFeedbackGenerator().notificationOccurred(.success)
                            }
                            .pressEvents {
                                // On press
                                withAnimation(.easeInOut(duration: 0.1)) {
                                    isAboutPressed = true
                                }
                            } onRelease: {
                                withAnimation {
                                    isAboutPressed = false
                                }
                            }
                        }


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
