//
//  CollectionviewCell.swift
//  collectionViewInsideTableView
//
//  Created by Kushal Choudhary on 23/04/21.
//

import UIKit

struct collectionCellData {
    let collectionCellImage: UIImage
    let collectionCellLabel: String
    
    init(cellImg: UIImage, cellLbl: String) {
        collectionCellImage = cellImg
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        mainImage.layer.cornerRadius = 8
    }
    
    func setData(cellData: collectionCellData) {
        self.mainImage.image = cellData.collectionCellImage
        self.titleLabel.text = cellData.collectionCellLabel
        
    }

}
