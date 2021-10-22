import UIKit

class DstDetailViewController: UIViewController {
    @IBOutlet weak var dstName: UILabel!
    @IBOutlet weak var dstImage: UIImageView!
    @IBOutlet weak var dstName2: UILabel!
    @IBOutlet weak var dstExit: UILabel!
    @IBOutlet weak var dstAdress: UILabel!
    
    var received: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.backButtonDisplayMode = .minimal
        
        print(received)
        
        // 目的地名
        dstName.text = received[1]
        
        // 目的地の画像
        let image = UIImage(named: received[3])
        dstImage.image = image
        
        dstName2.text = received[1]
        
        // 目的地に近い出口名
        dstExit.text = received[0]
        
        dstAdress.text = received[4]
        
    }
    
}
