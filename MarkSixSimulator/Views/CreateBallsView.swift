//
//  CreateBallsView.swift
//  MarkSixSimulator
//
//  Created by HAHA on 18/7/2021.
//

import SwiftUI

struct CreateBallsView: View {
    let ballColor: Color
    let number: Int
    var body: some View {
        Circle()
            .fill(ballColor)
            .overlay(Text("\(number)").font(.title).fontWeight(.semibold).foregroundColor(.white))
            .frame(width: UIScreen.main.bounds.width / 8, height: UIScreen.main.bounds.width / 8)
    }
}

struct CreateBallsView_Previews: PreviewProvider {
    static var previews: some View {
        CreateBallsView(ballColor: Color.theme.yellow, number: 1)
    }
}
