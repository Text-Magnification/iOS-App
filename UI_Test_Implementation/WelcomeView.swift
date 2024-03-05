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
                    Spacer()
                    VStack(spacing: 8) { // Adjust spacing as needed
                        Spacer()
                        Text("TextMag")
                            .font(Font.welcomeText)
                            .foregroundColor(.black)
                            .bold()
//                            .shadow(color: .gray, radius: 2, x: 0, y: 4)
                        
                        Text("v1.0.0-alpha")
                            .font(Font.welcomeTextSmall)
                            .foregroundColor(.black)
                            .bold()
//                            .shadow(color: .gray, radius: 2, x: 0, y: 4)
                        
                        Spacer()
                        
                        Button(action: {
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
                                .background(Color.purple)
                                .foregroundColor(.white)
                                .font(Font.navTitle)
                                .cornerRadius(15)
                        }
                        
//                        Button(action: {
//                            print("LEARNED")
//                        }) {
//                            NavigationLink(destination: DeveloperInfoView()) {
//                                HStack {
//                                    Image("ic-cap")
//                                        .resizable()
//                                        .scaledToFit()
//                                        .frame(height: 50)
//                                    Text("About")
//                                        .foregroundColor(.black)
//                                        .font(Font.navTitle)
//                                        .bold()
//                                }
//                            }
//                                .frame(width: 350, height: 100)
//                                .background(Color.purple)
//                                .foregroundColor(.white)
//                                .font(Font.navTitle)
//                                .cornerRadius(15)
//                        }
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
        WelcomeView(selectedTab: .constant(0))
    }
}
