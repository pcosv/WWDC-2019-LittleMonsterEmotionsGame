/*:
 # Little Monster - Memory Game
 ![Playground Icon](images/introII.png width="310" height="250")
 
 ### About
 
 Little Monster is a children's memory game that explores the perception of the emotions aroused by music.
 
 * Callout(Purpose):
 The purpose is for the child to associate musical characteristics with emotional triggers related to four fundamental feelings: happiness, sadness, calmness, and enthusiasm.
 
 ### Gameplay
 
The game has the format of memory game, whose cards are indicated between music cards and monster cards. The child should turn up a music card, which will automatically begin to play, and then be instructed to look for the little monkey who is feeling the music.
 
 ### Requirements
 
 You may build and interact with Mosaic in the latest release of XCode (10.1).
 
 ### Credits
 
 All songs and sounds are from the sites:
 - https://www.bensound.com/
 - https://www.purple-planet.com/
 
 ---
 */


import UIKit
import PlaygroundSupport

let font = Bundle.main.url(forResource: "fonts/KeepCalm-Medium", withExtension: "ttf")! as CFURL
CTFontManagerRegisterFontsForURL(font, CTFontManagerScope.process, nil)


// Present the view controller in the Live View window
let startView = MyViewControllerStart()
startView.preferredContentSize = CGSize(width: 800, height: 600)
PlaygroundPage.current.liveView = startView
