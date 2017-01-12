import XCTest
import Foundation

class CardTests: XCTestCase {
    func testInitWithTemplate() {
        let card = Card(template: "S3")
        XCTAssertEqual(card.suit, "S")
        XCTAssertEqual(card.value, "3")
    }

    func testDescription() {
        let card = Card(suit: "S", value: "3")
        XCTAssertEqual(card.description, "S3")
    }

    func testScalarValue() {
        for i in 2...10 {
            let card = Card(suit: "S", value: String(i))
            XCTAssertEqual(card.scalarValue, i)
        }

        let faceCards = ["J", "Q", "K"]
        faceCards.forEach { value in
            let card = Card(suit: "S", value: value)
            XCTAssertEqual(card.scalarValue, 10)
        }

        let card = Card(suit: "S", value: "A")
        XCTAssertEqual(card.scalarValue, 11)
    }
}
