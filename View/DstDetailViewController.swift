import UIKit

class DstDetailViewController: UIViewController {
    @IBOutlet weak var dstName: UILabel!
    @IBOutlet weak var dstImage: UIImageView!
    @IBOutlet weak var dstName2: UILabel!
    @IBOutlet weak var dstExit: UILabel!
    @IBOutlet weak var dstAdress: UILabel!
    
    var csvAry: [String] = []
    var received: [String] = []
    var dstDetail: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.backButtonDisplayMode = .minimal
        
        // CSVファイルがない時にコンソールに出力
        guard let csvBundle = Bundle.main.path(forResource:"DstDetail", ofType:"csv") else {
            print("csvファイルがありません。")
            return
        }
        
        do {
            let csvString = try String(contentsOfFile: csvBundle, encoding: String.Encoding.utf8)
            csvAry = csvString.components(separatedBy: .newlines)
            csvAry.removeLast()
        } catch {
            print("エラー")
        }
        
        // DstDetail.csvから前画面で選択された目的地と同じ目的地の一列分を変数dstDetailに入れる
        for row in csvAry {
            let object = row.components(separatedBy: ",")
            if object[0] == received[0] {
                dstDetail.append(contentsOf: object)
            }
        }
        
        print(received)
        
        // タイトル
        dstName.text = dstDetail[0]
        
        // 目的地の画像
        let image = UIImage(named: dstDetail[0])
        dstImage.image = image
        
        // 目的地名
        dstName2.text = dstDetail[0]
        
        // 目的地に近い出口名
        dstExit.text = dstDetail[1]
        
        // 目的地の住所
        dstAdress.text = dstDetail[0]
        
    }
    
}
