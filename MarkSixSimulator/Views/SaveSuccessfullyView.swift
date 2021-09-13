//
//  SaveSuccessfullyView.swift
//  MarkSixSimulator
//
//  Created by HAHA on 21/7/2021.
//

import SwiftUI

struct SaveSuccessfullyView: View{
    var body: some View{
        VStack{
            HStack{
                Spacer()
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.gray)
                    .frame(width: 100, height: 50)
                    .overlay(
                        Image(systemName: "heart.fill")
                            .foregroundColor(Color.red)
                            .frame(width: 50, height: 50)
                    )
            }
            Spacer()
        }
    }
}

struct SaveSuccessfullyView_Previews: PreviewProvider {
    static var previews: some View {
        SaveSuccessfullyView()
    }
}
