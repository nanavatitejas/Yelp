//
//  HomeCollectionViewCell.swift
//  iOSTask
//
//  Created by nineleaps on 22/03/22.
//

import UIKit




class HomeCollectionViewCell: UICollectionViewCell {
    lazy var lblCategory: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Food"
        lbl.font = lbl.font.withSize(13)
        lbl.textAlignment = .left
        lbl.textColor = .black
        lbl.numberOfLines = 0
        lbl.minimumScaleFactor = 7.0
        return lbl

    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    //MARK: - setUpUI
    func setUpUI() {
        self.addSubview(lblCategory)

        self.lblCategory.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8.0).isActive = true
        self.lblCategory.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 8.0).isActive = true
        self.lblCategory.topAnchor.constraint(equalTo: self.topAnchor, constant: 8.0).isActive = true
        self.lblCategory.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 8.0).isActive = true
    }
}
