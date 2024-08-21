//
//  Home.swift
//  Hard75
//
//  Created by Renoy Chowdhury on 19/08/24.
//

import Foundation
import UIKit

class Home: UIViewController {
    var titleArea = UIView()
    var titleLabel = UILabel()
    var collection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.view.backgroundColor = .white
        
        titleLabel.text = "iOS"
        titleLabel.textAlignment = .left
        titleLabel.font = .systemFont(ofSize: 30, weight: .bold)
        titleLabel.textColor = .white
        
        titleArea.subviews(titleLabel)
        
        titleArea.layout(
        80,
        |-30-titleLabel-30-|,
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
    
}

extension Home: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        QuestionManager.shared.requestCategories().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCell.reuseIdentifier, for: indexPath) as? HomeCell {
            cell.configure(with: QuestionManager.shared.requestCategories()[indexPath.row])
            return cell
        }
        
        return UICollectionViewCell()
    }
}

extension Home: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let navigationController = self.navigationController {
            let x = Questions()
            x.configure(with: QuestionManager.shared.requestCategories()[indexPath.row])
            navigationController.pushViewController(x, animated: true)
        }
    }
}

extension Home: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width, height: 90)
    }
}
