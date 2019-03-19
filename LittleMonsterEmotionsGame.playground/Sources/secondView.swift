import Foundation
import UIKit
import PlaygroundSupport

public class MatchGameViewController : UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{
    
    public var collectionView: UICollectionView?
    
    public override func loadView() {
        self.view = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        view.backgroundColor = .green
        self.collectionView = UICollectionView(frame: CGRect(x: 125, y: 80, width: 500, height: 200), collectionViewLayout: UICollectionViewFlowLayout())
        
        self.collectionView?.frame = CGRect(x: 125, y: 80, width: 500, height: 200)
        self.collectionView?.backgroundColor = .white
        
        view.addSubview(collectionView!)
    }
    
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlayCell", for: indexPath)
        cell.backgroundColor = .green
        return cell
    }
}
