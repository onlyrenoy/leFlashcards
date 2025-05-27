//
//  QuestionAndAnswers.swift
//  Hard75
//
//  Created by Renoy Chowdhury on 19/08/24.
//

import UIKit
import AVFoundation

class QuestoinAnswerDetail: UIViewController {
    var viewModel: QuestionAndAnswersViewModel! // Added viewModel property
    // Removed CurrentState enum and currentState property
    
    var close = UIButton()
    
    var currentCard = UILabel()
    
    var questionContaner = UIView()
    var question = UILabel()

    var answerContaner = UIView()
    var answer = UITextView()
    
    var exampleContaner = UIView()
    var example = UITextView()
    
    var questionLayer = UIView()
    var answerLayer = UIView()
    var exampleLayer = UIView()
    
    var buttonArea = UIView()
    var buttonAreaText = UILabel()
    
    var readButton = UIImageView()
    // Removed synthesizer property
    
    let wholeWidth = UIScreen.main.bounds.width
    
    // Removed item property
    
    internal init(item: Item) {
        self.viewModel = QuestionAndAnswersViewModel(item: item) // Updated initializer
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(hexString: "1861F1")
        
        close.setImage(UIImage(systemName: "xmark"), for: .normal)
        close.tintColor = .white
        close.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
        
        question.numberOfLines = 0
        question.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        answer.font = UIFont.systemFont(ofSize: 22)
        answer.isEditable = false
        
        readButton.image = UIImage(systemName: "play.circle.fill")
        readButton.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(answerVoice))
        readButton.addGestureRecognizer(tap)
        readButton.alpha = 0
        
        example.font = UIFont.systemFont(ofSize: 22)
        example.isEditable = false
//        examplePlay.setImage(UIImage(systemName: "play.circle.fill"), for: .normal)
//        examplePlay.addTarget(self, action: #selector(exampleVoice), for: .touchUpInside)
        
        questionLayer.backgroundColor = UIColor(hexString: "B2CAF8").withAlphaComponent(1)
        answerLayer.backgroundColor = UIColor(hexString: "B2CAF8").withAlphaComponent(1)
        exampleLayer.backgroundColor = UIColor(hexString: "B2CAF8").withAlphaComponent(1)
        
        questionLayer.layer.cornerRadius = 30
        answerLayer.layer.cornerRadius = 30
        exampleLayer.layer.cornerRadius = 30
        
        buttonArea.backgroundColor = .orange
        
