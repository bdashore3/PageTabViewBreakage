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

class Store: ObservableObject {
    @Published var selected = 0
}

struct ContentView: View {
    @StateObject var store = Store()

    private var testArray = [
        Example(index: 1, showDummyView: false),
        Example(index: 2, showDummyView: false),
        Example(index: 3, showDummyView: false),
        Example(index: 4, showDummyView: true),
    ]

    var body: some View {
        TabView(selection: $store.selected) {
            ForEach(testArray, id: \.index) { example in
                IntermediateView(example: example, store: store)
                    .tag(example.index)
            }
        }
        .tabViewStyle(PageTabViewStyle())
    }
}

struct IntermediateView: View {
    @ObservedObject var store: Store
    var example: Example
    
    init(example: Example, store: Store) {
        self.store = store
        self.example = example
    }
    
    var body: some View {
        if example.showDummyView {
            DummyView(store: store, index: example.index)
        } else {
            ChildView(store: store, index: example.index)
        }
    }
}

struct ChildView: View {
    @ObservedObject var store: Store
    
    var index: Int
    
    var body: some View {
        Text("Element \(index)")
            .onChange(of: store.selected) { newIsSelected in
                if store.selected == index {
                    print("ChildView appeared")
                }
            }
    }
}

struct DummyView: View {
    @ObservedObject var store: Store
    
    var index: Int
    
    var body: some View {
        Text("This is a dummy view on index \(index)")
            .onChange(of: store.selected) { newIsSelected in
                if store.selected == index {
                    print("DummyView appeared")
                }
            }
    }
}
