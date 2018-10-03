var deck  = Deck(deckIsSorted: true)
var foldCard:Card

print("------START1------\nCards-> \(deck.cards)\n\nDiscards-> \(deck.discards)\n\nOuts-> \(deck.outs)")
foldCard = deck.draw()
print("\n------DRAW1------\nCard-> (\(foldCard))\n\nCards-> \(deck.cards)\n\nDiscards-> \(deck.discards)\n\nOuts-> \(deck.outs)")
deck.fold(c: foldCard)
print("\n------FOLD1------\nCards-> \(deck.cards)\n\nDiscards-> \(deck.discards)\n\nOuts-> \(deck.outs)")





var deck2  = Deck(deckIsSorted: false)
var foldCard2:Card
print("\n------START2------\nCards-> \(deck2.cards)\n\nDiscards-> \(deck2.discards)\n\nOuts-> \(deck2.outs)")
foldCard2 = deck2.draw()
print("\n------DRAW2------\nCard-> (\(foldCard2))\n\nCards-> \(deck2.cards)\n\nDiscards-> \(deck2.discards)\n\nOuts-> \(deck2.outs)")
deck2.fold(c: foldCard2)
print("\n------FOLD2------\nCards-> \(deck2.cards)\n\nDiscards-> \(deck2.discards)\n\nOuts-> \(deck2.outs)")
