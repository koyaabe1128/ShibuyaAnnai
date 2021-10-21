import UIKit

class DstDetailViewController: UIViewController {
    @IBOutlet weak var dstName: UILabel!
    
    var received: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.backButtonDisplayMode = .minimal
        
        print(received)
        print(received[1])

    }
    
    override func viewWillAppear(_ animated: Bool) {
        dstName.text = received[1]
    }
    
}
