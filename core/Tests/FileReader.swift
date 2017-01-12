import Foundation

// Basic deck: C2, C3, C4, C5, C6, C7, C8, C9, C10, CJ, CQ, CK, CA, D2, D3, D4, D5, D6, D7, D8, D9, D10, DJ, DQ, DK, DA, H2, H3, H4, H5, H6, H7, H8, H9, H10, HJ, HQ, HK, HA, S2, S3, S4, S5, S6, S7, S8, S9, S10, SJ, SQ, SK, SA
class FileReader {
    static func gamesFromFile() -> [Game] {
        let bundle = Bundle(for: FileReader.self)
        let path = bundle.path(forResource: "Input", ofType: "txt")
        let text = try! String(contentsOfFile: path!, encoding: .utf8)
        let lines = text.lines

        var games = [Game]()
        for line in lines {
            games.append(Game(template: line))
        }

        return games
    }

    static func processGames(logging: Bool = false) -> ([Game], [Player]) {
        let games = self.gamesFromFile()
        var winners = [Player]()
        for var game in games {
            let winner = game.play()
            winners.append(winner)
        }

        for (index, winner) in winners.enumerated() {
            let game = games[index]
            print("Winner: \(winner.name) - Score: \(winner.value) - Cards: \(game.deck.description)")
        }

        return (games, winners)
    }
}

extension String {
    var lines: [String] {
        var result: [String] = []
        enumerateLines { line, _ in result.append(line) }
        return result
    }
}
