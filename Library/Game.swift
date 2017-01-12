struct Game {
    var deck: Deck
    var player: Player
    var dealer: Player

    init(template: String? = nil) {
        if let template = template {
            self.deck = Deck(template: template)
        } else {
            self.deck = Deck()
            self.deck.shuffle()
        }

        self.player = Player.player()
        self.dealer = Player.dealer()
    }

    mutating func playerDraws() -> Card {
        let card = deck.draw()
        player.cards.append(card)

        return card
    }

    mutating func dealerDraws() -> Card {
        let card = deck.draw()
        dealer.cards.append(card)

        return card
    }

    mutating func play() -> Player {
        player.cards.append(deck.draw())
        player.cards.append(deck.draw())

        dealer.cards.append(deck.draw())
        dealer.cards.append(deck.draw())

        if player.value == 21 {
            return player
        } else if dealer.value == 21 {
            return dealer
        }

        while player.value < 17 {
            player.cards.append(deck.draw())
        }

        if player.value > 21 {
            return dealer
        }

        while dealer.value < player.value {
            dealer.cards.append(deck.draw())
        }

        if dealer.value > 21 {
            return player
        }

        let playerCloser = 21 - player.value
        let dealerCloser = 21 - dealer.value

        if playerCloser > dealerCloser {
            return dealer
        } else {
            return player
        }
    }
}
