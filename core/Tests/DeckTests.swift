import XCTest
import Foundation

class DeckTests: XCTestCase {
    func testBasicDeck() {
        let deck = Deck()
        XCTAssertEqual(deck.cards.count, 52)
        XCTAssertEqual(deck.description, "C2, C3, C4, C5, C6, C7, C8, C9, C10, CJ, CQ, CK, CA, D2, D3, D4, D5, D6, D7, D8, D9, D10, DJ, DQ, DK, DA, H2, H3, H4, H5, H6, H7, H8, H9, H10, HJ, HQ, HK, HA, S2, S3, S4, S5, S6, S7, S8, S9, S10, SJ, SQ, SK, SA")
    }

    func testSuffle() {
        var deck = Deck()
        deck.shuffle()
    }

    func testDeckInitalizationFromTemplate() {
        let deck = Deck(template: "S3, H6, HA")

        var cards = [Card]()
        cards.append(Card(suit: "S", value: "3"))
        cards.append(Card(suit: "H", value: "6"))
        cards.append(Card(suit: "H", value: "A"))
        let comparedDeck = Deck(cards: cards)

        XCTAssertEqual(deck, comparedDeck)
    }

    func testDeckDescription() {
        var cards = [Card]()
        cards.append(Card(suit: "S", value: "3"))
        cards.append(Card(suit: "H", value: "6"))
        cards.append(Card(suit: "H", value: "A"))
        let deck = Deck(cards: cards)

        XCTAssertEqual(deck.description, "S3, H6, HA")
    }
}
