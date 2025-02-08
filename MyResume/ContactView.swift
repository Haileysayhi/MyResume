//
//  ContactView.swift
//  MyResume
//
//  Created by 郭蕙瑄 on 2025/2/8.
//

import SwiftUI

struct ContactView: View {
    
    @Binding var isShowing: Bool
    
    var body: some View {
        
        VStack {
            HStack {
                Image(systemName: "phone.fill")
                    .resizable().aspectRatio(contentMode: .fit)
                    .padding(10)
                    .foregroundColor(.white)
                    .background(RoundedRectangle(cornerRadius: 10).foregroundColor(.brown))
                    .padding(10)
                    .onTapGesture {
                        openURL(Resume.shared.phoneUrl)
                    }
                
                
                ForEach(Resume.shared.socialMedia, id: \.name) { media in
                    Image(media.name.lowercased())
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(10)
                        .onTapGesture {
                            openURL(media.url)
                        }
                }
            }
            Text("取消")
                .font(.title3)
                .foregroundColor(.secondary)
                .onTapGesture {
                    isShowing.toggle()
                }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 20).foregroundColor(Color(uiColor: .tertiarySystemBackground)))
        .padding()
    }
    
    func openURL(_ url: String) {
        let url = URL(string: url)!
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
            return
        }
    }
}

#Preview {
    ContactView(isShowing: .constant(true))
        .background(.yellow)
}
