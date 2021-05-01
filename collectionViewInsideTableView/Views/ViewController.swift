//
//  ViewController.swift
//  collectionViewInsideTableView
//
//  Created by Kushal Choudhary on 23/04/21.
//

import UIKit

protocol HomeViewControllerVCView: class {
    var tableView: UITableView! { get }
    var homeRails: Rails { set get }
}

class ViewController: UIViewController, HomeViewControllerVCView {
    @IBOutlet weak var tableView: UITableView!
    
    var homeVC : HomeUIVC!
    var homeVM : HomeVM!
    var homeRails = Rails(rails: [Rail]())
    override func viewDidLoad() {
        super.viewDidLoad()
        homeVC = HomeUIVC()
        homeVC.view = self
        homeVM = HomeVM()
        homeVM.view = self
        tableView.register(UINib(nibName: "TableViewCell1TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell1TableViewCell")
        tableView.register(UINib(nibName: "TableViewCell2", bundle: nil), forCellReuseIdentifier: "TableViewCell2")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeRails.rails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if homeRails.rails[indexPath.row].railType == RailType.PROMOTION {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell1TableViewCell", for: indexPath) as? TableViewCell1TableViewCell else {
                return UITableViewCell()
            }
            let data = homeRails.rails[indexPath.row]
            
            return cell
        }else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell2", for: indexPath) as? TableViewCell2 else {
                return UITableViewCell()
            }
            cell.setData(cellDetails: cellData(topLabel: "Home"))
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if homeRails.rails[indexPath.row].railType == RailType.PROMOTION {
            return 155
        }
        else {
            return 265
        }
    }
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        

    }
    
}


