//
//  ButtonBar.swift
//  BBquotes
//
//  Created by Yaakov Haimoff on 14.12.2025.
//

import SwiftUI

struct ButtonBar: View {
    let vm: ViewModel
    let show: String
    
    var body: some View {
        HStack {
            RandomQuoteButton(vm: vm, show: show)
            
            Spacer()
            
            RandomEpisodeButton(vm: vm, show: show)
            
            Spacer()
            
            RandomCharacterButton(vm: vm, show: show)
        }
        .padding(.horizontal, 20)
    }
}

#Preview {
    ButtonBar(vm: ViewModel(), show: Constants.breakingBadName)
}
