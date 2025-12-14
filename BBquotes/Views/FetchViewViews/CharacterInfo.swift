//
//  CharacterInfo.swift
//  BBquotes
//
//  Created by Yaakov Haimoff on 14.12.2025.
//

import SwiftUI

struct CharacterInfo: View {
    let vm = ViewModel()
    let character: Char
    let show: String
    
    var quote: String {
        if let randomQuote = vm.randomQuote?.quote, !randomQuote.isEmpty {
            return randomQuote
        } else {
            return vm.quote.quote
        }
    }
    
    var body: some View {
        GeometryReader { geo in
            ScrollViewReader { proxy in
                ZStack(alignment: .top) {
                    Image(show.removeSpacesAndCaces())
                        .resizable()
                        .scaledToFit()
                    
                    ScrollView {
                        TabView {
                            ForEach(character.images, id: \.self) { characterImageURL in
                                
                                ZStack(alignment: .bottom) {
                                    AsyncImage(url: characterImageURL) {
                                        image in
                                        image
                                            .resizable()
                                            .scaledToFill()
                                    } placeholder: {
                                        ProgressView()
                                    }
                                    
                                    VStack {
                                        Text("\(quote)")
                                            .font(.subheadline)
                                            .foregroundStyle(.white)
                                        
                                        Button("Get another quote") {
                                            Task {
                                                await vm.getRandomQoute(for: character.name)
                                            }
                                        }
                                        .font(.title3)
                                        .foregroundStyle(.white)
                                        .background(Color(("\(show.removeSpaces())Button")))
                                        .clipShape(.rect(cornerRadius: 6))
                                        .shadow(color: Color(Color("\(show.removeSpaces())Shaddow")), radius: 2)
                                        .padding(.bottom, 40)
                                    }
                                }
                            }
                        }
                        .tabViewStyle(.page)
                        .frame(width: geo.size.width/1.2, height: geo.size.height/1.7)
                        .clipShape(.rect(cornerRadius: 25))
                        .padding(.top, 60)
                        
                        VStack(alignment: .leading) {
                            Text(character.name)
                                .font(.largeTitle)
                            
                            Text("Portrayed By: \(character.portrayedBy)")
                                .font(.subheadline)
                            
                            Divider()
                            
                            Text("\(character.name) Character Info")
                                .font(.title2)
                            
                            Text("Born: \(character.birthday)")
                            
                            Divider()
                            
                            Text("Occupations")
                            
                            ForEach(character.occupations, id: \.self) { occupation in
                                Text("\(occupation)")
                                    .font(.subheadline)
                            }
                            
                            Divider()
                            
                            Text("Nicknames:")
                            if character.aliases.count > 0 {
                                ForEach(character.aliases, id: \.self) { alias in
                                    Text("\(alias)")
                                        .font(.subheadline)
                                }
                            } else {
                                Text("None")
                                    .font(.subheadline)
                            }
                            
                            Divider()
                            
                            DisclosureGroup("Status (Spoiler Alert!):") {
                                VStack(alignment: .leading) {
                                    Text(character.status)
                                        .font(.title2)
                                    
                                    if let death = character.death {
                                        AsyncImage(url: death.image) {
                                            image in
                                            image
                                                .resizable()
                                                .scaledToFit()
                                                .clipShape(.rect(cornerRadius: 15))
                                                .onAppear {
                                                    withAnimation {
                                                        proxy.scrollTo(1, anchor: .bottom)
                                                    }
                                                }
                                        } placeholder: {
                                            ProgressView()
                                        }
                                        
                                        Text("How \(death.details)")
                                            .padding(.bottom, 7)
                                        
                                        Text("Last words: \(death.lastWords)")
                                    }
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            .tint(.primary)
                        }
                        .frame(width: geo.size.width/1.25, alignment: .leading)
                        .padding(.bottom, 40)
                        .id(1)
                    }
                }
                .scrollIndicators(.hidden)
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    CharacterInfo(character: ViewModel().character, show: "Breaking Bad")
}

