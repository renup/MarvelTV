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
            VStack(spacing: 15) {
                title
                charactersCollection
            }
            .onAppear {
                viewModel.pullAllCharacters()
            }
        }
    }
    
    private var title: some View {
        HStack {
            Text("POPULAR CHARACTERS")
                .font(.title)
                .foregroundStyle(.white)
            
            Spacer()
            
            Button(action: {
                print("See all tapped")
            }) {
                HStack {
                    Text("SEE ALL")
                    Image(systemName: "chevron.right")
                }
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
            AsyncImage(url: character.thumbnail.url) { image in
                image.resizable()
                     .aspectRatio(contentMode: .fill)
                     .frame(width: 200, height: 150)
                     .clipShape(Ellipse())
                     .overlay(Ellipse().stroke(Color.white, lineWidth: 2))
            } placeholder: {
                ProgressView()
            }
            
            Text(character.name.uppercased())
                .lineLimit(2)
                .truncationMode(.tail)
                .multilineTextAlignment(.center)
        }
        .frame(width: 250)
    }
}

