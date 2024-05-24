//
//  CharactersCollection.swift
//  MarvelTV
//
//  Created by Renu Punjabi on 5/23/24.
//

import SwiftUI
import OSLog

private let logger = Logger(subsystem: "MarvelTV", category: "MarvelCharactersView", forDebugBuild: true)


struct MarvelCharactersView: View {
    @State private var viewModel = CharactersCollectionViewModel()
    
    var rows = [
        GridItem(.flexible(), alignment: .center),
    ]
    
    var body: some View {
        VStack(spacing: 15) {
            title
            charactersCollection
        }
        .onAppear {
            viewModel.pullAllCharacters()
        }
    }
    
    private var title: some View {
        HStack {
            Text("Popular Characters")
                .foregroundStyle(.white)

            Spacer()

            Button(action: {
                print("See all tapped")
            }) {
                HStack {
                    Text("See All")
                    Image(systemName: "chevron.right")
                }
            }
            .buttonStyle(PlainButtonStyle()) // Ensures the button does not render with default button styling
            .background(Color.clear) // Add a background to increase the tappable area, if necessary
        }
        .padding(.horizontal, 20)
    }

    private var charactersCollection: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHGrid(rows: rows, spacing: 20) {
                ForEach(viewModel.characters) { character in
                    characterCell(for: character)
                        .focusable()
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

            Text(character.name)
                .lineLimit(2)
                .truncationMode(.tail)
                .multilineTextAlignment(.center)
        }
        .frame(width: 250)
    }
}


