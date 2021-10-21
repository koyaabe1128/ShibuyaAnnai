import UIKit

class DstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    @IBOutlet weak var dstTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var hoge: [String] = []
    var selectedCellData: [String] = []
    var test: [String] = []
    var test2: [String] = []
    var results: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.backButtonDisplayMode = .minimal
        
        searchBar.delegate = self
        
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
        
        for row in csvAry {
            _ = row.components(separatedBy: ",")
            test.append(row)
        }
        print(test)
        
        results = test
        
    }
    
    // 検索バーに書き込みがあった時に呼び出される
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText != "" {
            results = test.filter { dstName in
                return dstName.contains(searchText)
            } as Array
        } else {
            results = test
        }
        dstTableView.reloadData()
    }
    
    // 検索を押した時にキーボードを閉じる
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
    // 選択されたセルのデータを入れる
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        selectedCellData = results[indexPath.row].components(separatedBy: ",")
    }
    
    // セグエが"DstToDstDetailSegue"の時、DstDetailViewControllerの変数received に選択されたデータを代入
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DstToDstDetailSegue" {
            let dstDetailVC = segue.destination as! DstDetailViewController
            dstDetailVC.received = selectedCellData
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dstCell", for: indexPath)
        let dstInfo = results[indexPath.row].components(separatedBy: ",")
        cell.textLabel!.text = dstInfo[1]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}
