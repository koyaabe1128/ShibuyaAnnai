//
//  AccessibleDstViewController.swift
//  ShibuyaAnnai
//
//  Created by Koya on 2021/10/20.
//

import UIKit

var dstAry: [String] = []

class AccessibleDstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var received: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // CSVファイルがない時にコンソールに出力
        guard let csvBundle = Bundle.main.path(forResource:"Exit", ofType:"csv") else {
            print("csvファイルがありません。")
            return
        }
        
        do {
            let csvString = try String(contentsOfFile: csvBundle, encoding: String.Encoding.utf8)
            dstAry = csvString.components(separatedBy: .newlines)
            dstAry.removeLast()
        } catch {
            print("エラー")
        }
        
        print(received)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dstAry.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "accessibleDstCell", for: indexPath)
        let dstInfo = dstAry[indexPath.row].components(separatedBy: ",")
        cell.textLabel!.text = dstInfo[0]
        return cell
    }
    
}

//let cell = tableView.dequeueReusableCell(withIdentifier: "accessibleDstCell", for: indexPath)
//let dstInfo = dstAry[indexPath.row].components(separatedBy: ",")
//cell.textLabel!.text = dstInfo[0]
//return cell
