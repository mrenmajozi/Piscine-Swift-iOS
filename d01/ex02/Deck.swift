import AppKit

class Deck: NSObject{
    static let allSpades:[Card] = Value.allValues.compactMap({Card(Color:Color.Spades, Value:$0)})
    static let allHearts:[Card] = Value.allValues.compactMap({Card(Color:Color.Hearts, Value:$0)})
    static let allClubs:[Card] = Value.allValues.compactMap({Card(Color:Color.Clubs, Value:$0)})
    static let allDiamonds:[Card] = Value.allValues.compactMap({Card(Color:Color.Diamonds, Value:$0)})
    static let allCards:[Card] = allSpades + allHearts + allClubs + allDiamonds
}
