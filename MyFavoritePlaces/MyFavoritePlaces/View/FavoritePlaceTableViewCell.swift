//
//  FavoritePlaceTableViewCell.swift
//  MyFavoritePlaces
//
//  Created by mac on 5/29/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import Cosmos

class FavoritePlaceTableViewCell: UITableViewCell {
    
    class var identifier: String {
        return String(describing: self)
    }
    
    let placeCellView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.setShadow()
        return view
    }()
    
    let placeImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.imageViewCorners()
        image.clipsToBounds = true
        return image
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica", size: 18)
        label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        label.textAlignment = .left
        
        return label
    }()
    
    let locationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica", size: 15)
        label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        label.textAlignment = .left
        
        return label
    }()
    
    let typeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica", size: 15)
        label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        label.textAlignment = .left
        
        return label
    }()
    
    let descriptionContent: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica", size: 15)
        label.numberOfLines = 2
        label.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        label.textAlignment = .left
        return label
    }()
    
    let ratingCosmosView: CosmosView = {
        let view = CosmosView()
        view.settings.filledImage = #imageLiteral(resourceName: "filledStar")
        view.settings.emptyImage = #imageLiteral(resourceName: "emptyStar")
        view.settings.starSize = 15
        view.settings.updateOnTouch  = false
        return view
    }()
    
    lazy var stackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [nameLabel, locationLabel, typeLabel])
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        sv.spacing = 20
        sv.distribution = .fillEqually
        return sv
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    func setupView() {
        addSubview(placeCellView)
        addSubview(placeImageView)
        addSubview(stackView)
        addSubview(ratingCosmosView)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        
        placeCellView.setAnchor(top: topAnchor, left: leftAnchor, right: rightAnchor, bottom: bottomAnchor, paddingTop: 13, paddingLeft: 25, paddingRight: -25, paddingBottom: -13)
        
        placeImageView.setAnchor(top: placeCellView.topAnchor, left: placeCellView.leftAnchor, right: nil, bottom: placeCellView.bottomAnchor, paddingTop: 15, paddingLeft: 15, paddingRight: 0, paddingBottom: -15, width: 100, height: 100)
        
        placeImageView.setCenterYAnchor(self)
        
        stackView.setAnchor(top: placeCellView.topAnchor, left: placeImageView.rightAnchor, right: nil, bottom: placeCellView.bottomAnchor, paddingTop: 15, paddingLeft: 15, paddingRight: 0, paddingBottom: -15)
        
        ratingCosmosView.setAnchor(top: nil, left: nil, right: placeCellView.rightAnchor, bottom: nil, paddingTop: 0, paddingLeft: 0, paddingRight: -10, paddingBottom: 0)
        ratingCosmosView.setCenterYAnchor(self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
