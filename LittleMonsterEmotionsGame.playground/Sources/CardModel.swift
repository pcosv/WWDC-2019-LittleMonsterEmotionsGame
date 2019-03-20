import Foundation

public class CardModel {
    
    
    func getCards() -> [Card] {
        
        var generatedCardsArray = [Card]()
        for _ in 1...8{
            let randomNumber = arc4random_uniform(8) + 1
            
            let card = Card()
            card.imageName = "card\(randomNumber).jpg"
            generatedCardsArray.append(card)

            print(card)
            print(card.imageName)
        }
        
        return generatedCardsArray
    }
}
