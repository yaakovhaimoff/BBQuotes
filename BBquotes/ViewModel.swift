//
//  ViewModel.swift
//  BBquotes
//
//  Created by Yaakov Haimoff on 10.11.2025.
//

import Foundation

@Observable
@MainActor
class ViewModel {
    enum FetchStatus {
        case notStarted
        case fetching
        case success
        case failure(error: Error)
    }
    
    private(set) var status: FetchStatus = .notStarted
    
    private let fetcher = FetchService()
    
    var quote: Quote
    var character: Char
    
    init() {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let quoteData = try! Data(contentsOf: Bundle.main.url(forResource: "samplequote", withExtension: "json")!)
        quote = try! decoder.decode(Quote.self, from: quoteData)
        
        let charData = try! Data(contentsOf: Bundle.main.url(forResource: "samplecharacter", withExtension: "json")!)
        character = try! decoder.decode(Char.self, from: charData)
    }
    
    func getData(for show: String) async {
        status = .fetching
        
        do {
//            print("show: \(show)")
            
            quote = try await fetcher.fetchQuote(from: show)
//            print("quote: \(quote)")
            
            character = try await fetcher.fetchCharacter(quote.character)
//            print("character: \(character)")
            
            character.death = try await fetcher.fetchDeath(for: character.name)
            
            status = .success
        } catch {
            print("error: \(error)")
            status = .failure(error: error)
        }
    }
}
