//
//  CustomText.swift
//  MarvelTV
//
//  Created by Renu Punjabi on 5/25/24.
//

import SwiftUI

struct CustomStyle {
    let foregroundColor: Color
    let fontSize: CGFloat
    let fontWeight: Font.Weight
    let alignment: TextAlignment
    
    init(foregroundColor: Color = Theme.foregroundColor, fontSize: CGFloat = 20, fontWeight: Font.Weight = .medium, alignment: TextAlignment = .leading) {
        self.foregroundColor = foregroundColor
        self.fontSize = fontSize
        self.fontWeight = fontWeight
        self.alignment = alignment
    }
}

struct CustomText: View {
    let text: String
    let style: CustomStyle
    let lineLimit: Int?
    
    init(text: String, style: CustomStyle? = nil, lineLimit: Int? = 2) {
        self.text = text
        self.style = style ?? CustomStyle()
        self.lineLimit = lineLimit
    }
    
    var body: some View {
        Text(text)
            .font(.system(size: style.fontSize, weight: style.fontWeight, design: .default))
            .foregroundColor(style.foregroundColor)
            .multilineTextAlignment(style.alignment)
            .lineLimit(lineLimit ?? Int.max)
            .truncationMode(.tail)
            .fixedSize(horizontal: false, vertical: true)
    }
}

#Preview {
    CustomText(text: "Custom Title")
}
