//
//  QuestionAndAnswers.swift
//  Hard75
//
//  Created by Renoy Chowdhury on 19/08/24.
//

import UIKit
import AVFoundation

class QuestoinAnswerDetail: UIViewController {
    enum CurrentState {
        case question
        case answer
        case example
    }
    
    var currentState: CurrentState = .question {
        didSet {
            switch currentState {
            case .question:
                currentCard.text = "QUESTION".uppercased()
                buttonAreaText.text = "Go to Answer".uppercased()
                readButton.alpha = 0
            case .answer:
                currentCard.text = "ANSWER".uppercased()
                buttonAreaText.text = "see Example".uppercased()
                UIView.animate(withDuration: 0.1) {
                    self.readButton.alpha = 1
                }
            case .example:
                currentCard.text = "EXAMPLE".uppercased()
                buttonAreaText.text = "check Question".uppercased()
                UIView.animate(withDuration: 0.1) {
                    self.readButton.alpha = 1
                }
            }
        }
    }
    
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
    let synthesizer = AVSpeechSynthesizer()
    
    let wholeWidth = UIScreen.main.bounds.width
    
    var item: Item
    
    internal init(item: Item) {
        self.item = item
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
        
        
        
        question.text = item.Question
        answer.text = item.Answer
        example.text = item.Example
    }
    
    @objc
    func closeTapped() {
        self.dismiss(animated: true)
    }
    
    @objc
    func questionTap() {
        currentState = .question
        UIView.animate(withDuration: 0.1) {
            self.questionLayer.alpha = 0
            self.answerLayer.alpha = 1
            self.exampleLayer.alpha = 1
            
            self.questionContaner.transform = CGAffineTransform(translationX: 0, y: 120)
            self.answerContaner.transform = CGAffineTransform(translationX: 0, y: 120)
            self.exampleContaner.transform = CGAffineTransform(translationX: 0, y: 120)
            
            self.view.layoutIfNeeded()
            self.view.bringSubviewToFront(self.exampleContaner)
            self.view.bringSubviewToFront(self.answerContaner)
            self.view.bringSubviewToFront(self.questionContaner)
        } completion: { finished in
            UIView.animate(withDuration: 0.3) {
                self.questionContaner.transform = CGAffineTransform(translationX: 0, y: 0)
                self.answerContaner.transform = CGAffineTransform(translationX: 0, y: 0)
                self.exampleContaner.transform = CGAffineTransform(translationX: 0, y: 0)
                
                self.questionContaner.frame.origin.x = 20
                self.answerContaner.frame.origin.x = 30
                self.exampleContaner.frame.origin.x = 40
                
                self.questionContaner.frame.size.width = self.wholeWidth - 40
                self.answerContaner.frame.size.width = self.wholeWidth - 60
                self.exampleContaner.frame.size.width = self.wholeWidth - 80
            }
        }
    }
    
    @objc
    func answerTap() {
        currentState = .answer
        
        exampleContaner.backgroundColor = UIColor(hexString: "B2CAF8")
        
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
                self.questionContaner.transform = CGAffineTransform(translationX: 0, y: 0)
                self.answerContaner.transform = CGAffineTransform(translationX: 0, y: 0)
                self.exampleContaner.transform = CGAffineTransform(translationX: 0, y: 0)
                
                self.questionContaner.frame.origin.x = 30
                self.answerContaner.frame.origin.x = 20
                self.exampleContaner.frame.origin.x = 30
                
                self.questionContaner.frame.size.width = self.wholeWidth - 60
                self.answerContaner.frame.size.width = self.wholeWidth - 40
                self.exampleContaner.frame.size.width = self.wholeWidth - 60
            }
        }
    }
    
    @objc
    func exampleTap() {
        currentState = .example
        
        exampleContaner.backgroundColor = .white
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
                self.questionContaner.transform = CGAffineTransform(translationX: 0, y: 0)
                self.answerContaner.transform = CGAffineTransform(translationX: 0, y: 0)
                self.exampleContaner.transform = CGAffineTransform(translationX: 0, y: 0)
                
                self.questionContaner.frame.origin.x = 40
                self.answerContaner.frame.origin.x = 30
                self.exampleContaner.frame.origin.x = 20
                
                self.questionContaner.frame.size.width = self.wholeWidth - 80
                self.answerContaner.frame.size.width = self.wholeWidth - 60
                self.exampleContaner.frame.size.width = self.wholeWidth - 40
            }
        }
    }
    
    @objc
    func buttonAreaTap() {
        synthesizer.stopSpeaking(at: .word)
        switch currentState {
        case .question:
           answerTap()
        case .answer:
            exampleTap()
        case .example:
            questionTap()
        }
    }
    
    
    @objc
    func answerVoice() {
        var utterance: AVSpeechUtterance?
        
        switch currentState {
        case .question:
            break
        case .answer:
            utterance = AVSpeechUtterance(string: answer.text)
        case .example:
            utterance = AVSpeechUtterance(string: example.text)
        }
        
        utterance?.voice = AVSpeechSynthesisVoice(identifier: "com.apple.ttsbundle.Samantha-compact")
        utterance?.rate = 0.4
        if let utta = utterance {
            synthesizer.speak(utta)
        }
        
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
