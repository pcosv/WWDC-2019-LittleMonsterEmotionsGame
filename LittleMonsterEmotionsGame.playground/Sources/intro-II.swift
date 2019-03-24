import Foundation
import UIKit
import PlaygroundSupport

public class IntroViewController: UIViewController {
    
    
    public override func loadView(){
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.2509803922, green: 0.03529411765, blue: 0.4352941176, alpha: 1)
        
        let hi = UILabel()
        hi.frame = CGRect(x: 90, y: 90, width: 600, height: 150)
        //hi.backgroundColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
        hi.text = "I really like listening to music!\nMy headphones are always with me!"
        hi.font = UIFont(name: "KeepCalm-Medium", size: 35)
        hi.numberOfLines = 0
        hi.lineBreakMode = .byWordWrapping
        hi.textAlignment = NSTextAlignment.left
        hi.textColor = #colorLiteral(red: 0.9882352941, green: 0.9725490196, blue: 0.9294117647, alpha: 1)
        view.addSubview(hi)
        
        let name = "introII.png"
        let monsterImage = UIImage(named: name)
        let littleMonsterView = UIImageView(image: monsterImage!)
        littleMonsterView.frame = CGRect(x: 90, y: 250, width: 250, height: 250)
        littleMonsterView.contentMode = .scaleAspectFit
        view.addSubview(littleMonsterView)
        
        let play = UIButton()
        play.frame = CGRect(x: 560, y: 500, width: 100, height: 40)
        play.layer.cornerRadius = 12
        play.setTitleColor(#colorLiteral(red: 0.9882352941, green: 0.9725490196, blue: 0.9294117647, alpha: 1), for: UIControl.State.normal)
        play.setTitle("next", for: UIControl.State.normal)
        play.titleLabel?.font = UIFont(name: "KeepCalm-Medium", size: 20)
        play.addTarget(self, action:#selector(buttonPress), for: .touchUpInside)
        view.addSubview(play)
        
        self.view = view
        
    }
    
    
    @objc func buttonPress() {
        var gameView = IntroIIViewController()
        print(gameView)
        present(gameView, animated: false, completion: nil)
    }
}
