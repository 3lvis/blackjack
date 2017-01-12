import XCTest
import Foundation

class GameTests: XCTestCase {
    func testSamGetsBlackjackOnFirstDraw() {
        var game = Game(template: "C3, C2, CK, CA")
        let winner = game.play()
        XCTAssertEqual(winner.name, Player.sam().name)
        XCTAssertEqual(winner.value, 21)

        XCTAssertEqual(game.dealer.value, 5)
    }

    func testDealerGetsBlackjackOnFirstDraw() {
        var game = Game(template: "CK, CA, C3, C2")
        let winner = game.play()
        XCTAssertEqual(winner.name, Player.dealer().name)
        XCTAssertEqual(winner.value, 21)

        XCTAssertEqual(game.sam.value, 5)
    }

    func testSamGetsMoreThan21() {
        var game = Game(template: "C9, C6, C2, C3, C4, C5")
        let winner = game.play()
        XCTAssertEqual(winner.name, Player.dealer().name)
        XCTAssertEqual(winner.value, 5)

        XCTAssertEqual(game.sam.value, 24)
    }

    func testDealerHasLessThanSamOnFirstDrawGetsMoreThan21Later() {
        var game = Game(template: "A9, C7, C9, C9, A8")
        let winner = game.play()
        XCTAssertEqual(winner.name, Player.sam().name)
        XCTAssertEqual(winner.value, 17)

        XCTAssertEqual(game.dealer.value, 25)
    }

    func testDealerWinsCloserTo21() {
        var game = Game(template: "CK, C9, C9, C9")
        let winner = game.play()
        XCTAssertEqual(winner.name, Player.dealer().name)
        XCTAssertEqual(winner.value, 19)

        XCTAssertEqual(game.sam.value, 18)
    }

    func testSamWinsCloserTo21() {
        // sam 19
        // dealer 17, ~20
        // sam closer = 2
        // dealer closer = 1

        var game = Game(template: "C3, C9, C8, CK, C9")
        let winner = game.play()
        XCTAssertEqual(winner.name, Player.sam().name)
        XCTAssertEqual(winner.value, 20)

        XCTAssertEqual(game.sam.value, 17)

    }
}
