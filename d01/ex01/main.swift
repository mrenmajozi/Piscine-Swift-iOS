import AppKit

var card1 = Card(Color: Color.Spades, Value: Value.Ace)
var card2 = Card(Color: Color.Spades, Value: Value.Ace)
var card3 = Card(Color: Color.Spades, Value: Value.King)
var card4 = Card(Color: Color.Diamonds, Value: Value.Ace)

print("Compare Card1 & Card2")
print(card1.description)
print(card2.description)
print("Equal: isEqual(\(card1.isEqual(to: card2))) ==(\(card1 == card2))")
print("\nCompare Card1 & Card3")
print(card1.description)
print(card3.description)
print("Equal: isEqual(\(card1.isEqual(to: card3))) ==(\(card1 == card3))")
print("\nCompare Card1 & Card4")
print(card1.description)
print(card4.description)
print("Equal: isEqual(\(card1.isEqual(to: card4))) ==(\(card1 == card4))")
