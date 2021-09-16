//
//  TempViewModel.swift
//  MarkSixSimulator
//
//  Created by HAHA on 18/7/2021.
//

import Foundation
import Combine

class TempViewModel: ObservableObject{
    
    static let instance = TempViewModel()
    
    @Published var sixNumbersModel: [NumberModel] = []
    @Published var permanentFavouriteLuckyNumbers: [NumberModel] = []{
        didSet{
            savePermanentFavouriteLuckyNumbers()
        }
    }
    @Published var mainPageLuckyNumbers: NumberModel = NumberModel(numbers: [], isFavourite: false, generationMethod: "By generator")
    @Published var createSixBallsPageLuckyNumbers: [Int] = []
    @Published var lastModelId: String = ""
    
    @Published var userLuckyNumbers: NumberModel = NumberModel(numbers: [], isFavourite: false, generationMethod: "By user")
    
    @Published var amountOfLuckyNumbers: Int = 0{
        didSet{
            saveAmountOfLuckyNumbers()
        }
    }
    
    var cancellable = Set<AnyCancellable>()
    let key1: String = "favourite numbers key"
    let key2: String = "amount of lucky numbers key"
    
    init(){
        createMainPageLuckyNumbers()
        getData()
    }
    
    func getData(){
        guard let data1 = UserDefaults.standard.data(forKey: key1),
              let decodedData1 = try? JSONDecoder().decode([NumberModel].self, from: data1) else{return}
        self.permanentFavouriteLuckyNumbers = decodedData1
        
        guard let data2 = UserDefaults.standard.data(forKey: key2),
              let decodedData2 = try? JSONDecoder().decode(Int.self, from: data2) else{return}
        self.amountOfLuckyNumbers = decodedData2
    }
    
    func savePermanentFavouriteLuckyNumbers(){
        if let encodedData = try? JSONEncoder().encode(permanentFavouriteLuckyNumbers){
            UserDefaults.standard.set(encodedData, forKey: key1)
        }
    }
    
    func saveAmountOfLuckyNumbers(){
        if let encodedData = try? JSONEncoder().encode(amountOfLuckyNumbers){
            UserDefaults.standard.set(encodedData, forKey: key2)
        }
    }
    
    func createLuckyNumbers(number: Int) -> [Int]{
        var ballsPool: [Int] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49]
        var numbers: [Int] = []
        var drawBallsCount = 0
        
        while drawBallsCount < number{
            let randomNumber = Int.random(in: 1...49-drawBallsCount)
            numbers.append(ballsPool[randomNumber-1])
            ballsPool.remove(at: randomNumber-1)
            drawBallsCount += 1
        }
        return numbers
    }
    
    func createRemainLuckyNumbersOnYourLuckyNumbersPage(number: Int, numbers: [Int]) -> [Int]{
        var ballsPool: [Int] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49]
        var remainNumbers: [Int] = []
        var drawBallsCount = 0
        
        for i in 0..<numbers.count{
            if let index = ballsPool.firstIndex(where: {$0 == numbers[i]}){
                ballsPool.remove(at: index)
            }
        }
        
        while drawBallsCount < number{
            let randomNumber = Int.random(in: 1...49-drawBallsCount-numbers.count)
            remainNumbers.append(ballsPool[randomNumber-1])
            ballsPool.remove(at: randomNumber-1)
            drawBallsCount += 1
        }
        return remainNumbers
    }
    
    func createMainPageLuckyNumbers(){
        let newModel = NumberModel(numbers: createLuckyNumbers(number: 6), isFavourite: false, generationMethod: "By generation")
        mainPageLuckyNumbers = newModel
    }
    
    func createLuckyNumbersOnCreateSixBallsPage(){
        createSixBallsPageLuckyNumbers = createLuckyNumbers(number: 6)
        let tempModel = NumberModel(numbers: createSixBallsPageLuckyNumbers, isFavourite: false, generationMethod: "By generation")
        sixNumbersModel.append(tempModel)
    }
    
    func updateModelIsFavourite(model: NumberModel){
        guard let index = sixNumbersModel.firstIndex(where: {$0.id == model.id}) else{return}
        sixNumbersModel[index] = model.updateFavourite()
        
        if sixNumbersModel[index].isFavourite{
            guard (permanentFavouriteLuckyNumbers.firstIndex(where: {$0.id == model.id}) == nil) else{return}
            permanentFavouriteLuckyNumbers.append(sixNumbersModel[index])
            amountOfLuckyNumbers += 1
        }else{
            guard let index2 = permanentFavouriteLuckyNumbers.firstIndex(where: {$0.id == model.id}) else{return}
            permanentFavouriteLuckyNumbers.remove(at: index2)
            amountOfLuckyNumbers -= 1
        }
    }
    
    func addHomePageNumbersToFavouriteNumbers(model: NumberModel){
        guard (permanentFavouriteLuckyNumbers.firstIndex(where: {$0.id == model.id}) == nil) else{return}
        permanentFavouriteLuckyNumbers.append(model)
        amountOfLuckyNumbers += 1
    }
    
    func updateModelIsFavouriteByDeletingOnCollection(model: NumberModel){
        guard let index = sixNumbersModel.firstIndex(where: {$0.id == model.id}) else{return}
        sixNumbersModel[index] = model.updateFavourite()
        
        if sixNumbersModel[index].isFavourite{
            guard (permanentFavouriteLuckyNumbers.firstIndex(where: {$0.id == model.id}) == nil) else{return}
            permanentFavouriteLuckyNumbers.append(sixNumbersModel[index])
            amountOfLuckyNumbers += 1
        }
    }
    
    func deleteDataOnCollection(indexSet: IndexSet){
        let indexSetToIndex = indexSet[indexSet.startIndex]
        updateModelIsFavouriteByDeletingOnCollection(model: permanentFavouriteLuckyNumbers[indexSetToIndex])
        
        
        permanentFavouriteLuckyNumbers.remove(atOffsets: indexSet)
        amountOfLuckyNumbers -= 1
    }
    
    func chaseBottomModelOnCreateSixBallsPage(){
        lastModelId = sixNumbersModel[sixNumbersModel.endIndex-1].id
    }
    
    func handleUserChoiceOnYourLuckyNumbersPage(numbers: [Int]){
        var finalNumbers: [Int] = numbers
        
        if numbers.count != 6{
            finalNumbers += createRemainLuckyNumbersOnYourLuckyNumbersPage(number: 6 - numbers.count, numbers: numbers)
        }
        
        let newModel = NumberModel(numbers: finalNumbers, isFavourite: true, generationMethod: "By user")
        userLuckyNumbers = newModel
        permanentFavouriteLuckyNumbers.append(userLuckyNumbers)
        amountOfLuckyNumbers += 1
    }
}

