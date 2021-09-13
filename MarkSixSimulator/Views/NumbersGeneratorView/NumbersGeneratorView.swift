//
//  CreateSixBallsView.swift
//  MarkSixSimulator
//
//  Created by HAHA on 18/7/2021.
//

import SwiftUI

struct NumbersGeneratorView: View {
    @EnvironmentObject var tempVM: TempViewModel
    @State var changeButtonColor: Bool = false
    @State var isButtonTaped: Bool = false
    var body: some View {
        NavigationView{
            ZStack{
                Color.theme.background.ignoresSafeArea()
                VStack {
                    Button(action: {
                        tempVM.createLuckyNumbersOnCreateSixBallsPage()
                        isButtonTaped = true
                        tempVM.chaseBottomModelOnCreateSixBallsPage()
                    }, label: {
                        Text("Try Your Luck!")
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .padding()
                            .scaleEffect(changeButtonColor ? 1.1 : 1.0)
                            .background(changeButtonColor ? Color(#colorLiteral(red: 0.5807225108, green: 0.066734083, blue: 0, alpha: 1)) : Color(#colorLiteral(red: 0.004859850742, green: 0.09608627111, blue: 0.5749928951, alpha: 1)))
                            .cornerRadius(25)
                            .offset(y: changeButtonColor ? -10 : 0)
                            .padding()
                    })
                    .onAppear(perform: changeButtonColorAnimation)
                    
                    HStack(spacing: 15){
                        ForEach(tempVM.createSixBallsPageLuckyNumbers, id: \.self) { number in
                            CreateBallsView(ballColor: Color.purple, number: number)
                        }
                    }
                    
                    if isButtonTaped{
                        Text("Historical Numbers")
                            .font(.title2)
                            .foregroundColor(Color.theme.secondary)
                        
                        Text("(Tap to add to collection)")
                            .font(.system(size: 13))
                            .foregroundColor(Color.theme.secondary)
                    }
                    
                    if tempVM.sixNumbersModel.isEmpty{
                        Spacer()
                        Text("Try your luck!😎")
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundColor(Color.theme.secondary)
                        Spacer()
                    }else{
                        ScrollViewReader{ proxy in
                            List{
                                ForEach(tempVM.sixNumbersModel, content: { model in
                                    HStack {
                                        Image(systemName: model.isFavourite ? "heart.fill" : "heart")
                                            .foregroundColor(model.isFavourite ? .red : .gray)
                                            .frame(width: 15, height: 15)
                                        HStack {
                                            ForEach(model.numbers, id: \.self) { number in
                                                CreateBallsView(ballColor: Color(#colorLiteral(red: 0.4756349325, green: 0.4756467342, blue: 0.4756404161, alpha: 1)), number: number)
                                            }
                                        }
                                        .onTapGesture(perform: {
                                            tempVM.updateModelIsFavourite(model: model)
                                    })
                                    }
                                })
                                .onChange(of: tempVM.lastModelId, perform: { value in
                                    withAnimation(.spring()) {
                                        proxy.scrollTo(value, anchor: .bottom)
                                    }
                                })
                            }
                            .listStyle(PlainListStyle())
                        }
                    }
                    
                    Spacer()
                }
            }
            .navigationTitle("Numbers Generator")
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    func changeButtonColorAnimation(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            withAnimation(.easeInOut(duration: 1.0).repeatForever()) {
                changeButtonColor.toggle()
            }
        }
    }
}

struct CreateSixBallsView_Previews: PreviewProvider {
    static var previews: some View {
        NumbersGeneratorView()
            .preferredColorScheme(.dark)
    }
}
