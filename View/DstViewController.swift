import UIKit

class DstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    @IBOutlet weak var dstTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var csvAry: [String] = []
    var dstName: [String] = []
    var selectedDataAry: [String] = []
    var selectedDataString: String = ""
    var selectedCellData: [String] = []
    var results: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.backButtonDisplayMode = .minimal
        
        searchBar.delegate = self
        
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
        
   
        for row in csvAry {
            let object = row.components(separatedBy: ",")
            dstName.append(object[0])
        }
        results = dstName.sorted()
        
    }
    

    // 検索バーに書き込みがあった時に呼び出される
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText != "" {
            results = dstName.filter { object in
                return object.contains(searchText)
            } as Array
        } else {
            results = dstName.sorted()
        }
        dstTableView.reloadData()
    }
    
    // 検索を押した時にキーボードを閉じる
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
    // 選択されたセルのデータを入れる
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        // resultsには目的地名しか入ってないので、csvAryにフィルターをかけて一列分のデータを変数selectedDataAryに入れる
        selectedDataAry = csvAry.filter { row in
            return row.contains(results[indexPath.row])
        }
        
        // 配列だとseparatedByが使えないので文字列に変換する
//        print(selectedDataAry)
        selectedDataString = selectedDataAry.joined()
//        print(selectedDataString)
        selectedCellData = selectedDataString.components(separatedBy: ",")
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
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dstCell", for: indexPath)
        cell.textLabel!.text = results[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}
