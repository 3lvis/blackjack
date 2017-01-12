import Foundation

struct Card: Equatable {
    static let suits = ["C", "D", "H", "S"]
    static let values = ["2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K", "A"]

    let suit: String
    let value: String

    var description: String {
        return suit + value
    }

    init(template: String) {
        self.suit = String(template.characters.first!)
        self.value = template.replacingOccurrences(of: suit, with: "")
    }

    init(suit: String, value: String) {
        self.suit = suit
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

