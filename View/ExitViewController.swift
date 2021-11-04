import UIKit

class ExitViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var exitTableView: UITableView!
    
    var csvAry: [String] = []
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
 
    }

    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        selectedCellData = csvAry[indexPath.row].components(separatedBy: ",")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAccessibleDstSegue" {
            let accessibleDstVC = segue.destination as! AccessibleDstViewController
            accessibleDstVC.received = selectedCellData
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return csvAry.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "exitCell", for: indexPath)
        cell.textLabel!.text = csvAry[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}
