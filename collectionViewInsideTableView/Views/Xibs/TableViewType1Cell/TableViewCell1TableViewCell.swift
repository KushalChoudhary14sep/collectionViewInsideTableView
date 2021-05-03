//
//  TableViewCell1TableViewCell.swift
//  collectionViewInsideTableView
//
//  Created by Kushal Choudhary on 23/04/21.
//

import UIKit
import SkeletonView


class TableViewCell1TableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellContentview: UIView!
    @IBOutlet weak var cellImg: UIImageView!
    
    var promoData : Promotion?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUI()
        cellImg.isSkeletonable = true
        cellImg.showSkeleton(usingColor: .lightGray)
    }
   
    func setData(promoData: Promotion) {
        cellImg.hideSkeleton()
        DispatchQueue.main.async {
            self.promoData = promoData
            self.cellImg.imageFromUrl(urlString: promoData.coverURI!, handler: nil)
        }
    }
    
    func setUI(){
        cellImg.layer.cornerRadius = 16
    }

   
    
}
