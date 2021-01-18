//
//  ProfileView.swift
//  GameCenter
//
//  Created by Irsyad Ashari on 18/01/21.
//

import SwiftUI

struct ProfileView: View {
    
    var body: some View {
        
        ZStack {
            Color.baseColor
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                myProfilePhoto
                name
                title
                bio
                Spacer()
                HStack(spacing: 24) {
                    github
                    linkedin
                }
                
            }.padding(
                EdgeInsets(
                    top: 0,
                    leading: 0,
                    bottom: 12,
                    trailing: 0))
            
        }
        
    }
}

extension ProfileView {
    
    var myProfilePhoto: some View {
        Image("me")
            .resizable()
            .frame(width: 250, height: 250, alignment: .center)
            .mask(Jajargenjang(depth: 20))
            
    }
    
    var name: some View {
        Text("Muh Irsyad Ashari")
            .font(.system(size: 24))
            .frame(width: UIScreen.main.bounds.width - 32,
                   alignment: .center)
            .foregroundColor(.white)
        
    }
    
    var title: some View {
        Text("iOS Developer | +6287880931606")
            .frame(width: UIScreen.main.bounds.width - 32,
                   alignment: .center)
            .foregroundColor(.white)
            .padding(
                EdgeInsets(
                    top: 0,
                    leading: 0,
                    bottom: 4,
                    trailing: 0))
    }
    
    var bio: some View {
        Text("An informatics bachelor and a proactive mobile developer with 1 year+ experience in Android and iOS application development. I have passions in mobile development field to create a scalable app with clean architecture to make people’s life easier.")
            .frame(width: UIScreen.main.bounds.width - 100,
                   height:  80,
                   alignment: .center)
            .font(.system(size: 12))
            .foregroundColor(.white)
    }
    
    var github: some View {
        IconInfo(image: "github", info: "irsyadashari")
            .frame(height: 50,
                   alignment: .center)
        
    }
    
    var linkedin: some View {
        IconInfo(image: "linkedin", info: "Irsyad Ashari")
            .frame(height: 50,
                   alignment: .center)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
