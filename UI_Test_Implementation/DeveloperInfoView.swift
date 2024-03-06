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
                
//                HStack(alignment: .top) {
//                    Image("img-chesney")
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 125)
//                    VStack(alignment: .leading, spacing: 5) {
//                        Text("Dr. David R Chesney")
//                            .font(.navTitle)
//                            .foregroundColor(.black)
//                        Text("Teaching Professor, Electrical Engineering and Computer Science")
//                            .font(.navTitle)
//                            .foregroundColor(.black)
//                        Text("Coordinator and program director. Lead the team as an instructor in EECS 495: Software For Accessability.")
//                            .font(.descriptionText)
//                            .foregroundColor(.black)
//                            .multilineTextAlignment(.leading)
//                            .padding(.top, 5)
//                    }
//                }
//                .frame(maxWidth: .infinity, maxHeight: .infinity)
//                .padding()
                
                HStack() {
                    Text("iOS Development Team")
                        .font(.devTeamText)
                }
                HStack(alignment: .top) {
                    Image("img-daniel")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 125)
                    
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Iskandar, Daniel")
                            .font(.navTitle)
                            .foregroundColor(.black)
                        Text("University of Michigan CS-LSA '25")
                            .font(.collegeText)
                            .foregroundColor(.black)
                        Text("Planning, Research, and Project Management. Camera integration, Image Retrieval, and Front End design in SwiftUI.                          https://www.linkedin.com/in/daniel-iskandar-/")
                            .font(.descriptionText)
                            .foregroundColor(.black)
                            .multilineTextAlignment(.leading)
                            .padding(.top, 5)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding()
                
                HStack(alignment: .top) {
                    Image("img-justin")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 125)
                    
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Lu, Justin")
                            .font(.navTitle)
                            .foregroundColor(.black)
                        Text("University of Michigan CSE-CoE '24")
                            .font(.collegeText)
                            .foregroundColor(.black)
                        Text("Planning, Research, and Project Management. Apple Vision, language detection and translation, Back End design in SwiftUI                         https://www.linkedin.com/in/justin-m-lu-cdn/")
                            .font(.descriptionText)
                            .foregroundColor(.black)
                            .multilineTextAlignment(.leading)
                            .padding(.top, 5)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding()
                
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

//"Planning, Research, and Project Management. Apple Vision, language detection and translation, Back End design in SwiftUI"
