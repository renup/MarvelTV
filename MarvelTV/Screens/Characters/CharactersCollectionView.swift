//
//  CharactersCollection.swift
//  MarvelTV
//
//  Created by Renu Punjabi on 5/23/24.
//

import SwiftUI
import OSLog

private let logger = Logger(subsystem: "MarvelTV", category: "MarvelCharactersView", forDebugBuild: true)


struct CharactersCollectionView: View {
    @State private var viewModel = CharactersCollectionViewModel()
    
    var rows = [
        GridItem(.flexible(), alignment: .center),
    ]
    
    var body: some View {
        NavigationView {
            switch viewModel.asyncState {
            case .loading:
                CharactersCollectionShimmerView()
            case .loaded:
                content
            case .error:
                ErrorView()
            default:
                EmptyView()
            }
        }
        .onAppear {
            viewModel.pullAllCharacters()
        }
        
    }
    
    private var content: some View {
        VStack(spacing: 8) {
            title
            charactersCollection
        }
        .background(Theme.backgroundColor)
    }
    
    private var title: some View {
        HStack {
            CustomText(text: "Popular Characters".uppercased(),
                       style: CustomStyle( fontSize: 35, fontWeight: .bold)
            )
            
            Spacer()
            
            Button(action: {
                print("See all tapped")
            }) {
                HStack {
                    CustomText(text: "See all".uppercased(),
                               style: CustomStyle(fontSize: 20)
                    )
                    Image(systemName: "chevron.right")
                }
                .foregroundColor(Theme.foregroundColor)
            }
            .buttonStyle(PlainButtonStyle())
            .background(Color.clear)
        }
        .padding(.horizontal, 20)
    }
    
    private var charactersCollection: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHGrid(rows: rows, spacing: 20) {
                ForEach(viewModel.characters) { character in
                    NavigationLink(destination: ComicsCollectionView(character: character)) {
                        characterCell(for: character)
                            .focusable()
                    }
                }
            }
        }
        .focusSection()
    }
    
    private func characterCell(for character: Character) -> some View {
        VStack(alignment: .center, spacing: 10) {
            CustomAsyncImage(url: character.thumbnail.url,
                             frame: CGSize(width: 200, height: 150)
            )
            .clipShape(Ellipse())
            .overlay(Ellipse().stroke(Color.white, lineWidth: 2))
           
            VStack {
                CustomText(text: character.name.uppercased(),
                           style: CustomStyle(alignment: .center)
                )
            }
            .frame(height: 100)
        }
        .frame(width: 250)
    }
}

