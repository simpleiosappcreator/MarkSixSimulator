//
//  YourOwnSixBalls.swift
//  MarkSixSimulator
//
//  Created by HAHA on 20/7/2021.
//

import SwiftUI

struct YourLuckyNumbersView: View {
    @EnvironmentObject var tempVM: TempViewModel
    @State var tappedBallsCount: Int = 0
    @State var userChoices: [Int] = []
    @State var isSaved: Bool = false
    let column: [GridItem] = [
        GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())
    ]
    var body: some View {
        NavigationView{
            ZStack{
                Color.theme.background.ignoresSafeArea()
                
                VStack{
                    if tempVM.userLuckyNumbers.numbers.isEmpty{
                        Text("Choose Your Lucky Numbers! 🤑")
                    }else{
                        Text("Lucky Numbers")
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundColor(Color.theme.secondary)
                        
                        HStack{
                            ForEach(tempVM.userLuckyNumbers.numbers, id: \.self) { number in
                                CreateBallsView(ballColor: Color.pink, number: number)
                            }
                        }
                    }
                    
                    ScrollView{
                        LazyVGrid(columns: column, content: {
                            ForEach(1..<50) { number in
                                CreateUserChoiceBallsView(number: number, tappedBallsCount: $tappedBallsCount, userChoices: $userChoices)
                            }
                        })
                        .padding(.bottom)
                        
                        VStack(spacing: 0){
                            Text("(Automatic generation of remain lucky numbers will execute if user chooses less than 6 numbers)")
                                .font(.system(size: 13))
                                .foregroundColor(Color.theme.secondary)
                                .multilineTextAlignment(.center)
                            
                            Button(action: {
                                tempVM.handleUserChoiceOnYourLuckyNumbersPage(numbers: userChoices)
                                
                                isSaved = true
                            }, label: {
                                Text("Add to collection!")
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color(#colorLiteral(red: 0, green: 0.3285208941, blue: 0.5748849511, alpha: 1)).cornerRadius(15))
                                    .padding()
                            })
                        }
                    }
                }
                
                if isSaved{
                    ZStack{
                        SaveSuccessfullyView()
                            .padding(.horizontal)
                    }
                    .zIndex(1.0)
                    .onAppear {
                        movementOfSaveSuccessfullyView()
                    }
                }
            }
            .navigationTitle("Your Lucky Numbers")
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    func movementOfSaveSuccessfullyView(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            withAnimation(.spring(response: 2.0, dampingFraction: 0.8)) {
                isSaved = false
            }
        }
    }
}

struct YourOwnSixBalls_Previews: PreviewProvider {
    static var previews: some View {
        YourLuckyNumbersView()
    }
}
 
