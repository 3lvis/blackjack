import Foundation

enum Suit: String {
    case club = "C"
    case diamond = "D"
    case heart = "H"
    case spade = "S"
}

struct Card: Equatable {
    static let suits: [Suit] = [.club, .diamond, .heart, .spade]
    static let values = ["2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K", "A"]

    let suit: Suit
    let value: String

    var description: String {
        return suit.rawValue + value
    }

    init(template: String) {
        self.suit = Suit(rawValue: String(template.characters.first!))!
        self.value = template.replacingOccurrences(of: suit.rawValue, with: "")
    }

    init(suit: String, value: String) {
        self.suit = Suit(rawValue: suit)!
        self.value = value
    }

    var scalarValue: Int {
        switch value {
            case "A":
            return 11
        case "J", "Q", "K":
            return 10
        case "2", "3", "4", "5", "6", "7", "8", "9", "10":
            let formatter = NumberFormatter()

            return formatter.number(from: value)!.intValue
        default:
            fatalError("Invalid value: \(value)")
        }
    }
}

func ==(lhs: Card, rhs: Card) -> Bool {
    return lhs.suit == rhs.suit && lhs.value == rhs.value
}

