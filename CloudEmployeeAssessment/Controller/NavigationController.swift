//
//  NavigationController.swift
//  CloudEmployeeAssessment
//
//  Created by Mary Marielle Miranda on 10/2/15.
//  Copyright © 2015 Mary Marielle Miranda. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController, UINavigationControllerDelegate {

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.delegate = self
        self.setupInterface()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Setup
    private func setupInterface() -> Void {
        self.navigationBar.tintColor = UIColor.darkGrayColor()
        self.navigationBar.barTintColor = UIColor.clearColor()
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
    }
    
    //MARK: - UINavigationController Delegate
    func navigationController(navigationController: UINavigationController, willShowViewController viewController: UIViewController, animated: Bool) {
        
        //Hide navigationBar for certain Controllers
        if viewController.isKindOfClass(StartScreenViewController.classForCoder()) ||
            viewController.isKindOfClass(UniversitySelectionTableViewController.classForCoder()) {
            self.navigationBarHidden = true
        } else {
            self.navigationBarHidden = false
        }
        
        viewController.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
    }
}
