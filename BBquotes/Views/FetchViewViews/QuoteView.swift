//
//  QuoteView.swift
//  BBquotes
//
//  Created by Yaakov Haimoff on 14.12.2025.
//

import SwiftUI

struct QuoteView: View {
    let vm: ViewModel
    let geo: GeometryProxy
    @Binding var showCharacterInfo: Bool
    
    var body: some View {
        VStack {
            Text("\"\(vm.quote.quote)\"")
                .minimumScaleFactor(0.5)
                .multilineTextAlignment(.center)
                .foregroundStyle(.white)
                .padding()
                .background(.black.opacity((0.5)))
                .clipShape(.rect(cornerRadius: 25))
                .padding(.horizontal)
            
            ZStack(alignment: .bottom) {
                AsyncImage(url: vm.character.images.randomElement()!) {
                    image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: geo.size.width/1.1, height: geo.size.height/1.8)
                
                Text(vm.quote.character)
                    .foregroundStyle(.white)
                    .padding(10)
                    .frame(maxWidth: .infinity)
                    .background(.ultraThinMaterial)
            }
            .frame(width: geo.size.width/1.1, height: geo.size.height/1.8)
            .clipShape(.rect(cornerRadius: 50))
            .onTapGesture {
                showCharacterInfo.toggle()
            }
        }
    }
}

#Preview {
    GeometryReader { geo in
        QuoteView(vm: ViewModel(), geo: geo, showCharacterInfo: .constant(true))
    }
}
