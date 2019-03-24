import Foundation

public class CardModel {
    
    func getCards() -> [Card] {
        
        var generatedCardsArray = [Card]()

        var numbers =  [1, 2, 3, 4, 5, 6, 7, 8]
        
        for _ in 1...8{
            
            let aux = random(array: numbers)
            
            // sad
            if numbers[aux] == 1 || numbers[aux] == 5{
                let card = Card(imageName: "card\(numbers[aux]).png", isFlipped: false, isMatched: false, emotion: .sadness)
                generatedCardsArray.append(card)
                
                if numbers[aux] == 5{
                    card.songName = "sad"
                }

                
            // happy
            }else if numbers[aux] == 2 || numbers[aux] == 6{
                let card = Card(imageName: "card\(numbers[aux]).png", isFlipped: false, isMatched: false, emotion: .happiness)
                generatedCardsArray.append(card)
                
                if numbers[aux] == 6{
                    card.songName = "happy"
                }

                
            // relaxed
            }else if numbers[aux] == 3 || numbers[aux] == 7{
                let card = Card(imageName: "card\(numbers[aux]).png", isFlipped: false, isMatched: false, emotion: .chill)
                generatedCardsArray.append(card)
                
                if numbers[aux] == 7{
                    card.songName = "relaxed"
                }

                
            // motivated
            }else{
                let card = Card(imageName: "card\(numbers[aux]).png", isFlipped: false, isMatched: false, emotion: .motivation)
                generatedCardsArray.append(card)
                
                if numbers[aux] == 8{
                    card.songName = "motivated"
                }
                
            }
            
            numbers.remove(at: aux)
        }
        return generatedCardsArray
    }
    
    func random(array: [Int]) -> Int {
        let randomNumber = arc4random_uniform(UInt32(array.count))
        return Int(randomNumber)
    }
}
