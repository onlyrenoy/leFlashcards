import Foundation
import AVFoundation // For AVSpeechSynthesizer, if logic moves here

enum QnAState {
    case question
    case answer
    case example
}

class QuestionAndAnswersViewModel {
    private var item: Item
    
    var currentState: QnAState = .question {
        didSet {
            updateStateDerivedProperties()
        }
    }
    
    // Properties for the View
    var currentCardTitle: String = "QUESTION"
    var currentTextContent: String = ""
    var buttonAreaText: String = "Go to Answer"
    var showReadButton: Bool = false
    
    // Text-to-speech
    let synthesizer = AVSpeechSynthesizer()

    // MARK: - Initialization
    init(item: Item) {
        self.item = item
        // Set initial text content
        self.currentTextContent = item.Question
        updateStateDerivedProperties() // Ensure all properties are set based on initial state
    }
    
    // MARK: - State Management
    func transitionState() {
        synthesizer.stopSpeaking(at: .immediate) // Stop any ongoing speech before transition
        switch currentState {
        case .question:
            currentState = .answer
        case .answer:
            currentState = .example
        case .example:
            currentState = .question
        }
    }
    
    private func updateStateDerivedProperties() {
        switch currentState {
        case .question:
            currentCardTitle = "QUESTION"
            currentTextContent = item.Question
            buttonAreaText = "Go to Answer".uppercased()
            showReadButton = false
        case .answer:
            currentCardTitle = "ANSWER"
            currentTextContent = item.Answer
            buttonAreaText = "See Example".uppercased()
            showReadButton = true
        case .example:
            currentCardTitle = "EXAMPLE"
            currentTextContent = item.Example
            buttonAreaText = "Check Question".uppercased()
            showReadButton = true
        }
    }

    // MARK: - Data Access
    func getItem() -> Item {
        return item
    }

    func getTextForSpeech() -> String {
        switch currentState {
        case .question:
            return "" // Or item.Question if readable
        case .answer:
            return item.Answer
        case .example:
            return item.Example
        }
    }
    
    // MARK: - Actions
    func speakCurrentText() {
        let textToSpeak = getTextForSpeech()
        if textToSpeak.isEmpty { return }
        
        synthesizer.stopSpeaking(at: .immediate) // Stop previous before starting new
        let utterance = AVSpeechUtterance(string: textToSpeak)
        utterance.voice = AVSpeechSynthesisVoice(identifier: "com.apple.ttsbundle.Samantha-compact") // Example voice
        utterance.rate = 0.4 // Example rate
        synthesizer.speak(utterance)
    }
    
    func stopSpeaking() {
        synthesizer.stopSpeaking(at: .immediate)
    }
}
