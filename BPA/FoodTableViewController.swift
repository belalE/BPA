//
//  FoodTableViewController.swift
//  BPA
//
//  Created by Belal Elsiesy on 12/4/18.
//  Copyright © 2018 Elsiesy Industries. All rights reserved.
//

import UIKit
import Firebase

class FoodTableViewController: UITableViewController {
    
    var sectionHeaders = ["Breakfast","Lunch","Dinner","Snacks"]
    var docRef : DocumentReference?
    var uid = ""
    var dateFormatter = DateFormatter()
    var quoteListener : ListenerRegistration!
    var breakfastFoods = [String]()
    var lunchFoods = [String]()
    var dinnerFoods = [String]()
    var snackFoods = [String]()
    var dateString : String?
    var food : [Array<Any>]?
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
         food = [breakfastFoods,lunchFoods,dinnerFoods,snackFoods]
        dateFormatter.dateFormat = "mm-dd-yyyy"
        dateString = dateFormatter.string(from: Date(timeIntervalSinceNow: 0.0))
        docRef = Firestore.firestore().document("users/\(uid)/food")
        
        
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return sectionHeaders.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return food![section].count
     
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        cell.textLabel?.text = food![indexPath.section][indexPath.row] as! String
        
        return cell
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionHeaders[section]
    }

    
    //MARK: Listener
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        quoteListener = docRef?.addSnapshotListener({ (docSnapshot, error) in
            guard let docSnapshot = docSnapshot, docSnapshot.exists else {return}
            let myData = docSnapshot.data()
            self.breakfastFoods = docSnapshot["Breakfast"] as! [String]
            self.lunchFoods = docSnapshot["Lunch"] as! [String]
            self.dinnerFoods = docSnapshot["Dinner"] as! [String]
            self.snackFoods = docSnapshot["Snack"] as! [String]
            self.tableView.reloadData()
            
        })
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        quoteListener.remove()
    }

}
