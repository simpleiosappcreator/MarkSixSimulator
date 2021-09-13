//
//  OtherPageButtonsView.swift
//  MarkSixSimulator
//
//  Created by HAHA on 18/7/2021.
//

import SwiftUI

struct OtherPageButtonsView: View{
    let title: String
    var body: some View{
        RoundedRectangle(cornerRadius: 25.0)
            .fill(Color.gray)
            .frame(width: UIScreen.main.bounds.width * 0.45, height: UIScreen.main.bounds.height / 7)
            .overlay(HStack{
                Text(title)
                    .foregroundColor(.white)
                Image(systemName: "chevron.right")
            })
    }
}

struct OtherPageButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        OtherPageButtonsView(title: "1")
    }
}
