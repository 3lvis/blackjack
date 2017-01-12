import XCTest
import Foundation

class GameTests: XCTestCase {
    func testPlayerGetsBlackjackOnFirstDraw() {
        var game = Game(template: "C3, C2, CK, CA")
        let winner = game.play()
        XCTAssertEqual(winner.name, Player.player().name)
        XCTAssertEqual(winner.value, 21)

        XCTAssertEqual(game.dealer.value, 5)
    }

    func testDealerGetsBlackjackOnFirstDraw() {
        var game = Game(template: "CK, CA, C3, C2")
        let winner = game.play()
        XCTAssertEqual(winner.name, Player.dealer().name)
        XCTAssertEqual(winner.value, 21)

        XCTAssertEqual(game.player.value, 5)
    }

    func testPlayerGetsMoreThan21() {
        var game = Game(template: "C9, C6, C2, C3, C4, C5")
        let winner = game.play()
        XCTAssertEqual(winner.name, Player.dealer().name)
        XCTAssertEqual(winner.value, 5)

        XCTAssertEqual(game.player.value, 24)
    }

    func testDealerHasLessThanPlayerOnFirstDrawGetsMoreThan21Later() {
        var game = Game(template: "C9, C7, C9, C9, C8")
        let winner = game.play()
        XCTAssertEqual(winner.name, Player.player().name)
        XCTAssertEqual(winner.value, 17)

        XCTAssertEqual(game.dealer.value, 25)
    }

    func testDealerWinsCloserTo21() {
        var game = Game(template: "CK, C9, C9, C9")
        let winner = game.play()
        XCTAssertEqual(winner.name, Player.dealer().name)
        XCTAssertEqual(winner.value, 19)

        XCTAssertEqual(game.player.value, 18)
    }
}
