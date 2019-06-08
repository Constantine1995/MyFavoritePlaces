//
//  RatingControl.swift
//  MyFavoritePlaces
//
//  Created by mac on 6/7/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

@IBDesignable class RatingControl: UIStackView {
    
    var delegate: RatingProtocol?

    // MARK: - Preperties
    var rating = 0 {
        didSet {
            updateButtonSelectionState()
        }
    }
    private var ratingButtons = [UIButton]()
    @IBInspectable var startSize: CGSize = CGSize(width: 44.0, height: 44.0) {
        didSet {
            setupView()
        }
    }
    @IBInspectable var startCount: Int = 5 {
        didSet {
            setupView()
        }
    }
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    // MARK: - Button Action
    @objc func ratingButtonAction(button: UIButton) {
        guard let index = ratingButtons.firstIndex(of: button) else { return }
        let selectedRating = index + 1
        
        if selectedRating == rating {
            rating = 0
        } else {
            rating = selectedRating
        }
        delegate?.currentRating = rating
    }
    
    // MARK: - Private Methods
    private func setupView() {
        for button in ratingButtons {
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        
        ratingButtons.removeAll()
        
        let bundle = Bundle(for: type(of: self))
        let emptyStar = UIImage(named: "emptyStar", in: bundle, compatibleWith: self.traitCollection)
        let filledStar = UIImage(named: "filledStar", in: bundle, compatibleWith: self.traitCollection)
        let highlithedStar = UIImage(named: "highlithedStar", in: bundle, compatibleWith: self.traitCollection)
        
        for _ in 0..<startCount {
            let button = UIButton()
            button.setImage(emptyStar, for: .normal)
            button.setImage(filledStar, for: .selected)
            button.setImage(highlithedStar, for: .highlighted)
            button.setImage(highlithedStar, for: [.highlighted, .selected])
            
            button.setSize(width: startSize.width, height: startSize.height)
            button.addTarget(self, action: #selector(ratingButtonAction), for: .touchUpInside)
            addArrangedSubview(button)
            ratingButtons.append(button)
        }
        updateButtonSelectionState()
    }
    
    private func updateButtonSelectionState() {
        for (index, button) in ratingButtons.enumerated() {
            button.isSelected = index < rating
        }
    }
}
