//
//  TetchService.swift
//  BBquotes
//
//  Created by Yaakov Haimoff on 10.11.2025.
//

import Foundation

struct FetchService {
    private enum FetchError: Error {
        case badResponse
    }

    private let baseURL: URL = URL(string: "https://breaking-bad-api-six.vercel.app/api")!
    
    func fetchQuote(from show: String) async throws -> Quote {
        // build ftch url
        let quoteURL = baseURL.appending(path: "quotes/random")
        let fetchURL = quoteURL.appending(queryItems: [URLQueryItem(name: "production", value: show)])

        // fetch data
        let (data, response) = try await URLSession.shared.data(from: fetchURL)
        
        //handle response
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw FetchError.badResponse
        }
        
        // decode data
        let quote = try JSONDecoder().decode(Quote.self, from: data)
        
        // return qoute
        return quote
    }
    
    func fetchRandomCharacter(from show: String) async throws -> Char {
        let quoteURL = baseURL.appending(path: "characters/random")
        let (data, response) = try await URLSession.shared.data(from: quoteURL)
        
        //handle response
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw FetchError.badResponse
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let character = try decoder.decode(Char.self, from: data)
        
        if character.productions.contains(show) {
            return character
        } else {
            return try await fetchRandomCharacter(from: show)
        }
    }
    
    func fetchRandomCharacterQoute(from name: String) async throws -> Quote {
        let quoteURL = baseURL.appending(path: "quotes/random")
        let fetchURL = quoteURL.appending(queryItems: [URLQueryItem(name: "character", value: name)])
        let (data, response) = try await URLSession.shared.data(from: fetchURL)
        
        //handle response
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw FetchError.badResponse
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let quote = try decoder.decode(Quote.self, from: data)
        
        return quote
    }
    
    func fetchCharacter(_ name: String) async throws -> Char {
        let characterURL = baseURL.appending(path: "characters")
        let fetchURL = characterURL.appending(queryItems: [URLQueryItem(name: "name", value: name)])
        
        // fetch data
        let (data, response) = try await URLSession.shared.data(from: fetchURL)
        
        //handle response
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw FetchError.badResponse
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let characters = try decoder.decode([Char].self, from: data)
        
        return characters[0]
    }
    
    func fetchDeath(for character: String) async throws -> Death? {
        let fetchURL = baseURL.appending(path: "deaths")
        
        let (data, response) = try await URLSession.shared.data(from: fetchURL)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw FetchError.badResponse
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let deaths = try decoder.decode([Death].self, from: data)
        
        for death in deaths {
            if death.character == character {
                return death
            }
        }
        return nil
    }
    
    func fetchEpisode(from show: String) async throws -> Episode? {
        let episodeURL = baseURL.appending(path: "episodes")
        let fetchURL = episodeURL.appending(queryItems: [URLQueryItem(name: "production", value: show)])
        
        // fetch data
        let (data, response) = try await URLSession.shared.data(from: fetchURL)
        
        //handle response
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw FetchError.badResponse
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let episodes = try decoder.decode([Episode].self, from: data)
        
        return episodes.randomElement()
    }
}
