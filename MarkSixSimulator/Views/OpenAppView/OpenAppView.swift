//
//  MainPageView.swift
//  MarkSixSimulator
//
//  Created by HAHA on 18/7/2021.
//

import SwiftUI

struct OpenAppView: View {
    @State var currentSelection: Int = 0
    var body: some View {
        TabView(selection: $currentSelection,
                content:  {
                    HomePageView(currentSeletion: $currentSelection)
                        .tabItem { VStack{
                            Image(systemName: "house.fill")
                            Text("Home Page")
                        }
                        }
                        .tag(0)
                        
                    NumbersGeneratorView()
                        .tabItem { VStack{
                            Image(systemName: "lightbulb.fill")
                            Text("Numbers Generator")
                        }
                        }
                        .tag(1)
                        
                    YourLuckyNumbersView()
                        .tabItem { VStack{
                            Image(systemName: "face.smiling.fill")
                            Text("Your Lucky Numbers")
                        }
                        }
                        .tag(2)
                    
                    CollectionView()
                        .tabItem { VStack{
                            Image(systemName: "heart.fill")
                            Text("Collection")
                        }
                        }
                        .tag(3)
            })
    }
}

struct OpenAppView_Previews: PreviewProvider {
    static var previews: some View {
        OpenAppView()
            .preferredColorScheme(.dark)
    }
}
