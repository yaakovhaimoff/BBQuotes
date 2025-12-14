//
//  QuoteView.swift
//  BBquotes
//
//  Created by Yaakov Haimoff on 10.11.2025.
//

import Foundation
import SwiftUI

struct FetchView: View {
    let vm = ViewModel()
    let show: String
    
    @State var showCharacterInfo: Bool = false
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Image(show.removeSpacesAndCaces())
                    .resizable()
                    .frame(width: geo.size.width * 2.7, height: geo.size.height * 1.2)
                VStack {
                    VStack {
                        Spacer(minLength: 60)
                        
                        switch vm.status {
                        case .notStarted:
                            EmptyView()
                        case .fetching:
                            ProgressView()
                        case .successQuote:
                            QuoteView(vm: vm, geo: geo, showCharacterInfo: $showCharacterInfo)
                        case .successCharacter:
                            CharacterView(character: vm.character, show: show)
                            
                        case .successEpisode:
                            EpisodeView(episode: vm.episode)
                            
                        case .failure(let error):
                            Text(error.localizedDescription)
                        }
                    }
                    
                    Spacer(minLength: 20)
                    
                    ButtonBar(vm: vm, show: show)
                    
                    Spacer(minLength: 95)
                }
                .frame(width: geo.size.width, height: geo.size.height)
            }
            .frame(width: geo.size.width, height: geo.size.height)
        }
        .ignoresSafeArea()
        .sheet(isPresented: $showCharacterInfo) {
            CharacterInfo(character: vm.character, show: show)
        }
        .onAppear {
            Task {
                await vm.getQuoteData(for: show)
            }
        }
    }
}

#Preview {
    FetchView(show: Constants.breakingBadName)
        .preferredColorScheme(.dark)
}
