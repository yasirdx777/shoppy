//
//  File.swift
//  shoppy
//
//  Created by YasirRomaya on 8/28/21.
//

import Foundation
import UIKit

class TableViewHeaderView: UIView {
    
    var headerTitle : String? {
        didSet {
            createView()
        }
    }
    
    private lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.textColor = Style.sharedInstance.getFontColor()
        label.font = Style.sharedInstance.getHeadlineFont()
        return label
    }()
    
    private lazy var moreButton : UIButton = {
        let button = UIButton()
        
        button.setTitleColor( Style.sharedInstance.getFontColor() , for: .normal)
        button.setTitle("More", for: .normal)

        return button
    }()
    
    private lazy var headerStackView : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .equalCentering
        stackView.spacing = 8
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createView(){
        headerStackView.addArrangedSubview(headerLabel)
        headerStackView.addArrangedSubview(moreButton)
        
        self.addSubview(headerStackView)
        
        headerStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(12)
            make.top.bottom.equalToSuperview()
        }
        
        headerLabel.text = headerTitle
    }

}
