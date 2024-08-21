//
//  Main.swift
//  Hard75
//
//  Created by Renoy Chowdhury on 21/08/24.
//

import Foundation
import UIKit

class StateButtons: UIView {
    var leftButton = UIView()
    var leftText = UILabel()
    var leftAction: (()->())? = nil
    
    var rightButton = UIView()
    var rightText = UILabel()
    var rightAction: (()->())? = nil
    
    
    convenience init(left: String, right: String) {
        self.init()
        
        leftText.text = left
        rightText.text = right
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        leftText.text = ""
        leftText.font = .systemFont(ofSize: 16,
                                    weight: .bold)
        leftText.textColor = .white
        
        rightText.text = ""
        rightText.font = .systemFont(ofSize: 16,
                                     weight: .bold)
        rightText.textColor = .white
        rightText.textAlignment = .right
        
        let tapLeft = UITapGestureRecognizer(target: self, action: #selector(leftTapped))
        leftButton.addGestureRecognizer(tapLeft)
        
        let tapRight = UITapGestureRecognizer(target: self, action: #selector(rightTapped))
        rightButton.addGestureRecognizer(tapRight)
        
        leftButton.subviews(leftText)
        rightButton.subviews(rightText)
        subviews(leftButton, rightButton)
        
        leftButton.layout(
        16,
        |-16-leftText-16-|,
        16
        )
        
        rightButton.layout(
        16,
        |-16-rightText-16-|,
        16
        )
        
        layout(
        0,
        |-0-leftButton-2-rightButton-0-|,
        0
        )
        
        leftButton.style { v in
            v.backgroundColor =  UIColor(hexString: "1861F1")
            v.layer.cornerRadius = 20
            v.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        }
        
        rightButton.style { v in
            v.backgroundColor =  UIColor(hexString: "1861F1")
            v.layer.cornerRadius = 20
            v.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        }
        
        
        UIView.animate(withDuration: 0.2) {
            self.isSelected(true, view: self.leftButton)
            self.isSelected(false, view: self.rightButton)
        }
        
        equal(widths: leftButton, rightButton)
    }
    
    func isSelected(_ val: Bool, view: UIView) {
        if val {
            view.backgroundColor = UIColor(hexString: "1861F1")
            view.layer.borderWidth = 0
        } else {
            view.backgroundColor = .orange.withAlphaComponent(0.4)
            view.layer.borderWidth = 4
            view.layer.borderColor = UIColor.white.cgColor
        }
    }
    
    @objc
    func leftTapped() {
        UIView.animate(withDuration: 0.2) {
            self.isSelected(true, view: self.leftButton)
            self.isSelected(false, view: self.rightButton)
        }
        
        leftAction?()
    }
    
    @objc
    func rightTapped() {
        UIView.animate(withDuration: 0.2) {
            self.isSelected(false, view: self.leftButton)
            self.isSelected(true, view: self.rightButton)
        }
        rightAction?()
    }
    
    required init?(coder: NSCoder) {
        fatalError("FATAL ERROR")
    }
}

class ListCard: UIView {
    var title = UILabel()
    var cardHolder = UIView()
    
    convenience init(title: String) {
        self.init()
        self.title.text = title
    }
    
    
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
            ch.layer.cornerRadius = 16
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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class Main: UIViewController {
    
    var titleLabel = UILabel()
    
    var totalCards = DashboardCard(title: "Total Cards",
                                   count: "\(QuestionManager.shared.interViewItems.count)",
                                   color: .systemPink)
    
    var totalDecks = DashboardCard(title: "Decks",
                                   count: "1",
                                   color: .orange)
    var listElement = ListCard(title: "iOS")
    
    var decks = UILabel() // to collection in future
    
    var buttons = StateButtons(left: "Study mode".uppercased(), right: "Exercise mode".uppercased())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        self.view.backgroundColor = .white
        
        titleLabel.text = "dashboard".uppercased()
        titleLabel.font = .systemFont(ofSize: 30, weight: .bold)
        titleLabel.textColor = .black
        
        decks.text = "Decks".uppercased()
        decks.font = .systemFont(ofSize: 16,
                                 weight: .bold)
        decks.textColor = .black
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(openDeck))
        listElement.addGestureRecognizer(tap)
        
        view.subviews(titleLabel, totalCards, totalDecks, decks, listElement, buttons)
        
        view.layout(
        80,
        |-16-titleLabel,
        16,
        |-16-totalCards-8-totalDecks-16-| ~ 120,
        20,
        |-16-decks-16-|, 
        16,
        |-0-listElement-0-| ~ 220,
        "",
        |-16-buttons-16-|,
        40
        )
        
        equal(widths: totalCards, totalDecks)
    }
    
    @objc
    func openDeck() {
        navigationController?.pushViewController(Home(), animated: true)
    }
}
