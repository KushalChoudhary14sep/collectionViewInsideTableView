//
//  VM.swift
//  collectionViewInsideTableView
//
//  Created by Kushal Choudhary on 23/04/21.
//

import Foundation
import UIKit

class HomeVM: NSObject {
    
    weak var view: HomeViewControllerVCView! {
        didSet{
            loadHomeRails()
        }
    }
    func loadHomeRails(){
        HomeRestManager.shared.getHomeRails { (response) in
            switch response {
            case .success(let response):
                self.view.homeRails = response
                self.view.tableView.reloadData()
            case .failure(_):
                break
            }
        }
    }
}
