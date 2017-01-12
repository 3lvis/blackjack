struct Game {
    var deck: Deck
    var sam: Player
    var dealer: Player

    init(template: String? = nil) {
        if let template = template {
            self.deck = Deck(template: template)
        } else {
            self.deck = Deck()
            self.deck.shuffle()
        }

        self.sam = Player.sam()
        self.dealer = Player.dealer()
    }

    mutating func play() -> Player {
        sam.cards.append(deck.draw())
        sam.cards.append(deck.draw())

        dealer.cards.append(deck.draw())
        dealer.cards.append(deck.draw())

        if sam.value == 21 {
            return sam
        }

        if dealer.value == 21 {
            return dealer
        }

        while sam.value < 17 {
            sam.cards.append(deck.draw())
        }

        if sam.value > 21 {
            return dealer
        }

        while dealer.value < sam.value {
            dealer.cards.append(deck.draw())
        }

        if dealer.value > 21 {
            return sam
        }

        let samCloser = 21 - sam.value
        let dealerCloser = 21 - dealer.value

        if samCloser > dealerCloser {
            return dealer
        } else {
            return sam
        }
    }
}
