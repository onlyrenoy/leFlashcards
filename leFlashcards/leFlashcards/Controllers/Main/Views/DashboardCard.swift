//
//  DashboardCard.swift
//  Hard75
//
//  Created by Renoy Chowdhury on 21/08/24.
//

import Foundation
import UIKit

class DashboardCard: UIView {
    var title = UILabel()
    var count = UILabel()
    
    convenience init(title: String, count: String, color: UIColor) {
        self.init()
        
        self.count.text = count
        self.count.textColor = color
        self.count.font = .systemFont(ofSize: 30, weight: .bold)
        
        self.title.text = title
        self.title.textColor = color
        self.title.font = .systemFont(ofSize: 16, weight: .medium)

        backgroundColor = color.withAlphaComponent(0.2)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        subviews(title, count)
        
        layout(
            20,
            |-12-count-12-|,
            8,
            |-12-title-12-|
        )
        
        style { a in
            a.layer.cornerRadius = 20
        }
        
    }
    required init?(coder: NSCoder) {
        fatalError("FATAL ERROR")
    }
    
}
