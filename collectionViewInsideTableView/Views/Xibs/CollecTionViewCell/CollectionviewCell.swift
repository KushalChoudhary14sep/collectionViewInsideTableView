//
//  CollectionviewCell.swift
//  collectionViewInsideTableView
//
//  Created by Kushal Choudhary on 23/04/21.
//

import UIKit
import Cosmos

struct collectionCellData {
    let collectionCellImageUrl : String
    let collectionCellLabel: String
    let rating: Double
    
    init(cellImg: String, cellLbl: String, rating: Double) {
        self.collectionCellImageUrl = cellImg
        self.collectionCellLabel = cellLbl
        self.rating = rating
    }
    
}
class CollectionviewCell: UICollectionViewCell {
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var rating: CosmosView!
    
    
    var dataSource : collectionCellData?
    override func awakeFromNib() {
        super.awakeFromNib()
        mainImage.layer.cornerRadius = 8
        mainImage.isSkeletonable = true
        mainImage.showSkeleton(usingColor: .lightGray)
        titleLabel.isSkeletonable = true
        titleLabel.showSkeleton(usingColor: .lightGray)
        rating.isSkeletonable = true
        rating.showSkeleton(usingColor: .lightGray)
        rating.settings.starSize = 15
        rating.settings.starMargin = 2
      

    }
    
    
    func setData(cellData: collectionCellData?) {
        mainImage.hideSkeleton()
        titleLabel.hideSkeleton()
        rating.hideSkeleton()
        if let data = cellData {
            self.dataSource = cellData
            self.mainImage.imageFromUrl(urlString: "http://snippet-alb-testing-422974023.us-east-2.elb.amazonaws.com" + data.collectionCellImageUrl, handler: nil)
            self.titleLabel.text = data.collectionCellLabel
            self.rating.rating = data.rating
        }
    }

}
