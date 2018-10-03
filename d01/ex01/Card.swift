import AppKit

class Card: NSObject {
    var color: Color
    var value: Value
    override var description: String{
        get {
            return "Card: Value(\(value)) Color(\(color.rawValue))"
        }
    }
    
    init (Color: Color, Value: Value){
        self.color = Color
        self.value = Value
    }
    
    override func isEqual(to: Any?) -> Bool{
        if let otherCardObject = to as? Card {
            return (self.color == otherCardObject.color  && self.value == otherCardObject.value)
        } else {
            return false
        }
    }
    
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return (lhs.color == rhs.color && lhs.value == rhs.value)
    }
}
