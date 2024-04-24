//
//  TextMagnifierView.swift
//  UI_Test_Implementation
//
//  Created by Daniel Iskandar on 2/19/24.
//

import SwiftUI
import UIKit

struct TextMagnifierView: View {
    @EnvironmentObject var sharedSettings: SharedSettings
    @State private var isScanPressed = false
    @State private var isTutorialPressed = false
    
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
        NavigationStack{
            ZStack {
                Color(sharedSettings.isDarkModeEnabled ? sharedSettings.DARKTHEME : sharedSettings.THEME)
                    .ignoresSafeArea()
                
                GeometryReader { geometry in
                    VStack(spacing: 8) { //Adjust as needed
                        Spacer()
                        
                        VStack {
                            ZStack {
                                Text("")
                                    .fontWeight(.bold)
                                .font(.system(size: 120))
                                .foregroundColor(.white)
                                .blur(radius: 10.0)
                                
                                Text("")
                                    .fontWeight(.bold)
                                .font(.system(size: 120))
                                .foregroundColor(.white)
                            }
                            Spacer().frame(height:20)
                            
                            Text("Let's get started!")
                                .font(Font.welcomeText)
                                .foregroundColor(sharedSettings.isDarkModeEnabled ? .white : .white)
                                .bold()
                            
                            Spacer().frame(height:25)
                            
                            Text("Select 'Scan Text' to continue")
                                .font(Font.welcomeTextSmall)
                                .foregroundColor(sharedSettings.isDarkModeEnabled ? .white : .white)
                                .bold()
                        }
                        .padding()
                        .background(Rectangle()
                            .foregroundColor(sharedSettings.isDarkModeEnabled ? Color(UIColor.systemGray4) : Color(sharedSettings.CUSTOMCYAN).opacity(0.5))
                            .cornerRadius(20)
                            .shadow(radius: 20))
                        .padding()
                        
                        Spacer()
                        
                        // SCAN TEXT BUTTON NEEDS NAVLINK
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
                                NavigationLink(destination: MagnifierView()) {
                                    
                                    HStack{
                                        Image("ic-magnifyPage").resizable().scaledToFit().frame(height:45)
                                        
                                        Text("Scan Text")
                                            .foregroundColor(.black)
                                            .padding()
                                            .font(Font.navTitle)
                                    }
                                }
                            }
                            .scaleEffect(isScanPressed ? 1.05 : 1.0)
                            .opacity(isScanPressed ? 0.6 : 1.0)
                            .blur(radius:isScanPressed ? 0.75 : 0.0)
                            .onTapGesture {
                                UINotificationFeedbackGenerator().notificationOccurred(.success)
                            }
                            .pressEvents {
                                // On press
                                withAnimation(.easeInOut(duration: 0.1)) {
                                    isScanPressed = true
                                }
                            } onRelease: {
                                withAnimation {
                                    isScanPressed = false
                                }
                            }
                        }
                        
                        Spacer().frame(height:10)
                        
                        // TUTORIAL BUTTON
                        VStack {
                            ZStack {
                                // GLOWING
                                ZStack {
                                    Capsule()
                                        .frame(width: 240, height: 80)
                                        .foregroundColor(.blue)
                                        .blur(radius:4)
                                    
                                    Capsule()
                                        .frame(width: 240, height: 80)
                                        .foregroundColor(.blue)
                                }
                                                                    
                                HStack{
                                    Image("ic-video").resizable().scaledToFit().frame(height:30)
                                    
                                    Text("Tutorial")
                                        .foregroundColor(.black)
                                        .padding()
                                        .font(Font.navTitle)
                                }
                                
                            }
                            .scaleEffect(isTutorialPressed ? 1.05 : 1.0)
                            .opacity(isTutorialPressed ? 0.6 : 1.0)
                            .blur(radius:isTutorialPressed ? 0.75 : 0.0)
                            .onTapGesture {
                                UINotificationFeedbackGenerator().notificationOccurred(.success)
                                // Construct the URL object
                                if let url = URL(string: "https://www.youtube.com/watch?v=El8aCC-4f-M") {
                                    // Use UIApplication to open the URL
                                    UIApplication.shared.open(url)
                                }
                            }
                            .pressEvents {
                                // On press
                                withAnimation(.easeInOut(duration: 0.1)) {
                                    isTutorialPressed = true
                                }
                            } onRelease: {
                                withAnimation {
                                    isTutorialPressed = false
                                }
                            }
                        }

                        Spacer()
                    }
                    .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                
                }
            }
            
//            .toolbar{
//                ToolbarItem(placement: .principal){
//                    Text("Scan")
//                        .font(Font.navTitle)
//                        .foregroundColor(.white)
//                }
//            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct TextMagnifierView_Previews: PreviewProvider {
    static var previews: some View {
        TextMagnifierView().environmentObject(SharedSettings())
    }
}
