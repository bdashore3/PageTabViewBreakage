//
//  ContentView.swift
//  PagedTabViewTest
//
//  Created by Brian Dashore on 7/13/21.
//

import SwiftUI

struct Example: Hashable {
    var index: Int
    var showDummyView: Bool
}

struct ContentView: View {
    @State private var selection = 0
    private var testArray = [
        Example(index: 1, showDummyView: false),
        Example(index: 2, showDummyView: false),
        Example(index: 3, showDummyView: false),
        Example(index: 4, showDummyView: true)
    ]

    var body: some View {
        TabView(selection: $selection) {
            ForEach(testArray, id: \.self) { example in
                if example.showDummyView {
                    DummyView(index: example.index)
                } else {
                    ChildView(index: example.index)

                }
            }
        }
        .tabViewStyle(PageTabViewStyle())
    }
}

struct ChildView: View {
    var index: Int
    
    var body: some View {
        Text("Element \(index)")
        .onAppear {
            print("Normal view appeared")
        }
    }
}

struct DummyView: View {
    var index: Int
    
    var body: some View {
        Text("This is a dummy view on index \(index)")
            .onAppear {
                print("Dummy view appeared")
                print("Break")
            }
    }
}
