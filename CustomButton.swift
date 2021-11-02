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
        
        self.layer.cornerRadius = 25
        self.setTitleColor(UIColor.white, for: .normal)
        self.layer.backgroundColor = UIColor.systemYellow.cgColor
        self.layer.shadowColor = UIColor.black.cgColor
        // 影の方向
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        // 影の濃さ
        self.layer.shadowOpacity = 0.1
        // 影のぼかし
        self.layer.shadowRadius = 1
        
    }
    
}

