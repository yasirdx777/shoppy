//
//  ProductCollectionViewCell.swift
//  shoppy
//
//  Created by YasirRomaya on 8/27/21.
//

import UIKit
import MarqueeLabel
import Kingfisher

class ProductCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = "ProductCollectionViewCell"
    
    var sectionItemDataModel : SectionItemDataModel? {
        didSet {
            setViewData()
        }
    }
    
    private lazy var productImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = Style.sharedInstance.getCornerRadius()
        image.layer.masksToBounds = true
        return image
    }()
    
    
    private lazy var productLabel: MarqueeLabel = {
        let label = MarqueeLabel()
        label.textColor = Style.sharedInstance.getFontColor()
        label.font = Style.sharedInstance.getTitleFont()
        return label
    }()
    
    private lazy var productPriceLabel: MarqueeLabel = {
        let label = MarqueeLabel()
        label.textColor = Style.sharedInstance.getAccentColor()
        label.font = Style.sharedInstance.getTitleFont()
        return label
    }()
    
    private lazy var productStackView : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
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
        
        
        productStackView.addArrangedSubview(productImage)
        productStackView.addArrangedSubview(productLabel)
        productStackView.addArrangedSubview(productPriceLabel)
        
        self.contentView.addSubview(productStackView)
        
        productStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        
        productLabel.snp.makeConstraints { make in
            make.height.equalTo(20)
        }
        
        productPriceLabel.snp.makeConstraints { make in
            make.height.equalTo(20)
        }
        
    }
    
    private func setViewData() {
        
        productImage.kf.setImage(with: URL(string: sectionItemDataModel?.picture ?? ""), placeholder: UIImage(named: "PlaceHolder")! ,options: [
            .processor(DownsamplingImageProcessor(size: self.contentView.frame.size)),
            .scaleFactor(UIScreen.main.scale),
            .transition(.fade(1)),
            .cacheOriginalImage
        ])
        
        productLabel.text = sectionItemDataModel?.name ?? ""
        productPriceLabel.text = sectionItemDataModel?.price ?? ""
    }
}
