//  Employee.swift
//  JonesSpencer_JSONIntermediate
//  Created by Spencer Jones on 4/9/24.

import Foundation

class Employee {
    // MARK: Stored Properties
    let employeename: String
    let username: String
    let macAddress: String
    let currentTitle: String
    let skills: [String]
    var employment: [Employment]
    
    // MARK: Computed Properties
    // Returns the number of skills the employee has
    var skillsCount: Int {
        skills.count
    }
    
    // Returns the number of employers the employee has had
    var employersCount: Int {
        employment.count
    }
    
    // Returns a formatted string of the employee's past employers and responsibilities
    var formattedPastEmployers: String {
        var pastEmployersText = ""
        for employment in employment {
            pastEmployersText += "Company: \(employment.company)\nResponsibilities: \(employment.responsibilities.joined(separator: ", "))\n\n"
        }
        return pastEmployersText
    }
    
    
    // MARK: Initalizer
    init(employeename: String, username: String, macAddress: String, currentTitle: String, skills: [String], employment: [Employment] = [Employment]()) {
        self.employeename = employeename
        self.username = username
        self.macAddress = macAddress
        self.currentTitle = currentTitle
        self.skills = skills
        self.employment = employment
    }
    
    
    // MARK: Methods
    // Method that formats the skills section
    func formattedSkills() -> String {
        var skillsString = ""
        
        // Loop through skills array
        for (index, skill) in skills.enumerated() {
            if index == skills.count - 1 {
                // If it's the  last skill, don't add a comma
                skillsString += skill
            } else {
                // Otherwise, add a comma after the skill
                skillsString += "\(skill), "
            }
        }
        // Return the String
        return skillsString
    }
}
