//
//  EventFoundation.swift
//  BoutTime
//
//  Created by Jerry Zayas on 7/5/17.
//  Copyright © 2017 Little Yerri. All rights reserved.
//

import Foundation
import GameKit

// MARK: Protocols

// Insures correct data is included in each event.
protocol Content {
    var event: String { get }
    var year:  Int { get }
}

// Insures game functionality.
protocol Game {
    var collectionOfEvents: [Content] { get set }
    var rounds:             Int { get set }
    var numberOfRounds:     Int { get }
    var points:             Int { get set }
    var timer:              Int { get }
    
    init(collectionOfEvents: [Content])
    
    func randomEvents(_ amount: Int) -> [Content]
    func checkOrder(of event: [Content]) -> Bool
}

// MARK: Structs

// Stores event conten.
struct Event: Content {
    let event: String
    let year:  Int
}

// MARK: Enums

// Errors
enum ContentError: Error {
    case invalidResource
    case conversionFailure
    case invalidData
}

// MARK: Classes

// Converts data from plist file.
class PlistImporter {
    static func dictionary(fromFile name: String, ofType type: String) throws -> [[String: AnyObject]] {
        guard let path = Bundle.main.path(forResource: name, ofType: type) else {
            throw ContentError.invalidResource
        }
        
        guard let dictionaryArray = NSArray.init(contentsOfFile: path) as? [[String: AnyObject]] else {
            throw ContentError.conversionFailure
        }
        
        return dictionaryArray
    }
}

// Unarchives data from plist file.
class CollectionUnarchiver {
    static func collection(from array: [[String: AnyObject]]) throws -> [Content] {
        var collection: [Content] = []
        
        for dictionary in array {
            if let event = dictionary["movie"] as? String, let year = dictionary["year"] as? Int {
                let event = Event(event: event, year: year)
                collection.append(event)
            } else {
                print("It didn't work!")
            }
        }
        
        return collection
    }
}

// Models game events.
class GameEvents: Game {
    var collectionOfEvents: [Content]
    var points:             Int = 0
    var rounds:             Int = 0
    var numberOfRounds:     Int = 6
    var timer:              Int = 60
    
    required init(collectionOfEvents: [Content]) {
        self.collectionOfEvents = collectionOfEvents
    }
    
    func randomEvents(_ amount: Int) -> [Content] {
        var pickedEvents: [Content] = []
        var usedNumbers:  [Int] = []
        
        while pickedEvents.count < amount {
            let randomNumber = GKRandomSource.sharedRandom().nextInt(upperBound: collectionOfEvents.count)
            
            if usedNumbers.contains(randomNumber) == false {
                pickedEvents.append(collectionOfEvents[randomNumber])
                usedNumbers.append(randomNumber)
            }
        }
        
        return pickedEvents
    }
    
    func checkOrder(of event: [Content]) -> Bool {
        if event[0].year > event[1].year,
           event[1].year > event[2].year,
           event[2].year > event[3].year {
            points += 1
            return true
        } else {
            return false
        }
    }
}









