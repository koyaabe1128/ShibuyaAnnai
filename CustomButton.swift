import Foundation
import UIKit

class CustomButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        customDesign()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        customDesign()
    }

    func customDesign() {
        
//        let image = UIImage(named: "dst.png")
//        self.setBackgroundImage(image, for: .normal)
        
        
        self.layer.cornerRadius = 7
        self.layer.backgroundColor = UIColor.white.cgColor
        self.layer.shadowColor = UIColor.black.cgColor
        // 影の方向
        self.layer.shadowOffset = CGSize(width: 0, height: 1)
        // 影の濃さ
        self.layer.shadowOpacity = 0.1
        // 影のぼかし
        self.layer.shadowRadius = 4
    }
    
}

