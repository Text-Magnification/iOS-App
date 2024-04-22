//
//  DeveloperInfoView.swift
//  UI_Test_Implementation
//
//  Created by Daniel Iskandar on 2/20/24.
//

import SwiftUI

struct DeveloperInfoView: View {
    @EnvironmentObject var sharedSettings: SharedSettings
    
    @Environment(\.presentationMode) var presentationMode:
    Binding<PresentationMode>
    
    init() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.systemPurple // Choose a color that fits the theme
        appearance.backButtonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.white] // Ensure the text is visible
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var body: some View {
        ZStack {
            Color(sharedSettings.isDarkModeEnabled ? .black : .white)
                            .ignoresSafeArea()
            
            ScrollView {
                VStack(){
                    Text("Four students from the University of Michigan attempt to fight Presbyopia and Macular Degeneration with tools to give the visually impaired accessibility through a cross platform text recognition and magnification app.")
                        .font(.welcomeTextSmall)
                        .foregroundColor(sharedSettings.isDarkModeEnabled ? .white : .black)
                        .multilineTextAlignment(.center)
                        .padding()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                HStack() {
                    Text("iOS Development Team")
                        .font(.devTeamText)
                        .foregroundColor(.purple)
                        .multilineTextAlignment(.center)
                }
                HStack(alignment: .top) {
                    Image("img-daniel")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 170)
                    
                    VStack(alignment: .leading, spacing: 5) {
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Iskandar, Daniel")
                                .font(.navTitle)
                                .foregroundColor(sharedSettings.isDarkModeEnabled ? .white : .black)
                            Text("University of Michigan CS-LSA '25")
                                .font(.collegeText)
                                .foregroundColor(sharedSettings.isDarkModeEnabled ? .white : .black)
                        }
                        .background(Color.gray.opacity(0.15))
                        .padding(.all, 3) // adds space around the text
                        .overlay(
                            Rectangle()
                                .stroke(Color.black, lineWidth: 2)
                            )
                        
                        Text("Research/project management, Camera integration, image retrieval, front end, back end, QA in Swift")
                            .font(.descriptionText)
                            .foregroundColor(sharedSettings.isDarkModeEnabled ? .white : .black)
                            .multilineTextAlignment(.leading)
                            .lineLimit(nil)
                        
                            Link(destination: URL(string: "https://www.linkedin.com/in/daniel-iskandar-")!) {
                                Text("Daniel")
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.purple)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }
                            .padding(.horizontal) // So the button doesn't stretch too far on wide screens
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                HStack(alignment: .top) {
                    Image("img-justin")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 170)
                    
                    VStack(alignment: .leading, spacing: 5) {
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Lu, Justin")
                                .font(.navTitle)
                                .foregroundColor(sharedSettings.isDarkModeEnabled ? .white : .black)
                            Text("University of Michigan CSE-CoE '24")
                                .font(.collegeText)
                                .foregroundColor(sharedSettings.isDarkModeEnabled ? .white : .black)
                        }
                        .background(Color.gray.opacity(0.15))
                        .cornerRadius(0)
                        .padding(.all, 3)
                        .overlay(
                            Rectangle()
                                .stroke(Color.black, lineWidth: 2)
                            )
                        Text("Research/project management. Apple Vision frameworks, front end, back end, and testuing in SwiftUI.")
                            .font(.descriptionText)
                            .foregroundColor(sharedSettings.isDarkModeEnabled ? .white : .black)
                            .multilineTextAlignment(.leading)
                            .padding(.top, 5)
                        
                            Link(destination: URL(string: "https://www.linkedin.com/in/justin-m-lu-cdn/")!) {
                                Text("Justin")
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.purple)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }
                            .padding(.horizontal)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                
                HStack() {
                    Text("Android Development Team - Kotlin")
                        .font(.devTeamText)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.purple)
                }
                HStack(alignment: .top) {
                    Image("img-antony")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 170)
                    VStack(alignment: .leading, spacing: 5) {
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Dong, Antony")
                                .font(.navTitle)
                                .foregroundColor(sharedSettings.isDarkModeEnabled ? .white : .black)
                            Text("University of Michigan CSE-CoE '24")
                                .font(.collegeText)
                                .foregroundColor(sharedSettings.isDarkModeEnabled ? .white : .black)
                                .lineLimit(nil)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                        .background(Color.gray.opacity(0.15))
                        .cornerRadius(0)
                        .padding(.all, 3)
                        .overlay(
                            Rectangle()
                                .stroke(Color.black, lineWidth: 2)
                            )
                        Text("CameraX Jetpack Compose, front end, back end, augmented reality in Kotlin")
                            .font(.descriptionText)
                            .foregroundColor(sharedSettings.isDarkModeEnabled ? .white : .black)
                            .multilineTextAlignment(.leading)
                            .padding(.top, 5)
                        
                            Link(destination: URL(string: "https://www.linkedin.com/in/antony-dong/")!) {
                                Text("Antony")
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.purple)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }
                            .padding(.horizontal)
                    }
                }
                HStack(alignment: .top) {
                    Image("img-siddharth")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 170)
                    VStack(alignment: .leading, spacing: 5) {
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Parmar, Siddharth")
                                .font(.navTitle)
                                .foregroundColor(sharedSettings.isDarkModeEnabled ? .white : .black)
                            Text("University of Michigan CS-LSA '24")
                                .font(.collegeText)
                                .foregroundColor(sharedSettings.isDarkModeEnabled ? .white : .black)
                        }
                        .background(Color.gray.opacity(0.15))
                        .cornerRadius(0)
                        .padding(.all, 3)
                        .overlay(
                            Rectangle()
                                .stroke(Color.black, lineWidth: 2)
                            )
                        Text("Planning, research, project management, camera integration, OCR, magnification, and app design")
                            .font(.descriptionText)
                            .foregroundColor(sharedSettings.isDarkModeEnabled ? .white : .black)
                            .multilineTextAlignment(.leading)
                            .padding(.top, 5)
                        
                        Link(destination: URL(string: "https://www.linkedin.com/in/sid-parmar/")!) {
                            Text("Siddharth")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.purple)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        .padding(.horizontal)
                    }
                }
                
                HStack() {
                    Text("Coordinator")
                        .font(.devTeamText)
                        .foregroundColor(.purple)
                }
                HStack(alignment: .top) {
                    Image("img-chesney")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 170)
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Dr. David R Chesney")
                            .font(.navTitle)
                            .foregroundColor(sharedSettings.isDarkModeEnabled ? .white : .black)
                        Text("Professor, Electrical Engineering and Computer Science")
                            .font(.navTitle)
                            .foregroundColor(sharedSettings.isDarkModeEnabled ? .white : .black)
                        Text("Coordinator and program director. Lead the team as an instructor in EECS 495: Software For Accessability.")
                            .font(.descriptionText)
                            .foregroundColor(sharedSettings.isDarkModeEnabled ? .white : .black)
                            .multilineTextAlignment(.leading)
                            .padding(.top, 5)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .navigationTitle("About Us")
            
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    if let backImage = UIImage(named: " ") {
                        Button(action: {
                            self.presentationMode.wrappedValue.dismiss()
                        }) {
                            Image(uiImage: backImage)
                                .foregroundColor(sharedSettings.isDarkModeEnabled ? .white : .purple)
                        }
                    }
                }
            }
            .padding()
        }
        .background(Color.white)
    }
}

struct DeveloperInfoView_Previews: PreviewProvider {
    static var previews: some View {
        DeveloperInfoView().environmentObject(SharedSettings())
    }
}

