//
//  CustomToggleStyle.swift
//  WalletApp
//
//  Created by Vitoroi Daniel on 04.03.2024.
//

import SwiftUI

struct CustomToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
            
            Spacer()
            
            Toggle("", isOn: configuration.$isOn)
                .labelsHidden()
                .frame(width: 40, height: 24)
                .toggleStyle(SwitchToggleStyle())
        }
    }
}

