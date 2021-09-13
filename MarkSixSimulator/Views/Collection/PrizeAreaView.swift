//
//  PrizeAreaView.swift
//  MarkSixSimulator
//
//  Created by HAHA on 21/7/2021.
//

import SwiftUI

struct PrizeAreaView: View{
    @Binding var numbers: [String]
    @Binding var firstPrizeArray: [Int]
    @Binding var secondPrizeArray: [NumberModel]
    @Binding var thirdPrizeArray: [NumberModel]
    var body: some View{
        PrizeTitle(title: "First Prize", color: Color(#colorLiteral(red: 0.9995340705, green: 0.988355577, blue: 0.4726552367, alpha: 1)))
        if firstPrizeArray.isEmpty{
            Text("Nothing here😌")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(Color.theme.secondary)
                .frame(maxWidth: .infinity)
                .frame(height: 50)
        }else{
            HStack{
                ForEach(firstPrizeArray, id: \.self) { number in
                    CreateBallsView(ballColor: Color.theme.red, number: number)
                }
            }
        }
        
        PrizeTitle(title: "Second Prize", color: Color(#colorLiteral(red: 0.370555222, green: 0.3705646992, blue: 0.3705595732, alpha: 1)))
        if secondPrizeArray.isEmpty{
            Text("Nothing here😌")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(Color.theme.secondary)
                .frame(maxWidth: .infinity)
                .frame(height: 50)
        }else{
            ForEach(secondPrizeArray) { model in
                HStack{
                    ForEach(model.numbers, id: \.self) { number in
                        CreateBallsView(ballColor: Color.theme.red, number: number)
                    }
                }
            }
        }
        
        PrizeTitle(title: "Third Prize", color: Color(#colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)))
        if thirdPrizeArray.isEmpty{
            Text("Nothing here😌")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(Color.theme.secondary)
                .frame(maxWidth: .infinity)
                .frame(height: 50)
        }else{
            ForEach(thirdPrizeArray) { model in
                HStack{
                    ForEach(model.numbers, id: \.self) { number in
                        CreateBallsView(ballColor: Color.theme.red, number: number)
                    }
                }
            }
        }
    }
}

struct PrizeTitle: View{
    let title: String
    let color: Color
    var body: some View{
        Text(title)
            .font(.title)
            .fontWeight(.semibold)
            .foregroundColor(Color.theme.secondary)
            .padding()
            .background(color)
    }
}
struct PrizeAreaView_Previews: PreviewProvider {
    static var previews: some View {
        PrizeAreaView(numbers: .constant([]), firstPrizeArray: .constant([]), secondPrizeArray: .constant([]), thirdPrizeArray: .constant([]))
    }
}
