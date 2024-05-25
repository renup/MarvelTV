//
//  CharactersCollectionShimmerView.swift
//  MarvelTV
//
//  Created by Renu Punjabi on 5/25/24.
//

import SwiftUI

struct CharactersCollectionShimmerView: View {
    var body: some View {
        VStack(spacing: 30) {
            titleShimmer
            collectionShimmer
        }
    }
    
    private var titleShimmer: some View {
        HStack {
            ShimmerView()
                .frame(width: 200, height: 50)
            Spacer()
            ShimmerView()
                .frame(width: 100, height: 25)
        }
    }
    
    private var collectionShimmer: some View {
        HStack(spacing: 30){
            ForEach(0..<8) { item in
                characterCellShimmer
            }
        }
    }
    
    private var characterCellShimmer: some View {
        VStack(spacing: 20){
            ShimmerView()
                .frame(width: 200, height: 170)
                .clipShape(Ellipse())
                .overlay(Ellipse().stroke(Color.white, lineWidth: 2))
            
            ShimmerView()
                .frame(width: 150, height: 30)
        }

    }
}

#Preview {
    CharactersCollectionShimmerView()
}
