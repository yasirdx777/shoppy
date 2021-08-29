//
//  BestProductsTableViewCell.swift
//  shoppy
//
//  Created by YasirRomaya on 8/27/21.
//

import UIKit

class BestProductsTableViewCell: UITableViewCell {
    static let cellIdentifier = "BestProductsTableViewCell"
    
    var sectionItemDataModels : [SectionItemDataModel]? {
        didSet {
            collectionItems.reloadData()
        }
    }
    
    private lazy var collectionItems: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        layout.scrollDirection = .horizontal
        
        let collectionItems = UICollectionView(frame: self.frame, collectionViewLayout: layout)
        
        collectionItems.backgroundColor = .clear
        collectionItems.showsHorizontalScrollIndicator = false
        collectionItems.showsVerticalScrollIndicator = false
        
        collectionItems.register(BestProductCollectionViewCell.self, forCellWithReuseIdentifier: BestProductCollectionViewCell.cellIdentifier)
        
        collectionItems.delegate = self
        collectionItems.dataSource = self
        
        return collectionItems
    }()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        createView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func createView(){
        self.backgroundColor = .clear
        self.selectionStyle = .none
        
        self.contentView.addSubview(collectionItems)
        
        collectionItems.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().inset(12)
            make.trailing.top.bottom.equalToSuperview()
        }
    }
    
    
    
}

// MARK:- Collection delegates
extension BestProductsTableViewCell : UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sectionItemDataModels?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BestProductCollectionViewCell.cellIdentifier, for: indexPath) as! BestProductCollectionViewCell

        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        let item = sectionItemDataModels?[indexPath.row]
        let bestProductCollectionViewCell = cell as! BestProductCollectionViewCell
        
        bestProductCollectionViewCell.sectionItemDataModel = item
    }
    
}

// MARK:- Layout flow
extension BestProductsTableViewCell: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        
        return CGSize(width: collectionView.frame.width / 1.5 , height: collectionView.frame.height)
    }
    
}
