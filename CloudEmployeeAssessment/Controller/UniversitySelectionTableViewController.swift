//
//  UniversitySelectionTableViewController.swift
//  CloudEmployeeAssessment
//
//  Created by Hybrid Pay Asia on 10/2/15.
//  Copyright © 2015 Mary Marielle Miranda. All rights reserved.
//

import UIKit

protocol UniversitySelectionTableViewControllerDelegate {
    func didSelectUniversity(university: University) -> Void
}

class UniversitySelectionTableViewController: UITableViewController, UISearchBarDelegate, UISearchDisplayDelegate {

    //MARK: - Properties
    //MARK: IBOutlet
    @IBOutlet weak var searchBarUniversity: UISearchBar!
    
    //MARK: Public
    var delegate: UniversitySelectionTableViewControllerDelegate?
    
    //MARK: Private
    private var searchKey = ""
    
    private var arrSampleData = ["Lyceum of the Philippines University",
                                 "University of the Philippines",
                                 "De La Salle University",
                                 "Ateneo De Manila University",
                                 "University of Sto. Tomas",
                                 "Far Eastern University",
                                 "Joser Rizal University",
                                 "Polytechnic University of the Philippines",
                                 "Adamson University",
                                 "Mapua Institute of Technology",
                                 "Centro Escolar University",
                                 "University of the East",
                                 "Asia Pacific College",
                                 "Universidad de Zamboanga",
                                 "Asian Institute of Journalism and Communication",
                                 "Emilio Aguinaldo College",
                                 "Silliman University",
                                 "Lipa City Colleges",
                                 "Miriam College",
                                 "Davao Medical School Foundation"]
    
    private var _arrRawUniversities: NSMutableArray?
    private var arrRawUniversities: NSMutableArray {
        get {
            if self._arrRawUniversities == nil {
                self._arrRawUniversities = []
                
                (self.arrSampleData as NSArray).enumerateObjectsUsingBlock({ (obj, index, stop) -> Void in
                    let university = University()
                    university.universityName = obj as! String
                    
                    self._arrRawUniversities!.addObject(university)
                })
            }
            
            return self._arrRawUniversities!
        }
    }
    
    private var arrFilteredUniversities = NSMutableArray()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.separatorStyle = .None;
        self.arrFilteredUniversities = self.arrRawUniversities
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Functions
    /*
    Function used to filter data of table view depending on the key entered by user on the Search Bar
    */
    private func filterTableViewWithKey(key: String) -> Void {
        self.searchKey = key
        
        let predicate = NSPredicate(format: "SELF.universityName CONTAINS[c] %@", key)
        self.arrFilteredUniversities = NSMutableArray(array: self.arrRawUniversities.filteredArrayUsingPredicate(predicate))
    }

    //MARK: - UITableView Data Source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView != self.searchDisplayController!.searchResultsTableView {
            self.arrFilteredUniversities = self.arrRawUniversities
        }
        
        return self.arrFilteredUniversities.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if tableView != self.searchDisplayController!.searchResultsTableView {
            self.arrFilteredUniversities = self.arrRawUniversities
        }
        
        let cell = self.tableView.dequeueReusableCellWithIdentifier("universityCell", forIndexPath: indexPath)

        let university = self.arrFilteredUniversities[indexPath.row]
        
        let mutableAttributedString = NSMutableAttributedString(string: university.universityName)
        let regexPattern = "(\(searchKey))"
        
        if searchKey == "" {
            cell.textLabel!.attributedText = mutableAttributedString
            return cell
        }
        
        do {
            let regex = try NSRegularExpression(pattern: regexPattern, options: .CaseInsensitive)
            let range = NSMakeRange(0, (university.universityName as String).characters.count)
            
            regex.enumerateMatchesInString(university.universityName, options: NSMatchingOptions.WithTransparentBounds, range: range) { (result, flags, stop) -> Void in
                let substringRange = result!.rangeAtIndex(1)
                mutableAttributedString.setAttributes([NSFontAttributeName : UIFont(name: "HelveticaNeue-Medium", size: 16.0)!], range: substringRange)
                
            }
            
            cell.textLabel!.attributedText = mutableAttributedString
        } catch {
            print("Something went wrong..")
        }

        return cell
    }
    
    //MARK - UISearchDisplayController Delegate
    func searchDisplayController(controller: UISearchDisplayController, shouldReloadTableForSearchString searchString: String?) -> Bool {
        self.filterTableViewWithKey(searchString!)
        return true
    }
    
    //MARK: - UITableView Delegate
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let university = self.arrFilteredUniversities[indexPath.row] as! University
        self.delegate!.didSelectUniversity(university)
        
        self.navigationController!.popViewControllerAnimated(true)
    }
}
