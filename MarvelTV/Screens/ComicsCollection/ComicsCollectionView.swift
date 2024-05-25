//
//  ComicCollectionView.swift
//  MarvelTV
//
//  Created by Renu Punjabi on 5/24/24.
//

import SwiftUI

struct ComicsCollectionView: View {
    let character: Character
    @State var viewModel = ComicsCollectionViewModel()
    
    var body: some View {
        comicCollection
        .onAppear {
            viewModel.pullComics(for: character.id)
        }
        .navigationBarTitle(character.name)
    }
    
    private var comicCollection: some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: [GridItem(.flexible())]) {
                ForEach(viewModel.comics) { comic in
                   comicCell(for: comic)
                }
            }
        }
        .focusSection()
    }
    
    private func comicCell(for comic: Comic) -> some View {
        VStack(spacing: 10) {
            AsyncImage(url: comic.thumbnail.url) { image in
                image.resizable()
                     .aspectRatio(contentMode: .fill)
                     .frame(width: 150, height: 200)
                     .clipShape(Rectangle())
                     .overlay(Rectangle().stroke(Color.white, lineWidth: 2))
            } placeholder: {
                PlaceholderProvider().getRandomShinyColor()
            }
            
            Text(comic.title.uppercased())
                .lineLimit(2)
                .truncationMode(.tail)
                .multilineTextAlignment(.center)
            
            Text("ISSUE # \(comic.issueNumber)")
        }
        .frame(width: 250)
        .focusable()
    }
}


