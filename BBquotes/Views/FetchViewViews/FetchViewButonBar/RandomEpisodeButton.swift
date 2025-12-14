//
//  RandomEpisodeButton.swift
//  BBquotes
//
//  Created by Yaakov Haimoff on 14.12.2025.
//

import SwiftUI

struct RandomEpisodeButton: View {
    let vm: ViewModel
    let show: String
    
    var body: some View {
        Button {
            Task {
                await vm.getEpisode(for: show)
            }
        } label : {
            Text("Get Random Episode")
                .font(.title3)
                .foregroundStyle(.white)
                .padding()
                .background(Color(("\(show.removeSpaces())Button")))
                .clipShape(.rect(cornerRadius: 7))
                .shadow(color: Color(Color("\(show.removeSpaces())Shaddow")), radius: 2)
        }
    }
}

#Preview {
    RandomEpisodeButton(vm: ViewModel(), show: Constants.breakingBadName)
}
