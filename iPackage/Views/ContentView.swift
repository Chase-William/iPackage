//
//  ContentView.swift
//  iPackage
//
//  Created by xamarinapple on 4/10/22.
//

import SwiftUI

enum Views {
    case Search
    case Saved
}

struct ContentView: View {
    
    var body: some View {
        TabView {
            SearchView()
            
            SavedPackagesView()
        }
    }
}
