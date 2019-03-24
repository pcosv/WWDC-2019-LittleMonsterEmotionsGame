import Foundation
import UIKit
import PlaygroundSupport
import AVFoundation

public class MyViewControllerStart: UIViewController {
    
    public var songPlayer = AVAudioPlayer()
    var count = 0
    let intro = UILabel()
    let littleMonsterView = UIImageView()
    let previous = UIButton()


    
    public override func loadView(){
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.2509803922, green: 0.03529411765, blue: 0.4352941176, alpha: 1)
        
        intro.frame = CGRect(x: 90, y: 70, width: 600, height: 100)
        intro.text = "Hi!\nI’m Lilo, the little monster!"
        intro.font = UIFont(name: "KeepCalm-Medium", size: 30)
        intro.numberOfLines = 0
        intro.lineBreakMode = .byWordWrapping
        intro.textAlignment = NSTextAlignment.center
        intro.textColor = #colorLiteral(red: 0.9882352941, green: 0.9725490196, blue: 0.9294117647, alpha: 1)
        view.addSubview(intro)
        
        prepareSongAndSession()
        playSong()
        
        let name = "images/introI.png"
        let monsterImage = UIImage(named: name)
        littleMonsterView.image = monsterImage
        littleMonsterView.frame = CGRect(x: 250, y: 250, width: 250, height: 250)
        littleMonsterView.contentMode = .scaleAspectFit
        view.addSubview(littleMonsterView)
        
        let next = UIButton()
        next.frame = CGRect(x: 560, y: 500, width: 100, height: 40)
        next.layer.cornerRadius = 12
        next.setTitleColor(#colorLiteral(red: 0.9882352941, green: 0.9725490196, blue: 0.9294117647, alpha: 1), for: UIControl.State.normal)
        next.setTitle("next", for: UIControl.State.normal)
        next.titleLabel?.font = UIFont(name: "KeepCalm-Medium", size: 20)
        next.addTarget(self, action:#selector(buttonNextPress), for: .touchUpInside)
        view.addSubview(next)
        
        previous.frame = CGRect(x: 100, y: 500, width: 100, height: 40)
        previous.layer.cornerRadius = 12
        previous.setTitleColor(#colorLiteral(red: 0.9882352941, green: 0.9725490196, blue: 0.9294117647, alpha: 1), for: UIControl.State.normal)
        previous.setTitle("previous", for: UIControl.State.normal)
        previous.titleLabel?.font = UIFont(name: "KeepCalm-Medium", size: 20)
        previous.addTarget(self, action:#selector(buttonPreviousPress), for: .touchUpInside)
        previous.isHidden = true

        view.addSubview(previous)

        self.view = view

    }
    
    public func prepareSongAndSession() {
        
        do {
            songPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "songs/bensound-cute", ofType: "mp3")!))
            // Music: https://www.bensound.com
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
    
    
    @objc func buttonNextPress() {
        count = count + 1
        previous.isHidden = false
        
        if count == 1{
            intro.frame = CGRect(x: 90, y: 70, width: 600, height: 100)
            intro.text = "I really like listening to music!\nMy headphones are always with me!"
            
            let name = "images/introII.png"
            let monsterImage = UIImage(named: name)
            littleMonsterView.image = monsterImage
        }else if count == 2{
            intro.frame = CGRect(x: 90, y: 70, width: 600, height: 150)
            intro.text = "Music is closely related to our emotions. They can make us happy, excited, relaxed, calm and even sad..."
            
            let name = "images/introII.png"
            let monsterImage = UIImage(named: name)
            littleMonsterView.image = monsterImage
        } else if count == 3{
            intro.frame = CGRect(x: 90, y: 70, width: 600, height: 150)
            intro.text = "Come with me! Help me relate some of my favorite songs to the emotions they bring."
            
            let name = "images/introIII.png"
            let monsterImage = UIImage(named: name)
            littleMonsterView.image = monsterImage
        } else{
            
            pause()
            let gameView = MatchGameViewController()
            present(gameView, animated: true, completion: nil)
        }

    }
    
    @objc func buttonPreviousPress() {
        count = count - 1
        if count == 1{
            intro.frame = CGRect(x: 90, y: 70, width: 600, height: 100)
            intro.text = "I really like listening to music!\nMy headphones are always with me!"
            
            let name = "images/introII.png"
            let monsterImage = UIImage(named: name)
            littleMonsterView.image = monsterImage
        }else if count == 2{
            intro.frame = CGRect(x: 90, y: 70, width: 600, height: 150)
            intro.text = "Music is closely related to our emotions. They can make us happy, excited, relaxed, calm and even sad..."
            
            let name = "images/introII.png"
            let monsterImage = UIImage(named: name)
            littleMonsterView.image = monsterImage
        } else if count == 3{
            intro.frame = CGRect(x: 90, y: 70, width: 600, height: 150)
            intro.text = "Come with me! Help me relate some of my favorite songs to the emotions they bring."
            
            let name = "images/introIII.png"
            let monsterImage = UIImage(named: name)
            littleMonsterView.image = monsterImage
        } else{
            previous.isHidden = true
            intro.text = "Hi!\nI’m Lilo, the little monster!"
            
            let name = "images/introI.png"
            let monsterImage = UIImage(named: name)
            littleMonsterView.image = monsterImage
        }
    }

}
