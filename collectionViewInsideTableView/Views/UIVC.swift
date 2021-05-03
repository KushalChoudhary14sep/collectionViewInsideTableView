//
//  UIVC.swift
//  collectionViewInsideTableView
//
//  Created by Kushal Choudhary on 23/04/21.
//

import Foundation
import UIKit

class HomeUIVC: NSObject {
    var view: HomeViewControllerVCView!
    func fetchHomeData(){
        let indexPaths = view.tableView.indexPathsForVisibleRows ?? [IndexPath]()
        for index in indexPaths {
            fetchIndexData(visibleIndex: index)
        }
    }
    
    
    func setUI(){
        view.tableView.register(UINib(nibName: "TableViewCell1TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell1TableViewCell")
        view.tableView.register(UINib(nibName: "TableViewCell2", bundle: nil), forCellReuseIdentifier: "TableViewCell2")
        view.tableView.delegate = self
        view.tableView.dataSource = self
        view.tableView.rowHeight = UITableView.automaticDimension
        view.tableView.estimatedRowHeight = UITableView.automaticDimension
        view.tableView.separatorStyle = .none
    }
    func fetchIndexData(visibleIndex : IndexPath){
        let rail = view.homeRails.rails[visibleIndex.row]
        switch rail.railType {
        case .PROMOTION:
            DispatchQueue.main.async {
                if let cell = self.view.tableView.cellForRow(at: visibleIndex) as? TableViewCell1TableViewCell {
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
                if let cell = self.view.tableView.cellForRow(at: visibleIndex) as?  TableViewCell2{
                    HomeRestManager.shared.getCollection(page: 0, psize: 20, collectionName: rail.collectionName ?? "") { (response) in
                        switch response {
                        case .success(let response):
                            var collectionData = [collectionCellData]()
                            for item in response.items {
                                collectionData.append(collectionCellData(cellImg: item.coverURI, cellLbl: item.title, rating: item.rating))
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
                if let cell = self.view.tableView.cellForRow(at: visibleIndex) as?  TableViewCell2{
                    HomeRestManager.shared.getContinueReading(page: 10, psize: 10, handler: { (response) in
                        switch response {
                        case .success(let response):
                            var collectionData = [collectionCellData]()
                            for item in response.items! {
                                collectionData.append(collectionCellData(cellImg: item.summary.coverURI, cellLbl: item.summary.title, rating: Double(item.summary.rating)))
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
                if let cell = self.view.tableView.cellForRow(at: visibleIndex) as?  TableViewCell2{
                    HomeRestManager.shared.getRecommneded(page: 10, psize: 10, handler: { (response) in
                        switch response {
                        case .success(let response):
                            var collectionData = [collectionCellData]()
                            for item in response.items! {
                                collectionData.append(collectionCellData(cellImg: item.coverURI, cellLbl: item.title, rating: item.rating))
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

extension HomeUIVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return view.homeRails.rails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if view.homeRails.rails[indexPath.row].railType == RailType.PROMOTION {
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
        if view.homeRails.rails[indexPath.row].railType == RailType.PROMOTION {
            return 155
        }
        else {
            return 308
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let lastVisibleIndexPath = tableView.indexPathsForVisibleRows?.last {
            if indexPath == lastVisibleIndexPath {
                self.fetchHomeData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
}
