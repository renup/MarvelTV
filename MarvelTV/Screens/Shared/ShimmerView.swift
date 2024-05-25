//
//  ShimmerView.swift
//  MarvelTV
//
//  Created by Renu Punjabi on 5/24/24.
//

import SwiftUI
import OSLog

private let logger = Logger(subsystem: "MarvelTV", category: "ShimmerView", forDebugBuild: true)

public struct ShimmerView: View {
    private enum AnimationPhase: CaseIterable {
        case fullVisible
        case shimmer
    }
    
    private let duration: Double = 0.8
    private let initialDelay: Double = 0.2
    private let cornerRadius: CGFloat = 5.0
    @State private var currentPhase: AnimationPhase = .fullVisible
    
    public init() {}
    
    public var body: some View {
        RoundedRectangle(cornerRadius: cornerRadius)
            .fill(.gray)
            .phaseAnimator(AnimationPhase.allCases, trigger: currentPhase) { content, phase in
                switch phase {
                case .fullVisible:
                    content.opacity(1.0)
                case .shimmer:
                    // Assuming shimmer effect changes opacity or adds some other visual effect.
                    content.opacity(0.5) // Customize as needed for the shimmer effect.
                }
            } animation: { phase in
                switch phase {
                case .fullVisible:
                    .easeInOut(duration: initialDelay)
                case .shimmer:
                    .easeInOut(duration: duration).repeatForever(autoreverses: true)
                }
            }
            .task {
                do {
                    try await Task.sleep(for: .seconds(initialDelay))
                    currentPhase = .shimmer
                } catch {
                    logger.debug("Shimmer Error: \(error)")
                }
            }
    }
}

#Preview {
    ShimmerView()
}
