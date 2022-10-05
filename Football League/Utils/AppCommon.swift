
import Foundation
import UIKit
import SDWebImage

extension UIImageView{
    func downloadImage(url:String){
        self.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: Constants.placeHolderimg))
    }
}

extension UIView{
    func addShadow(cornerRadius:CGFloat, offset: CGSize, color: UIColor, radius: CGFloat, opacity: Float) {
        layer.cornerRadius = cornerRadius
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowRadius = radius
        layer.shadowOffset = offset
    }
}
