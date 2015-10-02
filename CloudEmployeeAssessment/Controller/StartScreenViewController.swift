//
//  StartScreenViewController.swift
//  CloudEmployeeAssessment
//
//  Created by Mary Marielle Miranda on 10/2/15.
//  Copyright © 2015 Mary Marielle Miranda. All rights reserved.
//

import UIKit

class StartScreenViewController: UIViewController {

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: "tapRecognized:")
        self.view.addGestureRecognizer(tapGestureRecognizer)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: - UITapGestureRecognizer
    func tapRecognized(gesture: UITapGestureRecognizer) -> Void {
        self.performSegueWithIdentifier("proceedToQuestionnaire", sender: nil)
    }
}
