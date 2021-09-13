//
//  CreateUserChoiceBallsView.swift
//  MarkSixSimulator
//
//  Created by HAHA on 20/7/2021.
//

import SwiftUI

struct CreateUserChoiceBallsView: View {
    @EnvironmentObject var tempVM: TempViewModel
    let number: Int
    @Binding var tappedBallsCount: Int
    @State var ballsColor: Color = Color.theme.blue
    @State var isChoosen: Bool = false
    @Binding var userChoices: [Int]
    var body: some View {
        Circle()
            .fill(ballsColor)
            .overlay(Text("\(number)").font(.title).fontWeight(.semibold).foregroundColor(.white))
            .frame(width: UIScreen.main.bounds.width / 8, height: UIScreen.main.bounds.width / 8)
            .onTapGesture {
                ballsColorChangeWhenTapped()
            }
    }
    
    func ballsColorChangeWhenTapped(){
        if tappedBallsCount >= 0 && tappedBallsCount < 6{
            if isChoosen{
                ballsColor = Color.theme.blue
                removeUntappedNumber(number: number)
                tappedBallsCount -= 1
            }else{
                ballsColor = Color.theme.red
                userChoices.append(number)
                tappedBallsCount += 1
            }
            isChoosen.toggle()
        }else if tappedBallsCount == 6{
            if isChoosen{
                    ballsColor = Color.theme.blue
                    removeUntappedNumber(number: number)
                    tappedBallsCount -= 1
                isChoosen.toggle()
            }
        }
    }
    
    func removeUntappedNumber(number: Int){
        guard let index = userChoices.firstIndex(where: {$0 == number}) else{return}
        userChoices.remove(at: index)
    }
}

struct CreateUserChoiceBallsView_Previews: PreviewProvider {
    static var previews: some View {
        CreateUserChoiceBallsView(number: 1, tappedBallsCount: .constant(6), userChoices: .constant([]))
    }
}
