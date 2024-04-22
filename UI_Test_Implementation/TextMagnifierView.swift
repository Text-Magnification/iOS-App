//
//  TextMagnifierView.swift
//  UI_Test_Implementation
//
//  Created by Daniel Iskandar on 2/19/24.
//

import SwiftUI
import UIKit
import WebKit

// WebView to load YouTube videos
struct WebView: UIViewRepresentable {
    var urlString: String

    func makeUIView(context: Context) -> WKWebView {
        guard let url = URL(string: urlString) else {
            return WKWebView()
        }
        let request = URLRequest(url: url)
        let webView = WKWebView()
        webView.load(request)
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        // Function can be used to dynamically update web content
    }
}

struct TextMagnifierView: View {
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
        NavigationStack {
            ScrollView {
                VStack(spacing: 8) {
                    Spacer()
                    
                    VStack {
                        Text("Let's get started!")
                            .font(Font.welcomeText)
                            .foregroundColor(sharedSettings.isDarkModeEnabled ? .white : .black)
                            .bold()
                        
                        Text("Select 'Scan Text' to continue")
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

                    NavigationLink(destination: MagnifierView()) {
                        HStack {
                            Image("ic-magnifyPage")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 50)
                            Text("Scan Text")
                                .foregroundColor(.black)
                                .font(Font.navTitle)
                        }
                        .frame(width: 350, height: 100)
                        .background(sharedSettings.isDarkModeEnabled ? .purple : .purple)
                        .foregroundColor(.white)
                        .font(Font.navTitle)
                        .cornerRadius(10)
                    }
                    .shadow(radius: 10)

                    // Embed the YouTube video within a WebView
                    WebView(urlString: "https://www.youtube.com/embed/El8aCC-4f-M")
                        .frame(height: 300) // Set the frame to ensure it fits well within your UI
                        .cornerRadius(12)
                        .shadow(radius: 10)

                    Spacer()
                }
            }
            .navigationTitle("Tutorial")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Scan")
                        .font(Font.navTitle)
                        .foregroundColor(.white)
                }
            }
        }
    }
}

struct TextMagnifierView_Previews: PreviewProvider {
    static var previews: some View {
        TextMagnifierView().environmentObject(SharedSettings())
    }
}
