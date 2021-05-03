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
        homeVM.loadHomeRails()
        tableView.register(UINib(nibName: "TableViewCell1TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell1TableViewCell")
        tableView.register(UINib(nibName: "TableViewCell2", bundle: nil), forCellReuseIdentifier: "TableViewCell2")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
    }
    
    func fetchHomeData(){
        let indexPaths = self.tableView.indexPathsForVisibleRows ?? [IndexPath]()
        for index in indexPaths {
            fetchIndexData(visibleIndex: index)
        }
    }
    func fetchIndexData(visibleIndex : IndexPath){
        let rail = homeRails.rails[visibleIndex.row]
        switch rail.railType {
        case .PROMOTION:
            DispatchQueue.main.async {
                if let cell = self.tableView.cellForRow(at: visibleIndex) as? TableViewCell1TableViewCell {
                    HomeRestManager.shared.getPromotion(promoName: rail.promoName ?? "") { (response) in
                        switch response {
                        case .success(let response):
                            cell.setData(promoData: response)
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    }
                }
            }
        case .COLLECTION:
            DispatchQueue.main.async {
                if let cell = self.tableView.cellForRow(at: visibleIndex) as?  TableViewCell2{
                    HomeRestManager.shared.getCollection(page: 0, psize: 20, collectionName: rail.collectionName ?? "") { (response) in
                        switch response {
                        case .success(let response):
                            var collectionData = [collectionCellData]()
                            for item in response.items {
                                collectionData.append(collectionCellData(cellImg: item.coverURI, cellLbl: item.title))
                            }
                            let data = cellData(topLabel: response.title ?? "", collectionData: collectionData)
                            cell.setData(cellDetails: data)
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    }
                }
            }
        case .INPROGRESS:
            DispatchQueue.main.async {
                if let cell = self.tableView.cellForRow(at: visibleIndex) as?  TableViewCell2{
                    HomeRestManager.shared.getContinueReading(page: 10, psize: 10, handler: { (response) in
                        switch response {
                        case .success(let response):
                            var collectionData = [collectionCellData]()
                            for item in response.items! {
                                collectionData.append(collectionCellData(cellImg: item.summary.coverURI, cellLbl: item.summary.title))
                            }
                            let data = cellData(topLabel: "Continue Reading...", collectionData: collectionData)
                            cell.setData(cellDetails: data)
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    })
                }
            }
        case .RECOMMENDATION:
            DispatchQueue.main.async {
                if let cell = self.tableView.cellForRow(at: visibleIndex) as?  TableViewCell2{
                    HomeRestManager.shared.getRecommneded(page: 10, psize: 10, handler: { (response) in
                        switch response {
                        case .success(let response):
                            var collectionData = [collectionCellData]()
                            for item in response.items! {
                                collectionData.append(collectionCellData(cellImg: item.coverURI, cellLbl: item.title))
                            }
                            let data = cellData(topLabel: response.title ?? "", collectionData: collectionData)
                            cell.setData(cellDetails: data)
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    })
                }
            }
        }
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
            return cell
        }else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell2", for: indexPath) as? TableViewCell2 else {
                return UITableViewCell()
            }
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
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let lastVisibleIndexPath = tableView.indexPathsForVisibleRows?.last {
            if indexPath == lastVisibleIndexPath {
                self.fetchHomeData()
            }
        }
    }
    
}

