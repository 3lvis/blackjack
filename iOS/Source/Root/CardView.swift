import UIKit

class CardView: UIView {
    lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.text = "K"
        label.font = UIFont.medium(size: 40)

        return label
    }()

    lazy var suitImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "club")!)

        return imageView
    }()

    let isDealer: Bool
    let card: Card

    init(isDealer: Bool, card: Card) {
        self.isDealer = isDealer
        self.card = card

        let bounds = UIScreen.main.bounds
        let frame = CGRect(x: bounds.size.width, y: bounds.size.height, width: 126, height: 177)
        super.init(frame: frame)

        self.layer.cornerRadius = 10
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.3
        self.layer.shadowOffset = CGSize(width: -0.5, height: 0)

        self.backgroundColor = UIColor.white

        self.addSubview(self.valueLabel)
        self.valueLabel.textAlignment = isDealer ? .right : .left

        self.addSubview(self.suitImageView)

        self.valueLabel.text = card.value

        switch card.suit {
        case "C":
            self.suitImageView.image = UIImage(named: "club")!
            self.valueLabel.textColor = UIColor.black
        case "D":
            self.suitImageView.image = UIImage(named: "diamond")!
            self.valueLabel.textColor = UIColor.suitRed
        case "H":
            self.suitImageView.image = UIImage(named: "heart")!
            self.valueLabel.textColor = UIColor.suitRed
        case "S":
            self.suitImageView.image = UIImage(named: "spade")!
            self.valueLabel.textColor = UIColor.black
        default:
            fatalError("Invalid suit")
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        let valueLabelSize = CGFloat(48)
        let valueLabelMargin = CGFloat(10)
        if isDealer {
            self.valueLabel.frame = CGRect(x: self.frame.size.width - valueLabelSize - valueLabelMargin, y: valueLabelMargin, width: valueLabelSize, height: valueLabelSize)
        } else {
            self.valueLabel.frame = CGRect(x: valueLabelMargin, y: valueLabelMargin, width: valueLabelSize, height: valueLabelSize)
        }
        self.suitImageView.center = CGPoint(x: self.frame.width / 2, y: (self.frame.height / 2) + 10)
    }
}
