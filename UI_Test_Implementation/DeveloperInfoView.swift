//
//  DeveloperInfoView.swift
//  UI_Test_Implementation
//
//  Created by Daniel Iskandar on 2/20/24.
//

import SwiftUI

struct DeveloperInfoView: View {
    var body: some View {
        ZStack {
            ScrollView {
                VStack(){
                    Text("Four students from the University of Michigan attempt to fight Presbyopia and Macular Degeneration with tools to give the visually impaired accessibility through a cross platform text recognition and magnification app.")
                        .font(.welcomeTextSmall)
                        .foregroundColor(.black)
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
                        .frame(width: 125)
                    VStack(alignment: .leading, spacing: 5) {
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Iskandar, Daniel")
                                .font(.navTitle)
                                .foregroundColor(.black)
                            Text("University of Michigan CS-LSA '25")
                                .font(.collegeText)
                                .foregroundColor(.black)
                        }
                        .background(Color.gray.opacity(0.15))
                        .padding(.all, 3) // adds space around the text
                        .overlay(
                            Rectangle()
                                .stroke(Color.black, lineWidth: 2)
                            )
                        Text("Research/project management. Camera integration, image retrieval, and front end design in SwiftUI.")
                            .font(.descriptionText)
                            .foregroundColor(.black)
                            .multilineTextAlignment(.leading)
                            .padding(.top, 0)
                        
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
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                HStack(alignment: .top) {
                    Image("img-justin")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 125)
                    
                    VStack(alignment: .leading, spacing: 5) {
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Lu, Justin")
                                .font(.navTitle)
                                .foregroundColor(.black)
                            Text("University of Michigan CSE-CoE '24")
                                .font(.collegeText)
                                .foregroundColor(.black)
                        }
                        .background(Color.gray.opacity(0.15))
                        .cornerRadius(0)
                        .padding(.all, 3)
                        .overlay(
                            Rectangle()
                                .stroke(Color.black, lineWidth: 2)
                            )
                        Text("Research/project management. Apple Vision frameworks, language detection and translation, back end design in SwiftUI.")
                            .font(.descriptionText)
                            .foregroundColor(.black)
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
                    Text("Android Development Team")
                        .font(.devTeamText)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.purple)
                }
                HStack(alignment: .top) {
                    Image("img-antony")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 125)
                    VStack(alignment: .leading, spacing: 5) {
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Dong, Antony")
                                .font(.navTitle)
                                .foregroundColor(.black)
                            Text("University of Michigan CSE-CoE '24")
                                .font(.collegeText)
                                .foregroundColor(.black)
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
                        Text("CameraX Jetpack Compose implementation, front end design in Kotlin")
                            .font(.descriptionText)
                            .foregroundColor(.black)
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
                        .frame(width: 125)
                    VStack(alignment: .leading, spacing: 5) {
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Parmar, Siddharth")
                                .font(.navTitle)
                                .foregroundColor(.black)
                            Text("University of Michigan CSE-CoE '24")
                                .font(.collegeText)
                                .foregroundColor(.black)
                        }
                        .background(Color.gray.opacity(0.15))
                        .cornerRadius(0)
                        .padding(.all, 3)
                        .overlay(
                            Rectangle()
                                .stroke(Color.black, lineWidth: 2)
                            )
                        Text("Android planning, research, and project management, camera integration, text translation, magnification, and app design in Kotlin")
                            .font(.descriptionText)
                            .foregroundColor(.black)
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
                        .frame(width: 125)
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Dr. David R Chesney")
                            .font(.navTitle)
                            .foregroundColor(.black)
                        Text("Teaching Professor, Electrical Engineering and Computer Science")
                            .font(.navTitle)
                            .foregroundColor(.black)
                        Text("Coordinator and program director. Lead the team as an instructor in EECS 495: Software For Accessability.")
                            .font(.descriptionText)
                            .foregroundColor(.black)
                            .multilineTextAlignment(.leading)
                            .padding(.top, 5)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding()
            }
            .navigationTitle("About Us")
            .navigationBarTitleDisplayMode(.inline)
            .padding()
        }.background(.white)
    }
}

struct DeveloperInfoView_Previews: PreviewProvider {
    static var previews: some View {
        DeveloperInfoView()
    }
}

