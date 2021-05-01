//
//  TableViewCell1TableViewCell.swift
//  collectionViewInsideTableView
//
//  Created by Kushal Choudhary on 23/04/21.
//

import UIKit


class TableViewCell1TableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellContentview: UIView!
    @IBOutlet weak var cellImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUI()
    }
    
    func setData(data: Rail){
        
    }
    
    func setUI(){
        cellImg.layer.cornerRadius = 16
    }

   
    
}
