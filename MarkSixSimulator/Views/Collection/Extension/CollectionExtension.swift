//
//  CollectionExtension.swift
//  MarkSixSimulator
//
//  Created by HAHA on 22/7/2021.
//

import Foundation
extension SearchAndMatchSheetView{
    func checkInputNumbersRange() -> Bool{
        return (Int(numbers[0]) ?? 0 >= 1 && Int(numbers[0]) ?? 0 <= 49) && (Int(numbers[1]) ?? 0 >= 1 && Int(numbers[1]) ?? 0 <= 49) && (Int(numbers[2]) ?? 0 >= 1 && Int(numbers[2]) ?? 0 <= 49) && (Int(numbers[3]) ?? 0 >= 1 && Int(numbers[3]) ?? 0 <= 49) && (Int(numbers[4]) ?? 0 >= 1 && Int(numbers[4]) ?? 0 <= 49) && (Int(numbers[5]) ?? 0 >= 1 && Int(numbers[5]) ?? 0 <= 49) && (Int(numbers[6]) ?? 0 >= 1 && Int(numbers[6]) ?? 0 <= 49) ? true : false
    }
    
    func checkInputNumbersIfRepeated() -> Bool{
        if checkInputNumbersRange(){
            var overallCount = 0
            outerLoop: for i in 0..<numbers.count{
                var count = 0
                for j in 0..<numbers.count{
                    if i != j{
                        if numbers[i] == numbers[j]{
                            break outerLoop
                        }else{
                            count += 1
                        }
                    }
                }
                if count == 6{
                    overallCount += 1
                }else{
                    break
                }
            }
            if overallCount == 7{
                return true
            }else{
                return false
            }
        }
        return false
    }
    
    func qualifiedNumbers(){
        for i in 0..<tempVM.permanentFavouriteLuckyNumbers.count{
            var count = 0
            var hitSpecialNumber: Bool = false
            var notHitedNumbers: [Int] = []
            for j in 0..<6{
                var notHitCount = 0
                for w in 0..<6{
                    if tempVM.permanentFavouriteLuckyNumbers[i].numbers[j] == Int(numbers[w]) ?? 0{
                        count += 1
                        notHitCount += 1
                        break
                    }
                }
                if notHitCount == 0{
                    notHitedNumbers.append(tempVM.permanentFavouriteLuckyNumbers[i].numbers[j])
                }
            }
            
            if let _ = notHitedNumbers.firstIndex(where: {$0 == Int(numbers[6])}){
                hitSpecialNumber = true
            }
            
            if count >= 5{
                switch count{
                case 6:
                    firstPrizeArray = tempVM.permanentFavouriteLuckyNumbers[i].numbers
                    break
                case 5:
                    hitSpecialNumber ? secondPrizeArray.append(tempVM.permanentFavouriteLuckyNumbers[i]) : thirdPrizeArray.append(tempVM.permanentFavouriteLuckyNumbers[i])
                    break
                default:
                    break
                }
            }
        }
    }
}
