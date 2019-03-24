import UIKit
import PlaygroundSupport

let font = Bundle.main.url(forResource: "fonts/KeepCalm-Medium", withExtension: "ttf")! as CFURL
CTFontManagerRegisterFontsForURL(font, CTFontManagerScope.process, nil)


// Present the view controller in the Live View window
let startView = MyViewControllerStart()
startView.preferredContentSize = CGSize(width: 800, height: 600)
PlaygroundPage.current.liveView = startView
