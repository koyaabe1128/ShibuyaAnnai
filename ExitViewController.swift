//
//  ExitViewController.swift
//  ShibuyaAnnai
//
//  Created by Koya on 2021/10/20.
//

import UIKit

var exitAry: [String] = []
var selectedCellData: [String] = []

class ExitViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // CSVファイルがない時にコンソールに出力
        guard let csvBundle = Bundle.main.path(forResource:"Exit", ofType:"csv") else {
            print("csvファイルがありません。")
            return
        }
        
        do {
            let csvString = try String(contentsOfFile: csvBundle, encoding: String.Encoding.utf8)
            exitAry = csvString.components(separatedBy: .newlines)
            exitAry.removeLast()
        } catch {
            print("エラー")
        }
        
    }
    
    // 選択されたセルのデータを配列にして代入
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        selectedCellData = exitAry[indexPath.row].components(separatedBy: ",")
    }
    
    // セグエが"toAccessibleDstSegue"の時、AccessibleDstViewControllerの変数received に選択されたデータを代入
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAccessibleDstSegue" {
            let accessibleDstVC = segue.destination as! AccessibleDstViewController
            accessibleDstVC.received = selectedCellData
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exitAry.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "exitCell", for: indexPath)
        let exitInfo = exitAry[indexPath.row].components(separatedBy: ",")
        cell.textLabel!.text = exitInfo[1]
        return cell
    }
    
}
