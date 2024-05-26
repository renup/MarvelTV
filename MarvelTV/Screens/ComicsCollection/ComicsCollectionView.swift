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
        NavigationView {
            switch viewModel.asyncState {
            case .initial, .loading:
                ComicsCollectionViewShimmer()
            case .loaded:
                content
            case .error:
                ErrorView()
            }
        }
        .onAppear {
            viewModel.pullComics(for: character.id)
        }
    }
    
    private var content: some View {
        VStack {
            header
            Spacer(minLength: 30)
            comicCollection
                .padding(.bottom, 30)
        }
        .background(Theme.backgroundColor)
    }
    
    private var header: some View {
        HStack(spacing: 30) {
            CustomAsyncImage(url: character.thumbnail.url,
                             frame: CGSize(width: 800, height: 500)
            )
            .overlay(
                LinearGradient(gradient: Gradient(colors: [.clear, .black.opacity(0.5)]), startPoint: .leading, endPoint: .trailing)
            )
            .clipped()
            VStack(alignment: .leading, spacing: 10){
                CustomText(text: character.name.capitalized,
                           style: CustomStyle(fontSize: 45, fontWeight: .bold)
                )
                followCharacter
            }
        }
    }
    
    private var followCharacter: some View {
        HStack(spacing: 15) {
            Image(systemName: "star")
                .renderingMode(.template)
                .resizable()
                .frame(width: 40, height: 40)
            
            CustomText(text: "Follow Character".capitalized,
                       style: CustomStyle(fontSize: 20, fontWeight: .bold)
            )
        }

    }
    
    private var comicCollection: some View {
        Group {
            if viewModel.comics.isEmpty {
                CustomText(text: "No comics found for \(character.name)",
                           style: CustomStyle(fontSize: 45, fontWeight: .bold, alignment: .center)
                )
            } else {
                ScrollView(.horizontal) {
                    LazyHGrid(rows: [GridItem(.flexible())]) {
                        ForEach(viewModel.comics) { comic in
                           comicCell(for: comic)
                                .focusable()
                        }
                    }
                }
                .focusSection()
            }
        }
    }
    
    private func comicCell(for comic: Comic) -> some View {
        VStack(alignment: .leading, spacing: 5) {
            CustomAsyncImage(url: comic.thumbnail.url,
                             frame: CGSize(width: 250, height: 200)
            )
            .clipShape(Rectangle())
            .overlay(Rectangle().stroke(Color.white, lineWidth: 2))
            
            VStack(alignment: .leading, spacing: 8) {
                CustomText(text: comic.title.capitalized,
                           style: CustomStyle(fontSize: 20)
                )
                
                CustomText(text: "ISSUE # \(comic.issueNumber)",
                           style: CustomStyle(foregroundColor: .gray, fontSize: 16)
                )
            }.frame(height: 120)
        }
        .frame(width: 250)
    }
}


