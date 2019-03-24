import Foundation
import UIKit
import PlaygroundSupport
import AVFoundation

public class MyViewControllerEnd: UIViewController {
    
    public var songPlayer = AVAudioPlayer()
    let congrats = UILabel()
    let littleMonsterView = UIImageView()
    
    
    
    public override func loadView(){
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.2509803922, green: 0.03529411765, blue: 0.4352941176, alpha: 1)
        
        congrats.frame = CGRect(x: 90, y: 60, width: 600, height: 150)
        congrats.text = "Thank you very much for helping me! I really enjoyed listening to my favorite songs with you!"
        congrats.font = UIFont(name: "KeepCalm-Medium", size: 30)
        congrats.numberOfLines = 0
        congrats.lineBreakMode = .byWordWrapping
        congrats.textAlignment = NSTextAlignment.center
        congrats.textColor = #colorLiteral(red: 0.9882352941, green: 0.9725490196, blue: 0.9294117647, alpha: 1)
        view.addSubview(congrats)
        
        prepareSongAndSession()
        playSong()
        
        let name = "images/introIII.png"
        let monsterImage = UIImage(named: name)
        littleMonsterView.image = monsterImage
        littleMonsterView.frame = CGRect(x: 250, y: 200, width: 250, height: 250)
        littleMonsterView.contentMode = .scaleAspectFit
        view.addSubview(littleMonsterView)
        
        let restart = UIButton()
        restart.frame = CGRect(x: 300, y: 500, width: 150, height: 40)
        restart.layer.cornerRadius = 12
        restart.setTitleColor(#colorLiteral(red: 0.9882352941, green: 0.9725490196, blue: 0.9294117647, alpha: 1), for: UIControl.State.normal)
        restart.setTitle("play again", for: UIControl.State.normal)
        restart.titleLabel?.font = UIFont(name: "KeepCalm-Medium", size: 20)
        restart.addTarget(self, action:#selector(restartGame), for: .touchUpInside)
        view.addSubview(restart)
        
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
    
    
    @objc func restartGame() {
        
        pause()
        let game = MatchGameViewController()
        present(game, animated: false, completion: nil)
        
    }

    
}
