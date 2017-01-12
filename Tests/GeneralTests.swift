import XCTest
import Foundation

class GeneralTests: XCTestCase {
    func testWithFile() {
        let (_, winners) = FileReader.processGames(logging: true)

        let expectedWinners = ["Dealer", "Player"]
        XCTAssertEqual(winners.map { $0.name }, expectedWinners)
    }
}
