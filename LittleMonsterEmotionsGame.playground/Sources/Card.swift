import Foundation

public class Card {
    
    var imageName: String
    var isFlipped: Bool
    var isMatched: Bool
    var emotion: Emotion
    var songName: String = ""
    
    init(imageName: String, isFlipped: Bool, isMatched: Bool, emotion: Emotion) {
        self.imageName = imageName
        self.isFlipped = isFlipped
        self.isMatched = isMatched
        self.emotion = emotion
    }
}

public enum Emotion {
    case happiness
    case sadness
    case motivation
    case chill
}
