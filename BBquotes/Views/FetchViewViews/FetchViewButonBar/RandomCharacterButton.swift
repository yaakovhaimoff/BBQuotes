//
//  RandomCharacterButton.swift
//  BBquotes
//
//  Created by Yaakov Haimoff on 14.12.2025.
//

import SwiftUI

struct RandomCharacterButton: View {
    let vm: ViewModel
    let show: String
    
    var body: some View {
        Button {
            Task {
                await vm.getCharacter(for: show)
            }
        } label : {
            Text("Get Random Character")
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
    RandomCharacterButton(vm: ViewModel(), show: Constants.breakingBadName)
}
