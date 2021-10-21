import UIKit

// CSVファイルの一行が一要素として入る
var csvAry: [String] = []

class ExitViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var exitTableView: UITableView!
    
    var showExitAry: [String] = []
    var selectedCellData: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.backButtonDisplayMode = .minimal
        
        // CSVファイルがない時にコンソールに出力
        guard let csvBundle = Bundle.main.path(forResource:"Exit", ofType:"csv") else {
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
        
        // CSVファイルの列をカンマ区切りで割って[0]がshowとなっている出口名を変数showExitAryに入れる
        for row in csvAry {
            let object = row.components(separatedBy: ",")
            if object[2] == "show" {
                showExitAry.append(object[0])
            }
        }
        // しっかり値が渡されている確認する
        print(showExitAry)
 
    }
    
    // 選択されたセルのデータを配列にして代入
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        selectedCellData = csvAry[indexPath.row].components(separatedBy: ",")
    }
    
    // セグエが"toAccessibleDstSegue"の時、AccessibleDstViewControllerの変数received に選択されたデータを代入
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAccessibleDstSegue" {
            let accessibleDstVC = segue.destination as! AccessibleDstViewController
            accessibleDstVC.received = selectedCellData
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return showExitAry.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "exitCell", for: indexPath)
        cell.textLabel!.text = showExitAry[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}
