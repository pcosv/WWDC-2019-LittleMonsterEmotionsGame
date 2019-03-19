import Foundation
import UIKit
import PlaygroundSupport


public class MyViewControllerStart: UIViewController {
    
    public override func loadView(){
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.2509803922, green: 0.03529411765, blue: 0.4352941176, alpha: 1)
        
        let play = UIButton()
        play.frame = CGRect(x: 260, y: 300, width: 230, height: 40)
        play.backgroundColor = #colorLiteral(red: 0.9333333333, green: 0.2509803922, blue: 0.2078431373, alpha: 1)
        play.layer.cornerRadius = 12
        play.setTitle("ok", for: UIControl.State.normal)
        play.addTarget(self, action:#selector(buttonPress), for: .touchUpInside)
        view.addSubview(play)
        
        self.view = view
    }
    
    @objc func buttonPress() {
        var gameView = MatchGameViewController()
        print(gameView)
        present(gameView, animated: false, completion: nil)
    }
}
