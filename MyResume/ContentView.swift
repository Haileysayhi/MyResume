//
//  ContentView.swift
//  MyResume
//
//  Created by 郭蕙瑄 on 2025/2/4.
//

import SwiftUI

struct ContentView: View {
    
    private let resume = Resume.shared
    
    @State private var isShowingContact: Bool = false
    @State private var shouldShowTransparentView: Bool = false
    
    
    var body: some View {
        
        ScrollView {
            VStack(spacing: 30) {
                
                cardView
                
                Text(resume.bio).font(.title3).lineSpacing(10)
                
                Button {
                    isShowingContact.toggle()
                } label: {
                    Text("Contact Me")
                        .foregroundColor(.white)
                        .font(.title2).bold()
                        .padding(.vertical, 10)
                        .frame(maxWidth: .infinity)
                        .background(RoundedRectangle(cornerRadius: 20).foregroundColor(.brown))
                }
                
                Text("Skills").font(.title2).bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                skillView
                
                Text("Experience").font(.title2).bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                experienceView
            }
            .padding()
            .overlay(Color.black.opacity(isShowingContact ? 0.5 : 0)
                .onTapGesture { isShowingContact .toggle()}
            )
            .overlay(alignment: .top) {
                contactView
            }
            .animation(.spring(), value: isShowingContact)
        }
        .background(Color(.secondarySystemBackground))
    }
    
    // MARK: - subviews
    
    var cardView: some View {
        HStack {
            Image("avatar")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(.circle) // 如果放在padding後面會變成奇怪的圓形
                .frame(width: 200)
            
            VStack(spacing: 20) {
                Text(resume.name)
                    .font(.title).bold()
                Text(resume.title)
                Label(resume.location, systemImage: "location.fill").foregroundColor(.secondary)
            }
        }
    }
    
    var skillView: some View {
        HStack {
            ForEach(resume.skills, id: \.self) { skill in
                VStack{
                    Image(skill.lowercased())
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50)
                    Text(skill)
                }.frame(width: 80)
            }
        }
    }
    
    var experienceView: some View {
        VStack(spacing: 0) {
            ForEach(resume.experiences.indices, id: \.self) { index in
                
                HStack {
                    
                    ShapeDrawer(lineWidth: 2,
                                dotSize: 10,
                                lineStyle: index == 0 ? .bottomHalf : index == resume.experiences.count - 1 ? .topHalf : .full)
                    .frame(width: 70)
                    .foregroundColor(.secondary)
                    
                    let experience = resume.experiences[index]
                    
                    VStack(spacing: 8) {
                        Group {
                            Text("\(experience.start) - \(experience.end)")
                                .foregroundColor(.secondary)
                            Text(experience.title).font(.title2)
                            Text(experience.company)
                                .padding(.bottom, 30)
                        }.frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
            }
        }
    }
    
    var contactView: some View {
        Group {
            if isShowingContact {
                ContactView(isShowing: $isShowingContact)
                    .offset(y: UIScreen.main.bounds.maxY * 0.3)
                    .transition(.slide)
            }
        }.animation(.spring(), value: isShowingContact)
    }
}

#Preview {
    ContentView()
}
