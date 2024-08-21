//
//  HomeCell.swift
//  Hard75
//
//  Created by Renoy Chowdhury on 19/08/24.
//

import Foundation
import UIKit

class HomeCell: UICollectionViewCell {
    static let reuseIdentifier = "HomeCell"
    
    var title = UILabel()
    var cardHolder = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        cardHolder.subviews(title)
        
        cardHolder.layout(
            8,
            |-16-title-16-|,
            8
        )
        
        title.style { t in
            t.font = .systemFont(ofSize: 16, weight: .semibold)
            t.textColor = .black
        }
        
        cardHolder.style { ch in
            ch.backgroundColor = .white
            ch.layer.cornerRadius = 30
            ch.layer.shadowColor = UIColor.blue.cgColor
            ch.layer.shadowOpacity = 0.1
            ch.layer.shadowOffset = CGSizeMake(0, 1)
            ch.layer.shadowRadius = 6
        }
        
        subviews(cardHolder)
        layout(
        8,
        |-16-cardHolder-16-| ~ 90,
        8
        )
        
    }
    
    func configure(with item: Categories?) {
        if let itemTitle = item {
            
            title.text = itemTitle.rawValue
        }
        
    }
    
    func configure(with item: String?) {
        if let itemTitle = item {
            title.text = itemTitle
        }
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("FATAL ERROR")
    }
    
}

extension UIView {
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = .zero
        layer.shadowRadius = 1
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}
