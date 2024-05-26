//
//  ComicsCollectionViewShimmer.swift
//  MarvelTV
//
//  Created by Renu Punjabi on 5/25/24.
//

import SwiftUI

struct ComicsCollectionViewShimmer: View {
    var body: some View {
        VStack(spacing: 30) {
            headerShimmer
            collectionShimmer
        }
    }
    
    private var headerShimmer: some View {
        HStack {
            ShimmerView()
                .frame(width: 800, height: 500)
            VStack(alignment: .leading, spacing: 10){
                ShimmerView()
                    .frame(height: 45)
                ShimmerView()
                    .frame(height: 20)
            }
        }
        .frame(width: 1100)
    }
    
    private var collectionShimmer: some View {
        ScrollView(.horizontal, showsIndicators: false){
            HStack(spacing: 30){
                ForEach(0..<8) { item in
                    comicCellShimmer
                }
            }
        }
    }
    
    private var comicCellShimmer: some View {
        VStack(alignment: .leading, spacing: 20) {
            ShimmerView()
                .frame(width: 250, height: 200)
                .clipShape(Rectangle())
                .overlay(Rectangle().stroke(Color.white, lineWidth: 2))
            
            ShimmerView()
                .frame(width: 150, height: 30)
            ShimmerView()
                .frame(width: 100, height: 20)
        }
        .frame(width: 250)
        .padding(.horizontal, 20)
    }
}

#Preview {
    ComicsCollectionViewShimmer()
}
