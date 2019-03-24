import Foundation
import UIKit
import PlaygroundSupport
import AVFoundation

public class MatchGameViewController : UIViewController{
    
    public var collectionView: UICollectionView!
    public var identifier: String = "Cell"
    public var cardModel = CardModel()
    public var cardArray = [Card]()    
    
    public var songPlayer = AVAudioPlayer()
    
    var firstFlippedCard: IndexPath?
    let instruction = UILabel()
 
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = #colorLiteral(red: 0.2509803922, green: 0.03529411765, blue: 0.4352941176, alpha: 1)
        
        let collectionView = UICollectionView(frame: CGRect(x: 80, y: 60, width: 600, height: 400), collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = #colorLiteral(red: 0.2509803922, green: 0.03529411765, blue: 0.4352941176, alpha: 1)
        
        self.collectionView = collectionView
        
        self.collectionView!.register(CardCollectionViewCell.self, forCellWithReuseIdentifier: identifier)
        
        cardArray = cardModel.getCards()
        
        // datasource and delegate
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        instruction.frame = CGRect(x: 80, y: 430, width: 600, height: 100)
        instruction.text = "choose a song card"
        instruction.font = UIFont(name: "KeepCalm-Medium", size: 30)
        instruction.numberOfLines = 0
        instruction.lineBreakMode = .byWordWrapping
        instruction.textAlignment = NSTextAlignment.center
        instruction.textColor = #colorLiteral(red: 0.9882352941, green: 0.9725490196, blue: 0.9294117647, alpha: 1)
        view.addSubview(instruction)

        self.view.addSubview(collectionView)
        
    }
    
    public func prepareSongAndSession(song: String) {
        
        do {
            songPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "songs/\(song)", ofType: "mp3")!))
            songPlayer.prepareToPlay()
            
            let audioSession = AVAudioSession.sharedInstance()
            do {
                try
                    audioSession.setCategory(AVAudioSession.Category.playback, mode: .default, options: [])
            } catch let sessionError {
                
                print(sessionError)
            }
        } catch let songPlayerError {
            print(songPlayerError)
        }
    }
    
    public func playSong() {
        songPlayer.play()
    }
    
    public func pause() {
        songPlayer.pause()
    }
    
    
}

// MARK: - UICollectionView Protocol Methods

extension MatchGameViewController: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return cardArray.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! CardCollectionViewCell
        
        let card = cardArray[indexPath.row]
        
        cell.setCard(card: card)
        return cell
    }
}

extension MatchGameViewController: UICollectionViewDelegate {
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as! CardCollectionViewCell
        
        let card = cardArray[indexPath.row]
        
        if (card.imageName == "images/card1.png" && firstFlippedCard == nil) || (card.imageName == "images/card2.png" && firstFlippedCard == nil) || (card.imageName == "images/card3.png" && firstFlippedCard == nil) || (card.imageName == "images/card4.png" && firstFlippedCard == nil) {
            instruction.text = "first, choose a song card"
        } else{
            if card.isFlipped == false && card.isMatched == false{
                cell.flip()
                card.isFlipped = true
                
                // play song
                if card.songName != ""{
                    prepareSongAndSession(song: card.songName)
                    playSong()
                }
                
                if firstFlippedCard == nil{
                    firstFlippedCard = indexPath
                    instruction.text = "look for Lilo who is feeling this way"
                } else{
                    checkForMatches(secondFlippedCard: indexPath)
                }
            }else{
                cell.flipBack()
                card.isFlipped = false
                firstFlippedCard = nil
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2.5) {
                    self.instruction.text = "choose a song card"
                }
                
                if card.songName != ""{
                        self.prepareSongAndSession(song: card.songName)
                        self.pause()
                    
                }
            }
        }
        

    
    }
    
    func checkForMatches(secondFlippedCard: IndexPath) {
        let cardOneCell = collectionView.cellForItem(at: firstFlippedCard!) as! CardCollectionViewCell
        let cardTwoCell = collectionView.cellForItem(at: secondFlippedCard) as! CardCollectionViewCell
        
        let cardOne = cardArray[firstFlippedCard!.row]
        let cardTwo = cardArray[secondFlippedCard.row]
        
        if cardOne.emotion == cardTwo.emotion{
            cardOne.isMatched = true
            cardTwo.isMatched = true
            
            cardOneCell.remove()
            cardTwoCell.remove()
            
            checkGameEnded()
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2.0) {
                self.instruction.text = "yeah! choose another song card"
            }
            
            
        }else{
            cardOne.isFlipped = false
            cardTwo.isFlipped = false
            
            cardOneCell.flipBack()
            cardTwoCell.flipBack()
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2.5) {
                self.instruction.text = "choose a song card"
            }

            
        }
        
        if cardOne.songName != ""{
            
            self.prepareSongAndSession(song: cardOne.songName)
            self.pause()
        }
        if cardTwo.songName != ""{
            self.prepareSongAndSession(song: cardTwo.songName)
            self.pause()
        }
        
        if cardOneCell == nil{
            collectionView.reloadItems(at: [firstFlippedCard!])
        }
        
        firstFlippedCard = nil
    }
    
    func checkGameEnded() {
        var isWon = true
        
        for card in cardArray{
            if card.isMatched == false{
                isWon = false
                break
            }
        }
        
        if isWon == true{
            
            self.instruction.text = ""
            let end = MyViewControllerEnd()
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2.0) {
                self.present(end, animated: true, completion: nil)

            }
        }
        
        
    }
}

extension MatchGameViewController: UICollectionViewDelegateFlowLayout{
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width/4) - 10, height: (collectionView.frame.height/2) - 20)
    }
}
