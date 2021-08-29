//
//  CategoryCollectionViewCell.swift
//  shoppy
//
//  Created by YasirRomaya on 8/27/21.
//

import UIKit
import Kingfisher

class CategoryCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = "CategoryCollectionViewCell"
    
    var sectionItemDataModel : SectionItemDataModel? {
        didSet {
            setViewData()
        }
    }
    
    private lazy var backgroundImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = Style.sharedInstance.getCornerRadius()
        image.layer.masksToBounds = true
        return image
    }()
    
    private lazy var backgroundImageContrastView : UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.clipsToBounds = true
        view.layer.cornerRadius = Style.sharedInstance.getCornerRadius()
        view.alpha = 0.5
        return view
    }()
    
    
    private lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 3
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowRadius = 2.0
        label.layer.shadowOpacity = 0.5
        label.layer.shadowOffset = CGSize(width: 2, height: 2)
        label.layer.masksToBounds = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func createView(){
        self.backgroundColor = .clear
        
        
        backgroundImage.addSubview(backgroundImageContrastView)
        backgroundImage.addSubview(categoryLabel)
        
        self.addSubview(backgroundImage)
        
        backgroundImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        backgroundImageContrastView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        categoryLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
     
        
    }
    
    private func setViewData() {
        
        backgroundImage.kf.setImage(with: URL(string: sectionItemDataModel?.picture ?? ""), placeholder: UIImage(named: "PlaceHolder")!, options: [
            .processor(DownsamplingImageProcessor(size: self.contentView.frame.size)),
            .scaleFactor(UIScreen.main.scale),
            .transition(.fade(1)),
            .cacheOriginalImage
        ])
        
        categoryLabel.text = sectionItemDataModel?.name ?? ""
    }
    
}
