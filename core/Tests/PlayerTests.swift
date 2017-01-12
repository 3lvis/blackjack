import XCTest
import Foundation

class PlayerTests: XCTestCase {
    func testValue() {
        var player = Player(name: "Test")
        player.cards = [Card(suit: "A", value: "2"), Card(suit: "A", value: "3")]

        XCTAssertEqual(player.value, 5)
    }
}
