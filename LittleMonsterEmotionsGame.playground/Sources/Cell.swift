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
        self.backgroundView = back
        
        if card.imageName == "card1.png" || card.imageName == "card2.png" || card.imageName == "card3.png" || card.imageName == "card4.png"{
            self.back = UIImageView(image:  UIImage(named: "backMonster.png"))
        } else{
            self.back = UIImageView(image:  UIImage(named: "backSong.png"))
        }
        
        if card.isMatched == true{
            back.alpha = 0
            front.alpha = 0
            return
        }else{
            back.alpha = 1
            front.alpha = 1
        }
        if card.isFlipped == true{
            UIView.transition(from: back, to: front, duration: 0, options: [.transitionFlipFromLeft, .showHideTransitionViews], completion: nil)
            self.backgroundView = front
        }else{
            UIView.transition(from: front, to: back, duration: 0, options: [.showHideTransitionViews, .transitionFlipFromLeft], completion: nil)
            self.backgroundView = back

        }
        
    }
    
    public func flip() {
        
        UIView.transition(from: back, to: front, duration: 0.8, options: [.transitionFlipFromLeft, .showHideTransitionViews], completion: nil)
        self.backgroundView = front
    }
    
    public func flipBack() {
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            UIView.transition(from: self.front, to: self.back, duration: 0.8, options: [.showHideTransitionViews, .transitionFlipFromLeft], completion: nil)
            self.backgroundView = self.back
        }
        
    }
    
    public func remove(){
        back.alpha = 0
        
        UIView.animate(withDuration: 2, delay: 0.9, options: .curveEaseOut, animations: {
            self.front.alpha = 0

        }, completion: nil)
    }
}
