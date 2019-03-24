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
    let hi = UILabel()
 
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
        
        hi.frame = CGRect(x: 80, y: 430, width: 600, height: 100)
        hi.backgroundColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
        hi.text = "choose a song card"
        hi.font = UIFont(name: "KeepCalm-Medium", size: 30)
        hi.numberOfLines = 0
        hi.lineBreakMode = .byWordWrapping
        hi.textAlignment = NSTextAlignment.center
        hi.textColor = #colorLiteral(red: 0.9882352941, green: 0.9725490196, blue: 0.9294117647, alpha: 1)
        view.addSubview(hi)

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
            } else{
                checkForMatches(secondFlippedCard: indexPath)
            }
        }else{
            cell.flipBack()
            card.isFlipped = false
            firstFlippedCard = nil
            
            if card.songName != ""{
                prepareSongAndSession(song: card.songName)
                pause()
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
        }else{
            cardOne.isFlipped = false
            cardTwo.isFlipped = false
            
            cardOneCell.flipBack()
            cardTwoCell.flipBack()
            
        }
        
        if cardOne.songName != ""{
            prepareSongAndSession(song: cardOne.songName)
            pause()
        }
        if cardTwo.songName != ""{
            prepareSongAndSession(song: cardTwo.songName)
            pause()
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
            // apresentar view de vitória com botão de reiniciar o jogo
            print("ganhou")
        }
        
        
    }
}

extension MatchGameViewController: UICollectionViewDelegateFlowLayout{
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width/4) - 10, height: (collectionView.frame.height/2) - 20)
    }
}
