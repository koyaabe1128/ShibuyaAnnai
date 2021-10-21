import UIKit

class AccessibleDstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var received: [String] = []
    var accessibleDstAry: [String] = []
    var accessibleDstAllData: [String] = []
    var selectedData: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        // CSVファイルの列をカンマ区切りで割って前画面で選択された[0]と同じ値を持つ目的地名を変数accessibleDstAryに入れる
        for row in csvAry {
            let object = row.components(separatedBy: ",")
            if object[0] == received[0] {
                accessibleDstAry.append(row)
            }
        }
        // しっかり値が渡されているか確認
        print(accessibleDstAry)
        
    }
    
    // 選択されたセルのデータを入れる
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        selectedData = accessibleDstAry[indexPath.row].components(separatedBy: ",")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDstDetailSegue" {
            let dstDetailVC = segue.destination as! DstDetailViewController
            dstDetailVC.received = selectedData
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accessibleDstAry.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "accessibleDstCell", for: indexPath)
        let dstInfo = accessibleDstAry[indexPath.row].components(separatedBy: ",")
        cell.textLabel!.text = dstInfo[1]
        return cell
    }
    
}
