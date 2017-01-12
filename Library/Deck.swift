import Foundation

struct Deck: Equatable {
    var cards: [Card]

    init() {
        var cards = [Card]()

        for suit in Card.suits {
            for value in Card.values {
                cards.append(Card(suit: suit.rawValue, value: value))
            }
        }

        self.cards = cards
    }

    init(template: String) {
        let cardDescriptions = template.components(separatedBy: ", ")

        var cards = [Card]()

        for cardDescription in cardDescriptions {
            cards.append(Card(template: cardDescription))
        }

        self.cards = cards
    }

    init(cards: [Card]) {
        self.cards = cards
    }

    mutating func shuffle() {
        for _ in 0..<cards.count {
            let originalIndex = Int(arc4random_uniform(UInt32(cards.count)))
            let newIndex = Int(arc4random_uniform(UInt32(cards.count)))
            cards.insert(cards.remove(at: originalIndex), at: newIndex)
        }
    }

    mutating func draw() -> Card {
        return cards.removeLast()
    }

    var description: String {
        let descriptions = cards.map { $0.description }
        let game = descriptions.joined(separator: ", ")

        return game
    }
}

func ==(lhs: Deck, rhs: Deck) -> Bool {
    return lhs.description == rhs.description
}
