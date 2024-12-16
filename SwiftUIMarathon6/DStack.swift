//
//  DStack.swift
//  SwiftUIMarathon6
//
//  Created by @_@ on 16.12.2024.
//

import SwiftUI

/// Работает для простоты только с квадратами
struct DStack: Layout {
    enum Alignment {
        case horizontal
        case diagonal
    }
    
    var hSpacing: CGFloat = 0
    var vSpacing: CGFloat = 0
    var alignment: Alignment = .horizontal
    
    func sizeThatFits(
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout ()
    ) -> CGSize {
        CGSize(
            width: proposal.width ?? .zero,
            height: proposal.height ?? .zero
        )
    }
    
    func placeSubviews(
        in bounds: CGRect,
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout ()
    ) {
        guard !subviews.isEmpty else { return }
        
        switch alignment {
        case .horizontal:
            placeSubviewsHorizontal(in: bounds, subviews: subviews)
        case .diagonal:
            placeSubviewsDiagonal(in: bounds, subviews: subviews)
        }
    }
    
    private func placeSubviewsHorizontal(in bounds: CGRect, subviews: Subviews) {
        var nextX = bounds.minX
        
        let proposedWidth = (bounds.width - hSpacing * CGFloat(subviews.count - 1)) / CGFloat(subviews.count)
        
        subviews.forEach { subview in
            subview.place(
                at: CGPoint(x: nextX, y: bounds.midY),
                proposal: ProposedViewSize(
                    CGSize(
                        width: proposedWidth,
                        height: proposedWidth
                    )
                )
            )
            nextX += proposedWidth + hSpacing
        }
    }
    
    private func placeSubviewsDiagonal(in bounds: CGRect,subviews: Subviews) {
        var nextX = bounds.minX
        var nextY = bounds.maxY
        
        let proposedHeight = (bounds.height - vSpacing * CGFloat(subviews.count - 1)) / CGFloat(subviews.count)
        
        subviews.forEach { subview in
            subview.place(
                at: CGPoint(x: nextX, y: nextY),
                anchor: .bottomLeading,
                proposal: ProposedViewSize(
                    CGSize(
                        width: proposedHeight,
                        height: proposedHeight
                    )
                )
            )
            nextX += (bounds.width - proposedHeight) / CGFloat(subviews.count - 1)
            nextY -= (proposedHeight + vSpacing)
        }
    }
}

#Preview {
    @Previewable @State var alignment: DStack.Alignment = .horizontal
    
    DStack(hSpacing: 4, vSpacing: 10, alignment: alignment) {
        ForEach(Array(1...10), id: \.self) { _ in
            Rectangle()
                .border(.blue)
        }
    }
    .border(.red)
    .onTapGesture {
        withAnimation {
            if alignment == .horizontal {
                alignment = .diagonal
            } else {
                alignment = .horizontal
            }
        }
    }
}
