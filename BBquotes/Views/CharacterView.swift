//
//  CharacterView.swift
//  BBquotes
//
//  Created by Yaakov Haimoff on 11.11.2025.
//

import SwiftUI

struct CharacterView: View {
    let character: Char
    let show: String
    
    var body: some View {
        GeometryReader { geo in
            VStack(alignment: .leading) {
                Text(character.name)
                    .font(.largeTitle)
                
                Text("Portrayed By: \(character.portrayedBy)")
                    .font(.title2)
                
                TabView {
                    ForEach(character.images, id: \.self) { characterImageURL in
                        AsyncImage(url: characterImageURL) {
                            image in
                            image
                                .resizable()
                                .scaledToFill()
                        } placeholder: {
                            ProgressView()
                        }
                    }
                }
                .tabViewStyle(.page)
                .frame(width: geo.size.width/1.2, height: geo.size.height/1.7)
                .clipShape(.rect(cornerRadius: 25))
                .padding(.top, 20)
            }
            .padding()
            .foregroundStyle(.white)
            .background(.black.opacity(0.6))
            .clipShape(.rect(cornerRadius: 25))
            .padding(.horizontal)
        }
    }
}

#Preview {
    CharacterView(character: ViewModel().character, show: "Breaking Bad")
}
