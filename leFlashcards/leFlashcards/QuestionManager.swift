//
//  ViewController.swift
//  Hard75
//
//  Created by Renoy Chowdhury on 17/07/24.
//

import UIKit

class QuestionManager {
    static var shared = QuestionManager()
    
    var interViewItems: [Item] = []
    
    init() {
        if let fromJson = loadJson(filename: "iosInterview") {
            self.interViewItems = fromJson
        }
    }
    
    func requestCategories() -> [Categories]{
        return Categories.allCases
    }
    
    func list(_ cat: Categories) -> [Item] {
        return interViewItems.compactMap { item in
            if item.Category == cat {
                return item
            } else { return nil }
        }
    }
    
    func loadJson(filename fileName: String) -> [Item]? {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let result = try! JSONDecoder().decode([Item].self, from: data)
                return result
            } catch {
                print("Error!! Unable to parse  \(fileName).json")
            }
        }
        return nil
    }
    
}

enum Categories: String, CaseIterable, Codable {
    case swiftFundamentals = "Swift Fundamentals"
    case uiKitFundamentals = "UIKit Fundamentals"
    case swiftUIFundamentals = "SwiftUI Fundamentals"
    case modularisation = "Modularisation"
    case errorHandling = "Error Handling"
    case networking = "Networking"
    case frameworksLibraries = "Frameworks & Libraries"
    case appAndCodeOptimisation = "App and Code Optimisation"
    case dependencyManagement = "Dependency Management"
    case persistentStorage = "Persistent Storage"
    case concurrency = "Concurrency"
    case memoryManagement = "Memory Management"
    case designPatterns = "Design Patterns"
    case applicationSecurity = "Application Security"
    case advancedSwift = "Advanced Swift"
    case miscellaneous = "Miscellaneous"
    case systemDesignRound = "System Design Round"
}

struct Item: Codable {
    var Category: Categories
    var Question: String
    var Answer: String
    var Example: String
}
