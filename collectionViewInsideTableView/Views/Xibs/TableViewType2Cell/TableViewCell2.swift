//
//  TableViewCell2.swift
//  collectionViewInsideTableView
//
//  Created by Kushal Choudhary on 23/04/21.
//

import UIKit


struct cellData {
    let headerLbl: String
    
    init(topLabel: String){
        headerLbl = topLabel
    }
}


class TableViewCell2: UITableViewCell {

    @IBOutlet weak var cell2ContentView: UIView!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var moreButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.register(UINib(nibName: "CollectionviewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionviewCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.reloadData()
        setUI()
    }

    func setData(cellDetails: cellData) {
        self.headerLabel.text = cellDetails.headerLbl
    }
    
    func setUI() {
        moreButton.layer.cornerRadius = 12
        moreButton.setTitle("more", for: .normal)
        moreButton.setTitleColor(UIColor.black, for: .normal)
        moreButton.backgroundColor = UIColor.systemGray6
    }
}

extension TableViewCell2: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionviewCell", for: indexPath) as? CollectionviewCell else {
                   return UICollectionViewCell()
               }
      //  cell.setData(cellData: collectionCellData(cellImg: UIImage(named: "componentsBannerThumb")!, cellLbl: "Boy Erased"))
               return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.frame.size.width/3 + 20, height: self.collectionView.frame.size.height)
    }
    
}
