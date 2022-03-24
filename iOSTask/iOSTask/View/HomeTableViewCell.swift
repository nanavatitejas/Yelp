//
//  HomeTableViewCell.swift
//  iOSTask
//
//  Created by nineleaps on 22/03/22.
//

import UIKit


protocol CollectionViewCellDelegate: class {
    func collectionView(collectionviewcell: HomeCollectionViewCell?, index: Int, didTappedInTableViewCell: HomeTableViewCell, term : String?)
}


class HomeTableViewCell: UITableViewCell {

    
    weak var cellDelegate: CollectionViewCellDelegate?

    lazy var flowLayout:UICollectionViewFlowLayout = {

            let f = UICollectionViewFlowLayout()
            f.scrollDirection = .horizontal
            f.itemSize = CGSize(width: 73, height: 73)
            f.minimumInteritemSpacing = CGFloat.greatestFiniteMagnitude
            f.minimumLineSpacing = 5
            return f
        }()
    
    lazy var collection: UICollectionView = {

        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: self.flowLayout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.showsVerticalScrollIndicator = false
        cv.showsHorizontalScrollIndicator = false
        cv.dataSource = self
        cv.delegate = self
        cv.isUserInteractionEnabled = true
        cv.isMultipleTouchEnabled = true
        cv.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: "homeCell")
        cv.backgroundColor = .white
        return cv
    }()
    
    lazy var numberOfRows : Int = {
        let numRows = 0
        return numRows
    }()
    
    var bussiness = [Business]()
    
    lazy var arrayCatergories : [String] = {
        let catArray = ["Food", "Restaurants"]
        return catArray
    }()
    

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
           super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.isUserInteractionEnabled = true
            setUpCollectionView()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - setUpUI

    private func setUpCollectionView() {
        self.addSubview(collection)

        self.collection.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0.0).isActive = true
        self.collection.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 8.0).isActive = true
        self.collection.topAnchor.constraint(equalTo: self.topAnchor, constant: 8.0).isActive = true
        self.collection.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 8.0).isActive = true
        collection.reloadData()
    }


}

//MARK: - CollectionView Delegate & DataSource


extension HomeTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfRows
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let homeCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "homeCell", for: indexPath) as! HomeCollectionViewCell
        if numberOfRows == 2 {
            homeCollectionCell.lblCategory.text = self.arrayCatergories[indexPath.row]
        } else {
            
            homeCollectionCell.lblCategory.text = bussiness[indexPath.row].name
            if indexPath.row == 3 {
                homeCollectionCell.lblCategory.text = "View All"
            }
        }
        
        return homeCollectionCell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? HomeCollectionViewCell
        var searchterm = ""
        if numberOfRows == 2 {
            searchterm = self.arrayCatergories[indexPath.row]
        } else {
            searchterm = ""
        }
        print("I'm tapping the \(indexPath.row)")
        
        self.cellDelegate?.collectionView(collectionviewcell: cell, index: indexPath.item, didTappedInTableViewCell: self, term: searchterm)
    }
    
    
    
}
