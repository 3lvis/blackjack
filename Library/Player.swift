struct Player {
    var name: String
    var cards = [Card]()

    var value: Int {
        var total = 0

        for card in cards {
            total += card.scalarValue
        }

        return total
    }

    init(name: String) {
        self.name = name
    }

    static func player() -> Player {
        return Player(name: "Player")
    }

    static func dealer() -> Player {
        return Player(name: "Dealer")
    }
}
