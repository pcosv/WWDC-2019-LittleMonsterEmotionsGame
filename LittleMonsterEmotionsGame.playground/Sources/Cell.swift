import Foundation
import UIKit
import PlaygroundSupport

public class CardCollectionViewCell: UICollectionViewCell {
    
    public var front: UIImageView!
    public var back: UIImageView!
    public var card: Card?
    
    public func setCard(card: Card) {
        self.card = card
        
        print(card.imageName)
        front.image = UIImage(named: card.imageName)
        back.image = UIImage(named: "back.jpg")
        print("aqui não chega")
        
    }
    
    public func flip() {
        
    }
    
    public func flipBack() {
        
    }
}
