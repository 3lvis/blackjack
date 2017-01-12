import XCTest
import Foundation

class PlayerTests: XCTestCase {
    func testValue() {
        var player = Player(name: "Test")
        player.cards = [Card(suit: "C", value: "2"), Card(suit: "C", value: "3")]

        XCTAssertEqual(player.value, 5)
    }
}
