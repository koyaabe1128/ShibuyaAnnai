import UIKit

class AccessibleDstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var accessibleDstTableView: UITableView!
    
    var csvAry: [String] = []
    var received: [String] = []
    var accessibleDstAry: [String] = []
    var selectedCellData: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.backButtonDisplayMode = .minimal
        
        // CSVファイルがない時にコンソールに出力
        guard let csvBundle = Bundle.main.path(forResource:"Dst", ofType:"csv") else {
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
            if object[0] == received[0] {
                accessibleDstAry.append(object[1])
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        selectedCellData = accessibleDstAry[indexPath.row].components(separatedBy: ",")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDstDetailSegue" {
            let dstDetailVC = segue.destination as! DstDetailViewController
            dstDetailVC.received = selectedCellData
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accessibleDstAry.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "accessibleDstCell", for: indexPath)
        cell.textLabel!.text = accessibleDstAry[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}
