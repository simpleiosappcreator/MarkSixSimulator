//
//  CollectionView.swift
//  MarkSixSimulator
//
//  Created by HAHA on 19/7/2021.
//

import SwiftUI

struct CollectionView: View {
    @EnvironmentObject var tempVM: TempViewModel
    @State var showSearchAndMatchSheet: Bool = false
    @State var showAlert: Bool = false
    
    var body: some View {
        NavigationView{
            ZStack{
                Color.theme.background.ignoresSafeArea()
                VStack{
                    Text("\(tempVM.amountOfLuckyNumbers) Lucky Numbers")
                        .font(.title2)
                        .foregroundColor(Color.theme.secondary)
                    
                    Text("(Purple: Numbers by generator)")
                        .font(.system(size: 13))
                        .foregroundColor(Color.theme.secondary)
                    
                    Text("(Pink: Numbers by user)")
                        .font(.system(size: 13))
                        .foregroundColor(Color.theme.secondary)
                    
                    Text("(Swipe left to delete a row of numbers)")
                        .font(.system(size: 13))
                        .foregroundColor(Color.theme.secondary)
                    
                    if tempVM.permanentFavouriteLuckyNumbers.isEmpty{
                        Spacer()
                        Text("Save some lucky numbers!🥳")
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundColor(Color.theme.secondary)
                        Spacer()
                    }else{
                        List{
                            ForEach(tempVM.permanentFavouriteLuckyNumbers) { models in
                                HStack(spacing: 15){
                                    ForEach(models.numbers, id: \.self) { number in
                                        CreateBallsView(ballColor: models.generationMethod == "By generation" ? Color.purple : Color.pink, number: number)
                                    }
                                }
                            }
                            .onDelete { IndexSet in
                                tempVM.deleteDataOnCollection(indexSet: IndexSet)
                            }
                        }
                        .listStyle(PlainListStyle())
                    }
                    
                    Spacer()
                }
            }
            .navigationTitle("Collection")
            .navigationBarItems(
                leading:
                    Button(action: {
                        showSearchAndMatchSheet.toggle()
                    }, label: {
                        Image(systemName: "magnifyingglass.circle.fill")
                    })
                    .sheet(isPresented: $showSearchAndMatchSheet, content: {
                        SearchAndMatchSheetView().environmentObject(self.tempVM)
                    }),
                trailing:
                    Button(action: {
                        showAlert.toggle()
                    }, label: {
                        Image(systemName: "arrow.clockwise")
                    })
                    .alert(isPresented: $showAlert, content: {
                        getAlert()
                    })
            )
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    func getAlert() -> Alert{
        return Alert(title: Text("Are you going to clear all the Lucky Numbers you have created?"), message: Text("Clear all Lucky Numbers"), primaryButton: .cancel(), secondaryButton: .destructive(Text("Clear"), action: {
            tempVM.sixNumbersModel = []
            tempVM.permanentFavouriteLuckyNumbers = []
            tempVM.createSixBallsPageLuckyNumbers = []
            tempVM.amountOfLuckyNumbers = 0
            tempVM.userLuckyNumbers = NumberModel(numbers: [], isFavourite: true, generationMethod: "By user")
        }))
    }
}

struct CollectionView_Previews: PreviewProvider {
    static var previews: some View {
        CollectionView()
    }
}
