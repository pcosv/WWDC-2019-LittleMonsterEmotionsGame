import Foundation
import UIKit
import PlaygroundSupport

public class MatchGameViewController : UIViewController{
    
    public var collectionView: UICollectionView!
    public var identifier: String = "Cell"
    var cardModel = CardModel()
    var cardArray = [Card]()

    
    public override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = #colorLiteral(red: 0.2509803922, green: 0.03529411765, blue: 0.4352941176, alpha: 1)
        
        let collectionView = UICollectionView(frame: CGRect(x: 100, y: 80, width: 600, height: 400), collectionViewLayout: UICollectionViewFlowLayout())
        

        self.collectionView = collectionView

        self.collectionView!.register(CardCollectionViewCell.self, forCellWithReuseIdentifier: identifier)

        cardArray = cardModel.getCards()

        // datasource and delegate
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        self.view.addSubview(collectionView)
        
    }
    
}

// MARK: - UICollectionView Protocol Methods

 extension MatchGameViewController: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return cardArray.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        print("criando célula de numero \(indexPath.row)")
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! CardCollectionViewCell
        print(cell)
        print("criou célula")
        
        let card = cardArray[indexPath.row]
        print(cardArray)
        
        cell.setCard(card: card)
        print("SE CHEGAR AQUI EH PORQUE FUNCIONOU PORRA")
        return cell
    }
}

 extension MatchGameViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}



