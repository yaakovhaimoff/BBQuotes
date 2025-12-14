//
//  RandomQuoteButton.swift
//  BBquotes
//
//  Created by Yaakov Haimoff on 14.12.2025.
//

import SwiftUI

struct RandomQuoteButton: View {
    let vm: ViewModel
    let show: String
    
    var body: some View {
        Button {
            Task {
                await vm.getQuoteData(for: show)
            }
        } label : {
            Text("Get Random Quote")
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
    RandomQuoteButton(vm: ViewModel(), show: Constants.breakingBadName)
}
