//
//  AddFoodViewController.swift
//  BPA
//
//  Created by Belal Elsiesy on 12/8/18.
//  Copyright © 2018 Elsiesy Industries. All rights reserved.
//

import UIKit

class SearchFoodViewController: UIViewController, UITableViewDelegate,UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var foodArray = [Food]()
    var foodClicked : Food?
    
    //MARK: Setting Up TableView and SearchBar
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "foodCell")
        cell?.textLabel?.text = foodArray[indexPath.row].name
        cell?.detailTextLabel?.text = foodArray[indexPath.row].brandName
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        foodClicked = foodArray[indexPath.row]
        performSegue(withIdentifier: "addFood", sender: self)
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            foodArray = []
        } else {
            foodArray = foodQuery(phrase: searchText)
        }
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is AddFoodViewController {
            let vc = segue.destination as? AddFoodViewController
            vc?.food = foodClicked
        }
    }
    
    //MARK: Requesting Food Info from Nutritionix API
    func getFoodInfo(id:Int) -> Food? {
        var food: Food?
        let url = "https://api.nutritionix.com/v1_1/item?id=\(id)&appId=896ed69d&appKey=25d4aef3cedd110cda12a08b1a5adf87"
        let request = URLRequest(url: URL(string: url)!)
        let task = URLSession.shared.dataTask(with: request) { (data:Data?, response:URLResponse?, error: Error?) in
            if let data = data {
                
                do{
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] {
                        food = try Food.init(json: json)
                    }
                } catch {
                    print(error.localizedDescription)
                }
            } else {
                print(response)
                print(error)
            }
            
        }
        return food
    }
    
    func foodQuery(phrase : String) -> [Food] {
        var foodsArray = [Food]()
        let url = URL(string: "https://api.nutritionix.com/v1_1/search/\(phrase)?results=0%3A20&cal_min=0&cal_max=50000&fields=item_name%2Cbrand_name%2Citem_id%2Cbrand_id&appId=896ed69d&appKey=25d4aef3cedd110cda12a08b1a5adf87")!
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
        if let data = data {
            do{
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    if let hits = json["hits"] as? [[String:Any]] {
                        for hit in hits {
                            foodsArray.append(self.getFoodInfo(id: hit["_id"] as! Int)!)
                        }
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
            }
        }
        return foodsArray
    }
    
}
