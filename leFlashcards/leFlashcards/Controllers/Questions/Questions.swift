//
//  Questions.swift
//  Hard75
//
//  Created by Renoy Chowdhury on 19/08/24.
//

import Foundation
import UIKit

class Questions: UIViewController {
    var titleArea = UIView()
    var titleLabel = UILabel()
    
    var collection: UICollectionView!
    var list: [Item] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        titleLabel.textAlignment = .left
        titleLabel.font = .systemFont(ofSize: 30, weight: .bold)
        titleLabel.textColor = .white
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.minimumScaleFactor = 0.5
        titleArea.subviews(titleLabel)
        
        titleArea.layout(
        80,
        |-16-titleLabel-16-|,
        0
        )
        
        titleArea.backgroundColor = UIColor(hexString: "1861F1")
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.scrollDirection = .vertical
        
        collection = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        
        collection.register(HomeCell.self, forCellWithReuseIdentifier: HomeCell.reuseIdentifier)
        
        collection.delegate = self
        collection.dataSource = self
        
        self.view.subviews(titleArea, collection)
        
        self.view.layout(
        0,
        |-0-titleArea-0-| ~ UIScreen.main.bounds.height * 0.22,
        16,
        |-0-collection-0-|,
        0
        )
    }
    
    func configure(with cat: Categories) {
        titleLabel.text = cat.rawValue.uppercased()
        self.list = QuestionManager.shared.list(cat)
    }
    
}

extension Questions: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCell.reuseIdentifier, for: indexPath) as? HomeCell {
            cell.configure(with: list[indexPath.row].Question)
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    
}

extension Questions: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = QuestoinAnswerDetail(item: list[indexPath.row])
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
}
extension Questions: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width, height: 90)
    }
}
