//
//  ContentView.swift
//  SwiftUIMarathon6
//
//  Created by @_@ on 16.12.2024.
//

import SwiftUI

struct ContentView: View {
    @State var alignment: DStack.Alignment = .horizontal
    
    var body: some View {
        DStack(hSpacing: 6, alignment: alignment) {
            ForEach(Array(1...7), id: \.self) { _ in
                RoundedRectangle(cornerRadius: 12)
                    .fill(.blue)
            }
        }
        .onTapGesture {
            withAnimation {
                alignment = alignment == .horizontal ? .diagonal : .horizontal
            }
        }
    }
}

#Preview {
    ContentView()
}
