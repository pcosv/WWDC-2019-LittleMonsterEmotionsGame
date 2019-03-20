import Foundation
import UIKit
import PlaygroundSupport


public class MyViewControllerStart: UIViewController {
    
    public override func loadView(){
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.2509803922, green: 0.03529411765, blue: 0.4352941176, alpha: 1)
        
        let play = UIButton()
        play.frame = CGRect(x: 260, y: 400, width: 100, height: 40)
        play.backgroundColor = #colorLiteral(red: 0.9568627451, green: 0.9137254902, blue: 0.3137254902, alpha: 1)
        play.layer.cornerRadius = 12
        play.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: UIControl.State.normal)
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
