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
    
    var viewModel: QuestionsViewModel! // Added viewModel property
    var collection: UICollectionView!
    // var list: [Item] = [] // Removed list property
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
        // Reload data in case configure was called before collection view was ready
        // or if using a storyboard/xib where outlets might not be set when configure is called.
        if viewModel != nil { // Ensure viewModel is configured
            collection.reloadData()
        }
    }
    
    func configure(with cat: Categories) {
        viewModel = QuestionsViewModel()
        viewModel.configure(with: cat)
        titleLabel.text = viewModel.getCategoryName().uppercased()
        // If collection is already initialized, reload it.
        // This handles cases where configure is called after viewDidLoad.
        if collection != nil {
            collection.reloadData()
        }
    }
    
}

extension Questions: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return viewModel.numberOfQuestions()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCell.reuseIdentifier, for: indexPath) as? HomeCell {
                if let question = viewModel.question(at: indexPath.row) {
                    cell.configure(with: question.Question) // Assuming HomeCell's configure can take a String
                }
                return cell
            }
            return UICollectionViewCell()
    }
    
    
}

extension Questions: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            if let questionItem = viewModel.getSelectedQuestion(at: indexPath.row) {
                // The original code used QuestoinAnswerDetail, ensure this class exists and its initializer is correct.
                // Assuming QuestoinAnswerDetail is correctly named and available.
                let vc = QuestoinAnswerDetail(item: questionItem) 
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true)
            }
    }
}
extension Questions: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width, height: 90)
    }
}
