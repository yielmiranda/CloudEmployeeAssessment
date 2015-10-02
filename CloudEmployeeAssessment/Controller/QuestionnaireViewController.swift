//
//  QuestionnaireViewController.swift
//  CloudEmployeeAssessment
//
//  Created by Mary Marielle Miranda on 10/2/15.
//  Copyright © 2015 Mary Marielle Miranda. All rights reserved.
//

import UIKit

class QuestionnaireViewController: UIViewController, UITextFieldDelegate, UIAlertViewDelegate, UniversitySelectionTableViewControllerDelegate {

    //MARK: - Properties
    //MARK: IBOutlet
    @IBOutlet weak var btnDone: UIButton!
    @IBOutlet weak var txtUniversity: UITextField!
    @IBOutlet weak var txtGraduationYear: UITextField!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupInterface()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Setup
    private func setupInterface() -> Void {
        btnDone.layer.cornerRadius = 5.0
        btnDone.layer.borderWidth = 2.0
        btnDone.layer.borderColor = UIColor.groupTableViewBackgroundColor().CGColor
        btnDone.clipsToBounds = true
    }
    
    //MARK: - IBAction Delegate
    @IBAction func didSelectButton(sender: AnyObject) {
        if self.txtUniversity.text!.characters.count > 0 && self.txtGraduationYear.text!.characters.count > 0 {
            let alert = UIAlertView(title: "", message: "Done", delegate: self, cancelButtonTitle: "Okay")
            alert.show()
        } else {
            let alert = UIAlertView(title: "", message: "Fill up the form completely.", delegate: nil, cancelButtonTitle: "Okay")
            alert.show()
        }
    }
    
    //MARK: - UIAlertView Delegate
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        self.navigationController!.popToRootViewControllerAnimated(true)
    }
    
    //MARK: - UITextField Delegate
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        if textField == txtUniversity {
            self.performSegueWithIdentifier("proceedToUniversitySelection", sender: self)
            return false
        }
        
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //MARK: - UniversitySelectionTableViewController Delegate
    func didSelectUniversity(university: University) {
        self.txtUniversity.text = university.universityName
    }
    
    //MARK: - Navigation Delegate
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let controller = segue.destinationViewController as! UniversitySelectionTableViewController
        controller.delegate = self
    }
}
