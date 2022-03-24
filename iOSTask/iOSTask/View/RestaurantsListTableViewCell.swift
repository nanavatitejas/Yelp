//
//  RestaurantsListTableViewCell.swift
//  iOSTask
//
//  Created by nineleaps on 23/03/22.
//

import UIKit

class RestaurantsListTableViewCell: UITableViewCell {

    lazy var lblName: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Name"
        lbl.font = lbl.font.withSize(13)
        lbl.textColor = .black
        lbl.numberOfLines = 0
        lbl.minimumScaleFactor = 7.0
        return lbl

    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
           super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.isUserInteractionEnabled = true
        setUpUI()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    //MARK: - Setup UI
    private func setUpUI() {
        self.addSubview(lblName)

        self.lblName.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8.0).isActive = true
        self.lblName.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 8.0).isActive = true
        self.lblName.topAnchor.constraint(equalTo: self.topAnchor, constant: 8.0).isActive = true
        self.lblName.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 8.0).isActive = true
    }

   

}
