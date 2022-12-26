//
//  ViewController.swift
//  prework_ios102
//
//  Created by Đặng Đức Trường on 12/23/22.
//

import UIKit
import SwiftUI

class CellClass: UITableViewCell {}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = dataSource[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 61
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.row == 0) {
            print("Major selected")
            majorLabel.isHidden = false
            majorTextField.isHidden = false
            deleteButtonMajor.isHidden = false
        } else if (indexPath.row == 1) {
            print("GPA selected")
            gpaLabel.isHidden = false
            gpaNumberLabel.isHidden = false
            gpaStepper.isHidden = false
            deleteButtonGPA.isHidden = false
        } else if (indexPath.row == 2) {
            print("Hobby selected")
            hobbyLabel.isHidden = false
            hobbyTextField.isHidden = false
            deleteButtonHobby.isHidden = false
        }
        removeTransparentView()
    }
}

class ViewController: UIViewController {
    let darkModeCheck = UIColor(red: 128/255, green: 203/255, blue: 196/255, alpha: 1.0)
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var schoolNameTextField: UITextField!
    @IBOutlet weak var morePetsStepper: UIStepper!
    @IBOutlet weak var morePetsSwitch: UISwitch!
    @IBOutlet weak var darkModeButton: UIButton!
    
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var schoolLabel: UILabel!
    @IBOutlet weak var petsLabel: UILabel!
    @IBOutlet weak var morePetsLabel: UILabel!
    
    @IBOutlet weak var Menu_Deco: UIButton!
    
    @IBOutlet weak var yearSegmentedControl: UISegmentedControl!
    @IBOutlet weak var numberOfPetsLabel: UILabel!
    // Additional info
    @IBOutlet weak var majorLabel: UILabel!
    @IBOutlet weak var majorTextField: UITextField!
    @IBOutlet weak var gpaLabel: UILabel!
    @IBOutlet weak var gpaNumberLabel: UILabel!
    @IBOutlet weak var gpaStepper: UIStepper!
    @IBOutlet weak var hobbyLabel: UILabel!
    @IBOutlet weak var hobbyTextField: UITextField!
    @IBOutlet weak var deleteButtonMajor: UIButton!
    @IBOutlet weak var deleteButtonGPA: UIButton!
    @IBOutlet weak var deleteButtonHobby: UIButton!
    
    @IBAction func stepperDidChange(_ sender: UIStepper) {
        numberOfPetsLabel.text = "\(Int(sender.value))"
    }
    
