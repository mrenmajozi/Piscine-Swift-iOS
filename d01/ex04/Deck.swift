import AppKit

class Deck: NSObject{
    static let allSpades:[Card] = Value.allValues.compactMap({Card(Color:Color.Spades, Value:$0)})
    static let allHearts:[Card] = Value.allValues.compactMap({Card(Color:Color.Hearts, Value:$0)})
    static let allClubs:[Card] = Value.allValues.compactMap({Card(Color:Color.Clubs, Value:$0)})
    static let allDiamonds:[Card] = Value.allValues.compactMap({Card(Color:Color.Diamonds, Value:$0)})
    static let allCards:[Card] = allSpades + allHearts + allClubs + allDiamonds
    var cards:[Card]
    var discards:[Card] = []
    var outs:[Card] = []
    override var description: String{
        get {
            return "Cards\n \(cards)"
        }
    }
    
    init(deckIsSorted: Bool) {
        cards = Deck.allCards
        
        if !deckIsSorted {
            cards.shuffle()
        }
    }
    
    func draw() -> Card {
        let drawnCard:Card = cards[0]
        cards.remove(at: 0)
        outs.append(drawnCard)
        return drawnCard
    }
    
    func fold(c: Card) {
        let ci:Int = outs.index(of: c)!
        discards.append(c)
        outs.remove(at: ci)
        
    }
}

extension Array where Element:Card {
    mutating func shuffle(){
        var copyArray:[Card] = self
        self = []
        
        while true {
            if (copyArray.count == 0) {
                break
            }
            let rand = Int(arc4random_uniform(UInt32(copyArray.count)))
            self.append(copyArray[rand] as! Element)
            copyArray.remove(at: rand)
        }
    }
}
