//
//  ErrorView.swift
//  MarvelTV
//
//  Created by Renu Punjabi on 5/25/24.
//

import SwiftUI

struct ErrorView: View {
    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: "exclamationmark.triangle")
                .renderingMode(.template)
                .resizable()
                .frame(width: 150, height: 150)
            
            CustomText(text: "Oops! something went wrong",
                       style: CustomStyle(fontSize: 50, fontWeight: .bold)
            )
            CustomText(text: "Try again later",
                       style: CustomStyle(fontSize: 50, fontWeight: .bold)
            )
        }
    }
}

#Preview {
    ErrorView()
}
