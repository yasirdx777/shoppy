//
//  StoreCollectionViewCell.swift
//  shoppy
//
//  Created by YasirRomaya on 8/27/21.
//

import UIKit
import MarqueeLabel
import Kingfisher

class StoreCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = "StoreCollectionViewCell"
    
    var sectionItemDataModel : SectionItemDataModel? {
        didSet {
            setViewData()
        }
    }
    
    private lazy var storeImage: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private lazy var storeLabel: MarqueeLabel = {
        let label = MarqueeLabel()
        label.textColor = Style.sharedInstance.getFontColor()
        label.font = Style.sharedInstance.getTitleFont()
        return label
    }()
    
    
    private lazy var storeStackView : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 8
        return stackView
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
        
        
        storeStackView.addArrangedSubview(storeImage)
        storeStackView.addArrangedSubview(storeLabel)
        
        self.addSubview(storeStackView)
        
        let storeImageSize = self.frame.height / 1.3
        
        storeImage.snp.makeConstraints { make in
            make.height.width.equalTo(storeImageSize)
        }
        
        storeStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
      
        storeImage.layer.cornerRadius = storeImageSize / 2
    }
    
    private func setViewData() {
        
        storeImage.kf.setImage(with: URL(string: sectionItemDataModel?.picture ?? ""), placeholder: UIImage(named: "PlaceHolder")! ,options: [
            .processor(DownsamplingImageProcessor(size: self.contentView.frame.size)),
            .scaleFactor(UIScreen.main.scale),
            .transition(.fade(1)),
            .cacheOriginalImage,
        ])
        
        storeLabel.text = sectionItemDataModel?.name ?? ""
        
    }
    
}
