//
//  FavoriteGestureView.swift
//  iPackage
//
//  Created by xamarinapple on 4/19/22.
//

import SwiftUI

struct FavoriteGestureView<Content>: View where Content: View {
    var content: () -> Content
        
    @State private var isFavorite = false
    
    var body: some View {
        content()
            .animation(.default, value: 1.0)
            .scaleEffect(isFavorite ? 1.0 : 0.5)
    }
}

struct FavoriteGestureView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteGestureView() {
            Image(systemName: "heart")
                .font(.system(size: 100))
                .foregroundColor(.red)
        }
    }
}
