//
//  TableViewCell2.swift
//  collectionViewInsideTableView
//
//  Created by Kushal Choudhary on 23/04/21.
//

import UIKit


struct cellData {
    let headerLbl: String
    let collectionData : [collectionCellData]?
    init(topLabel: String, collectionData : [collectionCellData]){
        self.headerLbl = topLabel
        self.collectionData = collectionData
    }
}


class TableViewCell2: UITableViewCell {

    @IBOutlet weak var cell2ContentView: UIView!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var moreButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var dataSource : cellData?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.register(UINib(nibName: "CollectionviewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionviewCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.reloadData()
        setUI()
    }

    func setData(cellDetails: cellData?) {
        if let data = cellDetails {
            self.dataSource = data
            self.headerLabel.text = data.headerLbl
            self.collectionView.reloadData()
        }
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
        return dataSource?.collectionData?.count ?? 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionviewCell", for: indexPath) as? CollectionviewCell else {
                   return UICollectionViewCell()
        }
        if let data = self.dataSource?.collectionData?[indexPath.row] {
            cell.setData(cellData: data)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.frame.size.width/3 + 20, height: self.collectionView.frame.size.height)
    }
    
}
