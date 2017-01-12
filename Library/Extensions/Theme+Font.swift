import UIKit

extension UIFont {
    class func medium(size: Double) -> UIFont {
        return UIFont(name: "GTAmerica-Light", size: CGFloat(size)) ?? UIFont.systemFont(ofSize: CGFloat(size), weight: UIFontWeightMedium)
    }

    class func black(size: Double) -> UIFont {
        return UIFont(name: "GTAmerica-Black", size: CGFloat(size)) ?? UIFont.systemFont(ofSize: CGFloat(size), weight: UIFontWeightBlack)
    }
}
