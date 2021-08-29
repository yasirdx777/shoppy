//
//  TableViewCell.swift
//  shoppy
//
//  Created by YasirRomaya on 8/27/21.
//

import UIKit
import ImageSlideshow
import Kingfisher

class SliderTableViewCell: UITableViewCell {
    static let cellIdentifier = "SliderTableViewCell"
    
    var sectionItemDataModels : [SectionItemDataModel]? {
        didSet {
            setViewData()
        }
    }
    
    
    private lazy var slideshow: ImageSlideshow = {
        let slideshow = ImageSlideshow()
        
        slideshow.subviews[0].layer.cornerRadius = Style.sharedInstance.getCornerRadius()
        slideshow.subviews[0].layer.masksToBounds = true
 
        slideshow.slideshowInterval = 5.0
        slideshow.pageIndicatorPosition = .init(horizontal: .center, vertical: .under)
        slideshow.contentScaleMode = UIViewContentMode.scaleAspectFill
        
        let pageIndicator = UIPageControl()
        pageIndicator.currentPageIndicatorTintColor = Style.sharedInstance.getAccentColor()
        pageIndicator.pageIndicatorTintColor = UIColor.lightGray
        slideshow.pageIndicator = pageIndicator
        
        return slideshow
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
        
        self.contentView.addSubview(slideshow)
        
        slideshow.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(12)
            make.bottom.equalToSuperview()
        }
    }
    
    private func setViewData() {
        var kingfisherSource = [KingfisherSource]()
        
        sectionItemDataModels!.forEach { item in
            kingfisherSource.append(KingfisherSource(urlString: item.picture ?? "", placeholder: UIImage(named: "PlaceHolder")!, options: [
                .processor(DownsamplingImageProcessor(size: self.contentView.frame.size)),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])!)
        }
        
        slideshow.setImageInputs(kingfisherSource)
    }
    
    
}
