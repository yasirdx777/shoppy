//
//  BestProductCollectionViewCell.swift
//  shoppy
//
//  Created by YasirRomaya on 8/27/21.
//

import UIKit
import Kingfisher

class BestProductCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = "BestProductCollectionViewCell"
    
    var sectionItemDataModel : SectionItemDataModel? {
        didSet {
            setViewData()
        }
    }
    
    private lazy var bestProductBackgroundView : UIView = {
        let view = UIView()
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var bestProductImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.masksToBounds = true
        return image
    }()
    
    private lazy var bestProductDetailsView : UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    
    private lazy var bestProductDetailsStackView : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 8
        return stackView
    }()
    
    
    private lazy var bestProductLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 1
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowRadius = 2.0
        label.layer.shadowOpacity = 0.5
        label.layer.shadowOffset = CGSize(width: 2, height: 2)
        label.layer.masksToBounds = false
        return label
    }()
    
    
    private lazy var bestProductPriceLabel: UILabel = {
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
    
    
    private lazy var bestProductDetailsLabel: UILabel = {
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
    
    
    private lazy var bestProductView : UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.clipsToBounds = true
        view.layer.cornerRadius = Style.sharedInstance.getCornerRadius()
        return view
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
        
        self.bestProductView.addSubview(bestProductBackgroundView)
        self.bestProductView.addSubview(bestProductImage)
        self.bestProductView.addSubview(bestProductDetailsView)
        self.bestProductDetailsView.addSubview(bestProductDetailsStackView)
        
        self.bestProductDetailsStackView.addArrangedSubview(bestProductLabel)
        self.bestProductDetailsStackView.addArrangedSubview(bestProductPriceLabel)
        self.bestProductDetailsStackView.addArrangedSubview(bestProductDetailsLabel)
        
        self.addSubview(bestProductView)
        
        bestProductBackgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        bestProductView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        bestProductImage.snp.makeConstraints { make in
            make.trailing.top.bottom.equalToSuperview()
            make.width.equalTo(self.frame.width / 2.5)
        }
        
        bestProductDetailsView.snp.makeConstraints { make in
            make.leading.top.bottom.equalToSuperview()
            make.trailing.equalTo(bestProductImage.snp.leading)
        }
        
        bestProductDetailsStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8)
        }
        
    }
    
    
    private func setViewData() {
        
        KingfisherManager.shared.retrieveImage(with: URL(string: sectionItemDataModel?.picture ?? "")!, options: [
            .processor(DownsamplingImageProcessor(size: self.contentView.frame.size)),
            .scaleFactor(UIScreen.main.scale),
            .transition(.fade(1)),
            .cacheOriginalImage
        ], progressBlock: { [weak self] (receivedSize, totalSize)  in
            guard let self = self else { return }
            
            if(self.bestProductImage.image == nil){
                self.bestProductImage.addGradientFadingLayerEffect()
                self.bestProductImage.image = UIImage(named: "PlaceHolder")!
                self.bestProductBackgroundView.backgroundColor = .black
            }
            
        }, completionHandler: { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let value):
                let productImage = value.image
                let productImageColor = productImage.averageColor ?? Style.sharedInstance.getAccentColor()
                
                self.bestProductBackgroundView.backgroundColor = productImageColor
                
                self.bestProductImage.image = productImage
                
                self.bestProductImage.addGradientFadingLayerEffect()
                
            case .failure(let error):
                print(error)
            }
        })
        
        
        self.bestProductLabel.text = self.sectionItemDataModel?.name ?? ""
        self.bestProductPriceLabel.text = self.sectionItemDataModel?.price ?? ""
        self.bestProductDetailsLabel.text = self.sectionItemDataModel?.itemDescription ?? ""
        
    }
    
}
