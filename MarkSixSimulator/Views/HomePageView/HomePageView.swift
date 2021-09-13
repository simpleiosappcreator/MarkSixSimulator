//
//  HomePageView.swift
//  MarkSixSimulator
//
//  Created by HAHA on 18/7/2021.
//

import SwiftUI

struct HomePageView: View {
    @EnvironmentObject var tempVM: TempViewModel
    @State var isAnimated: Bool = false
    @Binding var currentSeletion: Int
    @State var isSaved: Bool = false
    let column: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    var body: some View {
        NavigationView{
            ZStack{
                Color.theme.background.ignoresSafeArea()
                VStack{
                    Text("Lucky Numbers for you!")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(Color.theme.secondary)
                    
                    HStack(spacing: 15){
                        ForEach(tempVM.mainPageLuckyNumbers.numbers, id: \.self) { number in
                            CreateBallsView(ballColor: Color.purple, number: number)
                                .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .bottom)))
                                .animation(.spring())
                        }
                    }
                    .onTapGesture(perform: {
                        tempVM.createMainPageLuckyNumbers()
                    })
                    .onLongPressGesture(minimumDuration: 1.0, maximumDistance: 50) {
                        tempVM.addHomePageNumbersToFavouriteNumbers(model: tempVM.mainPageLuckyNumbers)
                        isSaved = true
                    }
                    
                    VStack{
                        Image(systemName: "chevron.compact.up")
                        Text("Tap to change Lucky Numbers! OR")
                            .foregroundColor(Color.theme.secondary)
                        Text("Press for 1 second to save to collection!")
                            .foregroundColor(Color.theme.secondary)
                    }
                    .offset(y: isAnimated ? 0 : 5)
                    
                    Spacer()
                    
                    Text("Useful Pages")
                    
                    LazyVGrid(columns: column, content: {
                        Button(action: {
                            currentSeletion = 1
                        }, label: {
                            OtherPageButtonsView(title: "Numbers Generator")
                        })
                        
                        Button(action: {
                            currentSeletion = 2
                        }, label: {
                            OtherPageButtonsView(title: "Your Lucky Numbers")
                        })
                        
                        Button(action: {
                            currentSeletion = 3
                        }, label: {
                            OtherPageButtonsView(title: "Collection")
                        })
                    })
                }
                .padding()
                
                if isSaved{
                    ZStack{
                        SaveSuccessfullyView()
                            .transition(.move(edge: .trailing))
                            .padding(.horizontal)
                    }
                    .zIndex(1.0)
                    .onAppear {
                        movementOfSaveSuccessfullyView()
                    }
                }
            }
            .navigationTitle("Home Page")
            .onAppear(perform: tempVM.createMainPageLuckyNumbers)
            .onAppear(perform: animation)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    func animation(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            withAnimation(.easeInOut(duration: 1.0).repeatForever()) {
                isAnimated.toggle()
            }
        }
    }
    
    func movementOfSaveSuccessfullyView(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            withAnimation(.spring(response: 2.0, dampingFraction: 0.8)) {
                isSaved = false
            }
        }
    }
}

struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView(currentSeletion: .constant(0))
            .preferredColorScheme(.dark)
    }
}
