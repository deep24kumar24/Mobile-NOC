//
//  FilterButton.swift
//  MobileNOC Test
//
//  Created by Deepak Kumar on 2018-12-03.
//  Copyright © 2018 deepak. All rights reserved.
//

import UIKit

class FilterButton: UIButton {
    
    
    //MARK: - Overiride Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUnselected()
        self.layer.cornerRadius = self.frame.height / 2
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 0.5
        self.setTitleColor(UIColor.lightGray, for: .normal)
        self.setTitleColor(UIColor.white, for: .selected)
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                setSelected()
            } else {
                setUnselected()
            }
        }
    }
    
    
    //MARK: - Private Methods
    
    private func setSelected() {
        self.backgroundColor = UIColor(red: 0, green: 160/256, blue: 1, alpha: 1.0)
    }
    
    private func setUnselected() {
        self.backgroundColor = UIColor.white
    }
}
