//
//  WelcomeView.swift
//  UI_Test_Implementation
//
//  Created by Daniel Iskandar on 2/19/24.
//

import SwiftUI

struct WelcomeView: View {
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
                Color("Background")
                    .ignoresSafeArea()
            
                GeometryReader { geometry in
                    VStack(spacing: 8) { // Adjust spacing as needed
                        Text("Welcome To")
                            .font(Font.welcomeText)
                            .foregroundColor(.black)
                            .shadow(color: .gray, radius: 2, x: 0, y: 4)
                        
                        Text("TextMag")
                            .font(Font.welcomeText)
                            .foregroundColor(.black)
                            .shadow(color: .gray, radius: 2, x: 0, y: 4)
                        
                        Button(action: {
                            self.selectedTab = 1
                        }) {
                            HStack {
                                Image("ic-magnifier")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 50)
                                Text("Continue")
                                    .foregroundColor(.white)
                                    .font(Font.navTitle)
                            }
                                .frame(width: 350, height: 100)
                                .background(Color.purple)
                                .foregroundColor(.white)
                                .font(Font.navTitle)
                                .cornerRadius(10)
                        }
                        
                        Button(action: {
                            print("LEARNED")
                        }) {
                            NavigationLink(destination: DeveloperInfoView()) {
                                HStack {
                                    Image("ic-cap")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 50)
                                    Text("Learn More!")
                                        .foregroundColor(.white)
                                        .font(Font.navTitle)
                                }
                            }
                                .frame(width: 350, height: 100)
                                .background(Color.purple)
                                .foregroundColor(.white)
                                .font(Font.navTitle)
                                .cornerRadius(10)
                        }
                    }
                    .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                }
            }
            
            .toolbar{
                ToolbarItem(placement: .principal){
                    Text("TextMag")
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
        WelcomeView(selectedTab: .constant(0))
    }
}
