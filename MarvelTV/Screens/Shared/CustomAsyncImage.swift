//
//  CustomAsyncImage.swift
//  MarvelTV
//
//  Created by Renu Punjabi on 5/25/24.
//

import SwiftUI

struct CustomAsyncImage: View {
    let url: URL?
    let frame: CGSize
    let contentMode: ContentMode?
    
    init(url: URL?, frame: CGSize, contentMode: ContentMode? = .fill) {
        self.url = url
        self.frame = frame
        self.contentMode = contentMode
    }
    
    var body: some View {
        AsyncImage(url: url) { image in
            image.resizable()
                .aspectRatio(contentMode: contentMode ?? .fit)
                 .frame(width: frame.width, height: frame.height)
        } placeholder: {
            PlaceholderProvider().getRandomShinyColor()
                .frame(width: frame.width, height: frame.height)
        }
    }
}

#Preview {
    CustomAsyncImage(url: URL(string: "google.com"), frame: CGSize(width: 200, height: 200))
}