        let tapQuestion = UITapGestureRecognizer(target: self, action: #selector(questionTap))
        questionLayer.addGestureRecognizer(tapQuestion)
        
        let tapAnswer = UITapGestureRecognizer(target: self, action: #selector(answerTap))
        answerLayer.addGestureRecognizer(tapAnswer)
        
        let tapExample = UITapGestureRecognizer(target: self, action: #selector(exampleTap))
        exampleLayer.addGestureRecognizer(tapExample)
        
        let tapButtonArea = UITapGestureRecognizer(target: self, action: #selector(buttonAreaTap))
        buttonArea.addGestureRecognizer(tapButtonArea)
        view.addGestureRecognizer(tapButtonArea)
        
        
        questionContaner.subviews(question, questionLayer)
        questionContaner.layout(
            8,
            |-16-question-16-|,
            8
        )
        
        questionContaner.layer.masksToBounds = true
        questionLayer.fillContainer()
        questionLayer.alpha = 0
        
        questionContaner.style { ch in
            ch.backgroundColor = .white
            ch.layer.cornerRadius = 30
            ch.layer.shadowColor = UIColor.blue.cgColor
            ch.layer.shadowOpacity = 0.1
            ch.layer.shadowOffset = CGSizeMake(0, 1)
            ch.layer.shadowRadius = 6
        }
        
        answerContaner.subviews(answer, answerLayer)
        
        answerContaner.layout(
            8,
            |-16-answer-16-|,
//            answerPlay.width(20)-| ~ 20,
            8
        )
        
        answerLayer.fillContainer()
        answerLayer.width(wholeWidth)
        
        answerContaner.style { ch in
            ch.backgroundColor = .white
            ch.layer.cornerRadius = 30
            ch.layer.shadowColor = UIColor.blue.cgColor
            ch.layer.shadowOpacity = 0.1
            ch.layer.shadowOffset = CGSizeMake(0, 1)
            ch.layer.shadowRadius = 6
        }
        
        exampleContaner.subviews(example, exampleLayer)
        
        exampleContaner.layout(
            8,
            |-16-example-16-|,
//            examplePlay.width(20)-| ~ 20,
            8
        )
        
        exampleLayer.fillContainer()
        exampleLayer.width(wholeWidth)
        
        exampleContaner.style { ch in
            ch.backgroundColor = .white
            ch.layer.cornerRadius = 30
            ch.layer.shadowColor = UIColor.blue.cgColor
            ch.layer.shadowOpacity = 0.1
            ch.layer.shadowOffset = CGSizeMake(0, 1)
            ch.layer.shadowRadius = 6
        }
        
        readButton.contentMode = .scaleAspectFill
        readButton.tintColor = .white
        
        
        currentCard.text = "Question".uppercased()
        currentCard.font = .systemFont(ofSize: 30,
                                       weight: .bold)
        currentCard.textColor = .white
        currentCard.textAlignment = .center
        
        self.view.subviews(close, currentCard, exampleContaner, answerContaner, questionContaner, readButton, buttonArea)
        
        self.view.layout(
            60,
            close.width(20)-| ~ 20 ,
            40,
            |-20-currentCard-20-|,
            30,
            |-20-questionContaner-20-| ~ 300,
            -260,
            |-30-answerContaner-30-| ~ 300,
            -270,
            |-40-exampleContaner-40-| ~ 300,
            "",
            readButton-40-| ~ 60,
            20,
            |-0-buttonArea-0-| ~ 80,
            0
        )
        
        buttonAreaText.text = "Answer".uppercased()
        buttonAreaText.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        buttonAreaText.textColor = .white
        buttonAreaText.textAlignment = .center
        
        buttonArea.subviews(buttonAreaText)
        buttonArea.layout(
        12,
        |-buttonAreaText-|
        )
        
        
        
        question.text = viewModel.getItem().Question
        answer.text = viewModel.getItem().Answer
        example.text = viewModel.getItem().Example
        
        updateUIFromViewModel() // Call to set initial UI state
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel.stopSpeaking()
    }
    
    // MARK: - UI Update and Animation Helpers
    func updateUIFromViewModel() {
        currentCard.text = viewModel.currentCardTitle
        buttonAreaText.text = viewModel.buttonAreaText
        
        UIView.animate(withDuration: 0.1) { // Animate readButton visibility
             self.readButton.alpha = self.viewModel.showReadButton ? 1 : 0
        }
        
        switch viewModel.currentState {
        case .question:
            animateToQuestionState()
        case .answer:
            animateToAnswerState()
        case .example:
            animateToExampleState()
        }
    }

    private func animateToQuestionState() {
        UIView.animate(withDuration: 0.1) {
            self.questionLayer.alpha = 0
            self.answerLayer.alpha = 1
            self.exampleLayer.alpha = 1
            
            self.questionContaner.transform = CGAffineTransform(translationX: 0, y: 120)
            self.answerContaner.transform = CGAffineTransform(translationX: 0, y: 120)
            self.exampleContaner.transform = CGAffineTransform(translationX: 0, y: 120)
            
            self.view.layoutIfNeeded() // May not be needed here if only transform/alpha changes
            self.view.bringSubviewToFront(self.exampleContaner)
            self.view.bringSubviewToFront(self.answerContaner)
            self.view.bringSubviewToFront(self.questionContaner)
        } completion: { finished in
            UIView.animate(withDuration: 0.3) {
                self.questionContaner.transform = .identity
                self.answerContaner.transform = .identity
                self.exampleContaner.transform = .identity
                
                self.questionContaner.frame.origin.x = 20
                self.answerContaner.frame.origin.x = 30
                self.exampleContaner.frame.origin.x = 40
                
                self.questionContaner.frame.size.width = self.wholeWidth - 40
                self.answerContaner.frame.size.width = self.wholeWidth - 60
                self.exampleContaner.frame.size.width = self.wholeWidth - 80
            }
        }
    }

    private func animateToAnswerState() {
        // Original answerTap animation
        exampleContaner.backgroundColor = UIColor(hexString: "B2CAF8") // This seems view specific, keep here
        UIView.animate(withDuration: 0.1) {
            self.questionLayer.alpha = 1
            self.answerLayer.alpha = 0
            self.exampleLayer.alpha = 1
            
            self.questionContaner.transform = CGAffineTransform(translationX: 0, y: 120)
            self.answerContaner.transform = CGAffineTransform(translationX: 0, y: 120)
            self.exampleContaner.transform = CGAffineTransform(translationX: 0, y: 120)
            
            self.view.layoutIfNeeded()
            self.view.bringSubviewToFront(self.questionContaner)
            self.view.bringSubviewToFront(self.exampleContaner)
            self.view.bringSubviewToFront(self.answerContaner)
        } completion: { finished in
            UIView.animate(withDuration: 0.3) {
                self.questionContaner.transform = .identity
                self.answerContaner.transform = .identity
                self.exampleContaner.transform = .identity
                
                self.questionContaner.frame.origin.x = 30
                self.answerContaner.frame.origin.x = 20
                self.exampleContaner.frame.origin.x = 30
                
                self.questionContaner.frame.size.width = self.wholeWidth - 60
                self.answerContaner.frame.size.width = self.wholeWidth - 40
                self.exampleContaner.frame.size.width = self.wholeWidth - 60
            }
        }
    }

    private func animateToExampleState() {
        // Original exampleTap animation
        exampleContaner.backgroundColor = .white // This seems view specific, keep here
        UIView.animate(withDuration: 0.1) {
            self.questionLayer.alpha = 1
            self.answerLayer.alpha = 1
            self.exampleLayer.alpha = 0
            
            self.questionContaner.transform = CGAffineTransform(translationX: 0, y: 120)
            self.answerContaner.transform = CGAffineTransform(translationX: 0, y: 120)
            self.exampleContaner.transform = CGAffineTransform(translationX: 0, y: 120)
            
            self.view.layoutIfNeeded()
            self.view.bringSubviewToFront(self.questionContaner)
            self.view.bringSubviewToFront(self.answerContaner)
            self.view.bringSubviewToFront(self.exampleContaner)
        } completion: { finished in
            UIView.animate(withDuration: 0.3) {
                self.questionContaner.transform = .identity
                self.answerContaner.transform = .identity
                self.exampleContaner.transform = .identity
                
                self.questionContaner.frame.origin.x = 40
                self.answerContaner.frame.origin.x = 30
                self.exampleContaner.frame.origin.x = 20
                
                self.questionContaner.frame.size.width = self.wholeWidth - 80
                self.answerContaner.frame.size.width = self.wholeWidth - 60
                self.exampleContaner.frame.size.width = self.wholeWidth - 40
            }
        }
    }
    
    // MARK: - Actions
    @objc
    func closeTapped() {
        viewModel.stopSpeaking()
        self.dismiss(animated: true)
    }
    
    @objc
    func questionTap() {
        viewModel.currentState = .question
        updateUIFromViewModel()
    }
    
    @objc
    func answerTap() {
        viewModel.currentState = .answer
        updateUIFromViewModel()
    }
    
    @objc
    func exampleTap() {
        viewModel.currentState = .example
        updateUIFromViewModel()
    }
    
    @objc
    func buttonAreaTap() {
        viewModel.transitionState()
        updateUIFromViewModel()
    }
    
    
    @objc
    func answerVoice() {
        viewModel.speakCurrentText()
    }
}


extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}
