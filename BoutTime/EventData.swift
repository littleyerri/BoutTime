//
//  EventData.swift
//  SingleViewAppSwiftTemplate
//
//  Created by Gerardo Zayas on 7/2/17.
//  Copyright © 2017 Treehouse. All rights reserved.
//

import Foundation

// Class for converting data from plist file.
class Converter {
    static func dictionary(fromFile name: String, ofType type: String) throws -> [String: AnyObject] {
        guard let path = Bundle.main.path(forResource: name, ofType: type) else {
            throw ContentError.invalidResource
        }
        
        guard let dictionary = NSDictionary(contentsOfFile: path) as? [String: AnyObject] else {
            throw ContentError.failedConversion
        }
        
        return dictionary
    }
}

// Class for unarchiving data.
class Unarchiver {
    static func data(fromDictionary dictionary: [String: AnyObject]) throws -> [Content] {
        var data: [Content] = []
        
        for (key, value) in dictionary {
            if let itemDictionary = value as? [String: Any], let year = itemDictionary["year"] as? Int, let url = itemDictionary["url"] as? String {
                let content = Event(event: key, year: year, url: url)
                
                data.append(content)
            } else {
                throw ContentError.invalidData
            }
        }
        
        return data
    }
}









