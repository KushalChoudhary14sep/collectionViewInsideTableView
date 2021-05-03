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
        homeVC.setUI()
        homeVM = HomeVM()
        homeVM.view = self
        homeVM.loadHomeRails()
        
    }
    
    
}



