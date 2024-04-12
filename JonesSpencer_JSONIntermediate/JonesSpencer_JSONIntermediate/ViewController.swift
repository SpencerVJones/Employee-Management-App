//  ViewController.swift
//  JonesSpencer_JSONIntermediate
//  Created by Spencer Jones on 4/9/24.

import UIKit

class ViewController: UIViewController {
    
    // Outlets
    @IBOutlet var employeeNameLabel: UILabel!
    @IBOutlet var userNameLabel: UILabel!
    @IBOutlet var macAddressLabel: UILabel!
    @IBOutlet var jobTitleLabel: UILabel!
    @IBOutlet var skillsLabel: UILabel!
    @IBOutlet var pastEmployersLabel: UILabel!
    @IBOutlet var pastEmployersCountLabel: UILabel!
    @IBOutlet var skillsCountLabel: UILabel!
    
    // Empty array of Employee models
    var employees = [Employee]()
    
    // Variable to represent index in customer array in object to display
    var currentEmployeeIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // MARK: Access to JSON data
        // Get path to EmployeeData.json file
        if let path = Bundle.main.path(forResource: "EmployeeData", ofType: ".json") {
            // Create URL with path
            let url = URL(fileURLWithPath: path)
            do {
                // Create data object from file's URL
                let data = try Data.init(contentsOf: url)
                // Create JSON object from binary data file & cast as array of Any Type
                let jsonObj = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [Any]
                
                // Call Parse Method
                Parse(jsonObject: jsonObj)
                
                // Call updateUI method
                updateUI()
            } catch { print(error.localizedDescription) }
        }
    }
    
    // MARK: Parse Method
    func Parse(jsonObject: [Any]?) {
        guard let json = jsonObject
        else { print("Parse failed to unwrap the optional"); return }
        
        // Loop through first level object
        for firstLevelItem in json {
            // Try to conver first level objext into a [String: Any]
            guard let object = firstLevelItem as? [String: Any],
                  // Get value of properties for the current object
                  let employeename  = object["employeename"] as? String,
                  let username = object["username"] as? String,
                  let macAddress = object["macaddress"] as? String,
                  let currentTitle = object["current_title"] as? String,
                  let skills = object["skills"] as? [String]
                    
            else {continue}
            
            // Parse past employers if available
            var pastEmployersArray = [Employment]()
            if let pastEmployers = object["past_employers"] as? [[String: Any]] {
                for employer in pastEmployers {
                    guard let company = employer["company"] as? String,
                          let responsibilities = employer["responsibilities"] as? [String] else {
                        continue
                    }
                    let employment = Employment(company: company, responsibilities: responsibilities)
                    pastEmployersArray.append(employment)
                }
            }
            
            // Create Employee object
            let employee = Employee(employeename: employeename, username: username, macAddress: macAddress, currentTitle: currentTitle, skills: skills, employment: pastEmployersArray)
            
            // Add employee to the array
            employees.append(employee)
        }
    }
    
    // MARK: Update UI
    func updateUI() {
        let employee = employees[currentEmployeeIndex]
        
        employeeNameLabel.text = employee.employeename
        userNameLabel.text = employee.username
        macAddressLabel.text = employee.macAddress
        jobTitleLabel.text = employee.currentTitle
        skillsLabel.text = employee.formattedSkills()
        skillsCountLabel.text = "\(employee.skillsCount)"
        pastEmployersCountLabel.text = "\(employee.employersCount)"
        pastEmployersLabel.text = employee.formattedPastEmployers
    }
    
    
    // MARK: Storyboard Actions
    @IBAction func currentEmployeeChanged(_ sender: UIButton) {
        // Next button = tag of 1
        // Previous button = tag of -1
        
        currentEmployeeIndex += sender.tag
        
        if currentEmployeeIndex < 0 {
            currentEmployeeIndex = employees.count - 1
        }
        else if
            currentEmployeeIndex >= employees.count {
            currentEmployeeIndex = 0
        }
        // Update the UI
        updateUI()
    }
}

