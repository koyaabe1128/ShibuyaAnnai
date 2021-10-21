import UIKit

class DstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var hoge: [String] = []
    var selectedCellData: [String] = []
    
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
        
        // ソートしてみた
        for row in csvAry {
            let object = row.components(separatedBy: ",")
            hoge.append(object[1])
        }
//        print(hoge.sorted())
        
    }
    
    // 選択されたセルのデータを入れる
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        selectedCellData = csvAry[indexPath.row].components(separatedBy: ",")
//        print(selectedCellData)
    }
    
    // セグエが"DstToDstDetailSegue"の時、DstDetailViewControllerの変数received に選択されたデータを代入
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DstToDstDetailSegue" {
            let dstDetailVC = segue.destination as! DstDetailViewController
            dstDetailVC.received = selectedCellData
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return csvAry.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dstCell", for: indexPath)
        let dstInfo = csvAry[indexPath.row].components(separatedBy: ",")
        cell.textLabel!.text = dstInfo[1]
        return cell
    }
    
}