    @IBAction func introduceSelfDidTap(_ sender: UIButton) {
        // miss first or last name
        if (firstNameTextField.text == "" || lastNameTextField.text == "") {
            let alertController = UIAlertController(title: "Missing Info", message: "Type your full name", preferredStyle: .alert)
            let action = UIAlertAction(title: "Okay", style: .default, handler: nil)
            alertController.addAction(action)
            present(alertController, animated: true, completion: nil)
        }
        // miss school name
        if (schoolNameTextField.text == "") {
            let alertController = UIAlertController(title: "Missing Info", message: "What is your school name?", preferredStyle: .alert)
            let action = UIAlertAction(title: "Okay", style: .default, handler: nil)
            alertController.addAction(action)
            present(alertController, animated: true, completion: nil)
        }
        // miss major
        if (majorTextField.text == "" && majorTextField.isHidden == false) {
            let alertController = UIAlertController(title: "Missing Info", message: "What is your major?", preferredStyle: .alert)
            let action = UIAlertAction(title: "Okay", style: .default, handler: nil)
            alertController.addAction(action)
            present(alertController, animated: true, completion: nil)
        }
        // miss hobby
        if (hobbyTextField.text == "" && hobbyTextField.isHidden == false) {
            let alertController = UIAlertController(title: "Missing Info", message: "What are your hobbies?", preferredStyle: .alert)
            let action = UIAlertAction(title: "Okay", style: .default, handler: nil)
            alertController.addAction(action)
            present(alertController, animated: true, completion: nil)
        }
        
        let year = yearSegmentedControl.titleForSegment(at: yearSegmentedControl.selectedSegmentIndex)
        var year_num = 0
        if (year == "First") {
            year_num = 2022
        } else if (year == "Second") {
            year_num = 2021
        } else if (year == "Third") {
            year_num = 2020
        } else {
            year_num = 2019
        }
                
        var introduction = "My name is \(firstNameTextField.text!) \(lastNameTextField.text!). I am attending the \(schoolNameTextField.text!) and I am the Class of \(year_num). I own \(numberOfPetsLabel.text!) pets and it is \(morePetsSwitch.isOn) that I want more."
        if (majorLabel.isHidden == false) {
            introduction += " My major is \(majorTextField.text!)."
        }
        if (gpaLabel.isHidden == false) {
            introduction += " My current overall GPA is \(gpaNumberLabel.text!)."
        }
        if (hobbyLabel.isHidden == false) {
            introduction += " I often spend my free time on \(hobbyTextField.text!)."
        }
        print(introduction)
        
        let alertController = UIAlertController(title: "My Introduction", message: introduction, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Nice to meet you!", style: .default, handler: nil)
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func darkModeDidTap(_ sender: Any) {
        if (view.backgroundColor == UIColor.white) {
            view.backgroundColor = darkModeCheck
            textDarkMode()
        } else {
            view.backgroundColor = UIColor.white
            textWhiteMode()
        }
    }
    // Add Button function
    @IBAction func addButton(_ sender: Any) {
        dataSource = ["Major", "GPA", "Hobby"]
        selectedButton = Menu_Deco
        addTransparentView(frames: Menu_Deco.frame)
    }
    var dataSource = [String]()
    var selectedButton = UIButton()
    let transparentView = UIView()
    let tableView = UITableView()
    func addTransparentView(frames: CGRect) {
        let window = UIApplication.shared.keyWindow
        transparentView.frame = window?.frame ?? self.view.frame
        self.view.addSubview(transparentView)
             
        tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: 0, height: 0)
        self.view.addSubview(tableView)
        tableView.layer.cornerRadius = 5

        transparentView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        
        tableView.reloadData()
        
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(removeTransparentView))
        transparentView.addGestureRecognizer(tapgesture)
        transparentView.alpha = 0
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.transparentView.alpha = 0.4
            self.tableView.frame = CGRect(x: frames.origin.x + 10, y: frames.origin.y + frames.height + 5, width: 100, height: CGFloat(self.dataSource.count * 61))
        }, completion: nil)
    }
    
    @objc func removeTransparentView() {
        let frames = selectedButton.frame
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.transparentView.alpha = 0
            self.tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: 0, height: 0)
        }, completion: nil)
    }
    
    @IBAction func majorDeleteDidTap(_ sender: Any) {
        majorLabel.isHidden = true
        majorTextField.isHidden = true
        deleteButtonMajor.isHidden = true
    }
    
    @IBAction func gpaDeleteDidTap(_ sender: Any) {
        gpaLabel.isHidden = true
        gpaNumberLabel.isHidden = true
        gpaStepper.isHidden = true
        deleteButtonGPA.isHidden = true
    }
    
    @IBAction func hobbyDeleteDidTap(_ sender: Any) {
        hobbyLabel.isHidden = true
        hobbyTextField.isHidden = true
        deleteButtonHobby.isHidden = true
    }
    
    @IBAction func gpaStepper(_ sender: UIStepper) {
        gpaNumberLabel.text = "\(Float(sender.value/10))"
    }
    
    // Load the View
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        darkModeButton.layer.cornerRadius = 12
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CellClass.self, forCellReuseIdentifier: "Cell")
        // Additional info
        majorLabel.isHidden = true
        majorTextField.isHidden = true
        gpaLabel.isHidden = true
        gpaNumberLabel.isHidden = true
        gpaStepper.isHidden = true
        hobbyLabel.isHidden = true
        hobbyTextField.isHidden = true
        deleteButtonMajor.isHidden = true
        deleteButtonGPA.isHidden = true
        deleteButtonHobby.isHidden = true
    }
    
    func textDarkMode() {
        firstNameLabel.textColor = UIColor.white
        lastNameLabel.textColor = UIColor.white
        schoolLabel.textColor = UIColor.white
        petsLabel.textColor = UIColor.white
        numberOfPetsLabel.textColor = UIColor.white
        morePetsLabel.textColor = UIColor.white
        majorLabel.textColor = UIColor.white
        gpaLabel.textColor = UIColor.white
        gpaNumberLabel.textColor = UIColor.white
        hobbyLabel.textColor = UIColor.white
    }
    
    func textWhiteMode() {
        firstNameLabel.textColor = UIColor.black
        lastNameLabel.textColor = UIColor.black
        schoolLabel.textColor = UIColor.black
        petsLabel.textColor = UIColor.black
        numberOfPetsLabel.textColor = UIColor.black
        morePetsLabel.textColor = UIColor.black
        majorLabel.textColor = UIColor.black
        gpaLabel.textColor = UIColor.black
        gpaNumberLabel.textColor = UIColor.black
        hobbyLabel.textColor = UIColor.black
    }
}

