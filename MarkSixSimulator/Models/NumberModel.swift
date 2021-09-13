//
//  NumberModel.swift
//  MarkSixSimulator
//
//  Created by HAHA on 18/7/2021.
//

import Foundation

struct NumberModel: Identifiable, Codable{
    let id: String
    let numbers: [Int]
    let isFavourite: Bool
    let generationMethod: String
    
    init(id: String = UUID().uuidString, numbers: [Int], isFavourite: Bool, generationMethod: String){
        self.id = id
        self.numbers = numbers
        self.isFavourite = isFavourite
        self.generationMethod = generationMethod
    }
    
    func updateFavourite() -> NumberModel{
        return NumberModel(id: id, numbers: numbers, isFavourite: !isFavourite, generationMethod: generationMethod)
    }
}

