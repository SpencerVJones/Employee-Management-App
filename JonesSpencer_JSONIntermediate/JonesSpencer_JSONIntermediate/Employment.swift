//  Employment.swift
//  JonesSpencer_JSONIntermediate
//  Created by Spencer Jones on 4/11/24.


import Foundation

class Employment {
    // MARK: Stored Properties
    let company: String
    let responsibilities: [String]
    
    // MARK: Initializers
    init(company: String, responsibilities: [String]) {
        self.company = company
        self.responsibilities = responsibilities
    }
    
    // MARK: Convenience Initializer
    convenience init(company: String? = nil, responsibilities: [String]? = nil) {
        // Check if company is provided
        if let company = company {
            // If responsibilities are also provided
            if let responsibilities = responsibilities {
                self.init(company: company, responsibilities: responsibilities)
            } else {
                // If responsibilities are missing
                self.init(company: company, responsibilities: nil)
            }
        } else {
            // If company is missing, initialize with default values
            self.init(company: nil, responsibilities: nil)
        }
    }
}
