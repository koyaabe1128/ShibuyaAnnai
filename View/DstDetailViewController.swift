import UIKit

class DstDetailViewController: UIViewController {
    @IBOutlet weak var dstName: UILabel!
    
    var received: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(received)
        print(received[1])

    }
    
}
