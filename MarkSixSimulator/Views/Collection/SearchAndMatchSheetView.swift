//
//  SearchAndMatchSheetView.swift
//  MarkSixSimulator
//
//  Created by HAHA on 21/7/2021.
//

import SwiftUI

struct SearchAndMatchSheetView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var tempVM: TempViewModel
    @State var numbers: [String] = ["", "", "", "", "", "", ""]
    @State var firstPrizeArray: [Int] = []
    @State var secondPrizeArray: [NumberModel] = []
    @State var thirdPrizeArray: [NumberModel] = []
    
    var body: some View {
        ZStack{
            Color(#colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)).ignoresSafeArea()
            ScrollView(showsIndicators: false) {
                VStack{
                    HStack{
                        Spacer()
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }, label: {
                            Image(systemName: "xmark")
                                .foregroundColor(.white)
                                .frame(width: 50, height: 50)
                                .padding(.horizontal)
                        })
                    }
                    
                    Text("Search and Match Numbers")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(Color.theme.secondary)
                    
                    HStack{
                        TextField("No.1", text: $numbers[0])
                            .padding(.vertical)
                            .background(Color.theme.background.opacity(0.4).cornerRadius(5))
                        TextField("No.2", text: $numbers[1])
                            .padding(.vertical)
                            .background(Color.theme.background.opacity(0.4).cornerRadius(5))
                        TextField("No.3", text: $numbers[2])
                            .padding(.vertical)
                            .background(Color.theme.background.opacity(0.4).cornerRadius(5))
                        TextField("No.4", text: $numbers[3])
                            .padding(.vertical)
                            .background(Color.theme.background.opacity(0.4).cornerRadius(5))
                        TextField("No.5", text: $numbers[4])
                            .padding(.vertical)
                            .background(Color.theme.background.opacity(0.4).cornerRadius(5))
                        TextField("No.6", text: $numbers[5])
                            .padding(.vertical)
                            .background(Color.theme.background.opacity(0.4).cornerRadius(5))
                        TextField("S.N.", text: $numbers[6])
                            .padding(.vertical)
                            .background(Color.theme.background.opacity(0.4).cornerRadius(5))
                    }
                    
                    Button {
                        firstPrizeArray = []
                        secondPrizeArray = []
                        thirdPrizeArray = []
                        qualifiedNumbers()
                    } label: {
                        Text("Search!")
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color(#colorLiteral(red: 0, green: 0.3285208941, blue: 0.5748849511, alpha: 1)).cornerRadius(25))
                            .opacity(checkInputNumbersIfRepeated() ? 1.0 : 0.5)
                            .padding()
                    }
                    .disabled(!checkInputNumbersIfRepeated())
                    
                    PrizeAreaView(numbers: $numbers, firstPrizeArray: $firstPrizeArray, secondPrizeArray: $secondPrizeArray, thirdPrizeArray: $thirdPrizeArray)
                
                    Spacer()
                }
            }
        }
    }
}

struct SearchAndMatchSheetView_Previews: PreviewProvider {
    static var previews: some View {
        SearchAndMatchSheetView()
    }
}
