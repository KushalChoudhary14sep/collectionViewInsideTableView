//
//  TableViewCell2DataSource.swift
//  collectionViewInsideTableView
//
//  Created by Kushal Choudhary on 23/04/21.
//

import Foundation
import UIKit

class TableViewCell2DataSource: NSObject, UITableViewDataSource {
    
    
     var tableCell2Data: [cellData] = []
     
     override init() {
         super.init()
         loadData()
     }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableCell2Data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell2", for: indexPath) as? TableViewCell2 else {
            return UITableViewCell()
        }
       cell.setData(cellDetails: self.tableCell2Data[indexPath.row])
        return cell
    }
    
    func loadData(){
        if let data = cellData(topLabel: "Trending"){
            tableCell2Data.append(data)
        }
        if let data = cellData(topLabel: "Trending"){
            tableCell2Data.append(data)
        }
        if let data = cellData(topLabel: "Trending"){
            tableCell2Data.append(data)
        }
    }
    

}
