//
//  ContentView.swift
//  Example
//
//  Created by Nicholas Bellucci on 5/10/20.
//  Copyright © 2020 Nicholas Bellucci. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var selectedIndex: Int = 0
    @State var badgeValue1: String? = "1"
    
    var body: some View {
        StatefulTabView(selectedIndex: $selectedIndex) {
            Tab(title: "Tab 1", systemImageName: "circle.fill", badgeValue: $badgeValue1) {
                NavigationView {
                    List {
                        Section {
                            ForEach(0..<20, id: \.self) { index in
                                NavigationLink(destination: PushedView(text: "Pushed number \(index)")) {
                                    Text("\(index)")
                                }
                            }
                        }
                    }
                    .navigationBarTitle("Navigation View 1")
                }
            }
            
            Tab(title: "Tab 2", systemImageName: "square.fill") {
                NavigationView{
                    List {
                        Section {
                            ForEach(0..<20, id: \.self) { index in
                                NavigationLink(destination: PushedView(text: "Pushed number \(index)")) {
                                    Text("\(index)")
                                }
                            }
                        }
                    }
                    .navigationBarTitle("Navigation View 2")
                }
            }
            
            Tab(title: "Tab 3", image: UIImage(systemName: "triangle.fill")) {
                NavigationView{
                    List {
                        Section {
                            ForEach(0..<20, id: \.self) { index in
                                NavigationLink(destination: PushedView(text: "Pushed number \(index)")) {
                                    Text("\(index)")
                                }
                            }
                        }
                    }
                    .navigationBarTitle("Navigation View 3")
                }
            }
        }
        .barTintColor(.red)
        .barBackgroundColor(.yellow)
        .barAppearanceConfiguration(.transparent)
    }
}

struct PushedView: View {
    var text: String
    
    var body: some View {
        Text(text)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}