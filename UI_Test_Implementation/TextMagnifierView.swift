//
//  TextMagnifierView.swift
//  UI_Test_Implementation
//
//  Created by Daniel Iskandar on 2/19/24.
//

import SwiftUI
import UIKit

struct TextMagnifierView: View {
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
                Color("Background")
                    .ignoresSafeArea()
                
                GeometryReader { geometry in
                    VStack(spacing: 8) { //Adjust as needed
                        
                        Button(action: {
                            print("MAGNIFY SELECTED")
                        }) {
                            NavigationLink(destination: MagnifierView()) {
                                HStack {
                                    Image("ic-magnifyPage")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 50)
                                    Text("Let's go!")
                                        .foregroundColor(.black)
                                        .font(Font.navTitle)
                                }
                            }
                            .frame(width: 350, height: 100)
                            .background(.mint)
                            .foregroundColor(.white)
                            .font(Font.navTitle)
                            .cornerRadius(10)
                        }
            
                        
                        Button(action: {
                            print("TUTORIAL SELECTED")
                            // Construct the URL object
                            if let url = URL(string: "https://www.youtube.com/watch?v=9BMhFmNzw-o") {
                                // Use UIApplication to open the URL
                                UIApplication.shared.open(url)
                            }
                        }) {
                            HStack {
                                Image("ic-video")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 40)
                                Text("Tutorial")
                                    .foregroundColor(.black)
                                    .font(Font.navTitle)
                            }
                            .frame(width: 350, height: 100)
                            .background(.gray)
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
                    Text("TextMag View")
                        .font(Font.navTitle)
                        .foregroundColor(.white)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct TextMagnifierView_Previews: PreviewProvider {
    static var previews: some View {
        TextMagnifierView()
    }
}
