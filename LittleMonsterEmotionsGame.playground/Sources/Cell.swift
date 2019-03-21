import Foundation
import UIKit
import PlaygroundSupport

public class CardCollectionViewCell: UICollectionViewCell {
    
    public var front: UIImageView!
    public var back: UIImageView!
    public var card: Card?
    
    public func setCard(card: Card) {
        self.card = card
        self.front = UIImageView(image:  UIImage(named: card.imageName))
        self.back = UIImageView(image:  UIImage(named: "back.png"))
        self.backgroundView = back
        print(card.imageName)
        
        if card.isFlipped == true{
            UIView.transition(from: back, to: front, duration: 0, options: [.transitionFlipFromLeft, .showHideTransitionViews], completion: nil)
            self.backgroundView = front
        }else{
            UIView.transition(from: front, to: back, duration: 0, options: [.showHideTransitionViews, .transitionFlipFromLeft], completion: nil)
            self.backgroundView = back

        }
        
    }
    
    public func flip() {
        
        UIView.transition(from: back, to: front, duration: 4.0, options: [.transitionFlipFromLeft, .showHideTransitionViews], completion: nil)
        self.backgroundView = front
    }
    
    public func flipBack() {
        
        UIView.transition(from: front, to: back, duration: 4.0, options: [.showHideTransitionViews, .transitionFlipFromLeft], completion: nil)
        self.backgroundView = back
    }
}
