//
//  ContentView.swift
//  BBquotes
//
//  Created by Yaakov Haimoff on 10.11.2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Tab (Constants.breakingBadName, systemImage: "tortoise"){
                FetchView(show: Constants.breakingBadName)
            }
            Tab (Constants.betterCallSaulName, systemImage: "briefcase"){
                FetchView(show: Constants.betterCallSaulName)
            }
            Tab (Constants.elCaminoName, systemImage: "car"){
                FetchView(show: Constants.elCaminoName)
            }
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
