//
//  NewPlaceTableViewCell.swift
//  MyFavoritePlaces
//
//  Created by mac on 5/30/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class NewPlaceTableViewCell: UITableViewCell {
    
    let placeTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    let placeTextField: UITextField = {
        let textField = UITextField()
        textField.font = .systemFont(ofSize: 15)
        textField.textColor = .darkGray
        textField.borderStyle = .none
        textField.returnKeyType = .done
        return textField
    }()
    
    lazy var stackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [placeTitleLabel, placeTextField])
        sv.axis = .vertical
        sv.distribution = .fillEqually
        return sv
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(stackView)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        stackView.setAnchor(top: topAnchor, left: leftAnchor, right: rightAnchor, bottom: bottomAnchor, paddingTop: 0, paddingLeft: 15, paddingRight: -15, paddingBottom: 0)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
