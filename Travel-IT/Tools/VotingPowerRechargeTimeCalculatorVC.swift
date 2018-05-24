//
//  VotingPowerRechargeTimeCalculatorVC.swift
//  Travel-IT
//
//  Created by Ankit Singh on 12/04/18.
//  Copyright © 2018 Ankit Singh. All rights reserved.
//

import UIKit

class VotingPowerRechargeTimeCalculatorVC: UIViewController {
    
    @IBOutlet var targetedVotingPowerTextFieldValue: UITextField!
    @IBOutlet var currentVotingPowerTextFieldValue: UITextField!
    @IBOutlet var secondsLabel: UILabel!
    @IBOutlet var minutesLabel: UILabel!
    @IBOutlet var hoursLabel: UILabel!
    @IBOutlet var daysLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.targetedVotingPowerTextFieldValue.keyboardType = .numberPad
        self.currentVotingPowerTextFieldValue.keyboardType = .numberPad
    }
    
    @IBAction func calculateButtonClick(_ sender: Any) {
        let targetedValue = Int(self.targetedVotingPowerTextFieldValue.text!)
        let currentValue = Int(self.currentVotingPowerTextFieldValue.text!)
        let difference = (targetedValue! - currentValue!)
        var timeInSecond  = Double(difference) * 43.2 / 0.01
        self.view.endEditing(true)
        self.updateLabels(time: Int(timeInSecond), targetedValue: targetedValue!)
    }
    
    func updateLabels(time: Int, targetedValue: Int) {
        let minutes = time / 60
        let hours = minutes / 60
        let days = hours / 24
        self.secondsLabel.text = "In order to reach the percentage of " + "\(targetedValue)%" + " you have to wait " + "\(time) seconds"
        self.minutesLabel.text = "In order to reach the percentage of " + "\(targetedValue)%" + " you have to wait " + "\(minutes) minutes"
        self.hoursLabel.text = "In order to reach the percentage of " + "\(targetedValue)%" + " you have to wait " + "\(hours) hours"
        self.daysLabel.text = "In order to reach the percentage of " + "\(targetedValue)%" + " you have to wait " + "\(days) days"
    }
    
}
