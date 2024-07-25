
import UIKit

extension UIFont {
    
    enum Montserrat: String {
        case bold = "Montserrat-Bold"
        case thin = "Montserrat-Thin"
        case light = "Montserrat-Light"
        case regular = "Montserrat-Regular"
        case medium = "Montserrat-Medium"
    }
    
    class func montserrat(ofSize fontSize: CGFloat, weight: Montserrat) -> UIFont {
        return UIFont(name: weight.rawValue, size: fontSize) ?? .systemFont(ofSize: fontSize)
    }
}
