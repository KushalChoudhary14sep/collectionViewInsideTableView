//
//  CollectionviewCell.swift
//  collectionViewInsideTableView
//
//  Created by Kushal Choudhary on 23/04/21.
//

import UIKit

struct collectionCellData {
    let collectionCellImageUrl : String
    let collectionCellLabel: String
    
    init(cellImg: String, cellLbl: String) {
        collectionCellImageUrl = cellImg
        collectionCellLabel = cellLbl
    }
    
}
class CollectionviewCell: UICollectionViewCell {
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingImg1: UIImageView!
    @IBOutlet weak var ratingImg2: UIImageView!
    @IBOutlet weak var ratingImg3: UIImageView!
    @IBOutlet weak var ratingImg4: UIImageView!
    @IBOutlet weak var ratingImg5: UIImageView!
    
    var dataSource : collectionCellData?
    override func awakeFromNib() {
        super.awakeFromNib()
        mainImage.layer.cornerRadius = 8
    }
    
    func setData(cellData: collectionCellData?) {
        if let data = cellData {
            self.dataSource = cellData
            self.mainImage.imageFromUrl(urlString: "http://snippet-alb-testing-422974023.us-east-2.elb.amazonaws.com" + data.collectionCellImageUrl, handler: nil)
            self.titleLabel.text = data.collectionCellLabel
        }
    }

}
