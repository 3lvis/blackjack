import UIKit

class GameController: UIViewController {
    lazy var dealerScoreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.black(size: 60)
        label.text = "0"
        label.textColor = UIColor.white

        return label
    }()

    lazy var playerScoreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.black(size: 60)
        label.text = "0"
        label.textColor = UIColor.white

        return label
    }()

    lazy var startNewGameButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Start new game", for: .normal)
        button.titleLabel?.font = UIFont.medium(size: 40)
        button.addTarget(self, action: #selector(startNewGame), for: .touchUpInside)

        return button
    }()

    var dealerCards = [CardView]()
    var playerCards = [CardView]()

    override var prefersStatusBarHidden: Bool {
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.tableColor
        self.view.addSubview(self.dealerScoreLabel)
        self.view.addSubview(self.playerScoreLabel)
        self.view.addSubview(self.startNewGameButton)

        let horizontalMargin = CGFloat(10.0)
        self.dealerScoreLabel.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.dealerScoreLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: horizontalMargin).isActive = true

        self.playerScoreLabel.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        self.playerScoreLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -horizontalMargin).isActive = true

        self.startNewGameButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.startNewGameButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
    }

    func startNewGame() {
        self.dealerCards.forEach { view in
            view.removeFromSuperview()
        }
        self.dealerCards.removeAll()

        self.playerCards.forEach { view in
            view.removeFromSuperview()
        }
        self.playerCards.removeAll()

        self.playerScoreLabel.text = "0"
        self.dealerScoreLabel.text = "0"

        startNewGameButton.isHidden = true

        var game = Game()

        let firstCardPlayer = game.playerDraws()
        self.updateScore(game: game)
        self.turn(isDealerTurn: false, card: firstCardPlayer) {

            let secondCardPlayer = game.playerDraws()
            self.updateScore(game: game)
            self.turn(isDealerTurn: false, card: secondCardPlayer) {

                let dealerFirstCard = game.dealerDraws()
                self.updateScore(game: game)
                self.turn(isDealerTurn: true, card: dealerFirstCard) {

                    let dealerSecondCard = game.dealerDraws()
                    self.updateScore(game: game)
                    self.turn(isDealerTurn: true, card: dealerSecondCard) {

                        if game.player.value == 21 {
                            self.updateWinner(isDealer: false, game: game)
                        } else if game.dealer.value == 21 {
                            self.updateWinner(isDealer: true, game: game)
                        } else {
                            self.drawMany(isDealer: false, game: game, continueWhile: { currentGame in
                                game = currentGame
                                if currentGame.player.value < 17 {
                                    return false
                                }

                                return true
                            }, completion: {
                                if game.player.value > 21 {
                                    self.updateWinner(isDealer: true, game: game)
                                } else {
                                    self.drawMany(isDealer: true, game: game, continueWhile: { currentGame in
                                        game = currentGame

                                        if game.dealer.value < game.player.value {
                                            return false
                                        }

                                        return true
                                    }, completion: {
                                        if game.dealer.value > 21 {
                                            self.updateWinner(isDealer: false, game: game)
                                        } else {
                                            let playerCloser = 21 - game.player.value
                                            let dealerCloser = 21 - game.dealer.value

                                            let dealerIsWinner = playerCloser > dealerCloser
                                            self.updateWinner(isDealer: dealerIsWinner, game: game)
                                        }
                                    })
                                }
                            })
                        }
                    }
                }
            }
        }
    }

    func drawMany(isDealer: Bool, game: Game, continueWhile: @escaping ((_ game: Game) -> (Bool)), completion: @escaping ((Void) -> (Void))) {
        var updatedGame = game
        let card: Card
        if isDealer {
            card = updatedGame.dealerDraws()
            self.updateScore(game: updatedGame)
        } else {
            card = updatedGame.playerDraws()
            self.updateScore(game: updatedGame)
        }
        self.turn(isDealerTurn: isDealer, card: card) {

            if continueWhile(updatedGame) {
                completion()
                return
            } else {
                self.drawMany(isDealer: isDealer, game: updatedGame, continueWhile: continueWhile, completion: completion)
            }
        }
    }

    func turn(isDealerTurn: Bool, card: Card, completion: @escaping ((Void) -> (Void))) {
        let margin = CGFloat(45.0)

        let cardView = CardView(isDealer: isDealerTurn, card: card)
        self.view.addSubview(cardView)
        var targetFrame = cardView.frame

        if isDealerTurn {
            targetFrame.origin.x = self.view.frame.size.width - cardView.frame.size.width - (margin + (margin * CGFloat(dealerCards.count)))
            targetFrame.origin.y = 100
            dealerCards.append(cardView)
        } else {
            targetFrame.origin.x = margin + (margin * CGFloat(playerCards.count))
            targetFrame.origin.y = self.view.frame.size.height - cardView.frame.size.height - 90
            playerCards.append(cardView)
        }

        UIView.animate(withDuration: 0.5, animations: {
            cardView.frame = targetFrame
        }, completion: { finished in
            completion()
        })
    }

    func updateWinner(isDealer: Bool, game: Game) {
        if isDealer {
            self.dealerScoreLabel.text = "\(game.dealer.value) 👑"
        } else {
            self.playerScoreLabel.text = "\(game.player.value) 👑"
        }

        self.startNewGameButton.isHidden = false
    }

    func updateScore(game: Game) {
        self.playerScoreLabel.text = "\(game.player.value)"
        self.dealerScoreLabel.text = "\(game.dealer.value)"
    }
}
