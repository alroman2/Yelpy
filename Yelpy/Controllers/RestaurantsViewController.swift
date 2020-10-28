//
//  ViewController.swift
//  Yelpy
//
//  Created by Memo on 5/21/20.
//  Copyright © 2020 memo. All rights reserved.
//

import UIKit
import AlamofireImage

class RestaurantsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UISearchResultsUpdating, UIScrollViewDelegate {
   
    
    

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UITableView!
    
    // ––––– TODO: Build Restaurant Class
    
    // –––––– TODO: Update restaurants Array to an array of Restaurants
    var restaurantsArray: [Restaurant] = []
    var filteredData: [Restaurant]! = []
    var searchController: UISearchController!
    var isMoreDataLoading = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        getAPIData()
        filteredData = restaurantsArray
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        
        searchController.searchBar.sizeToFit()
        searchController.navigationItem.titleView = searchController.searchBar
        searchController.obscuresBackgroundDuringPresentation = false
        
        searchController.searchBar.sizeToFit()
        tableView.tableHeaderView = searchController.searchBar
       
        
        definesPresentationContext = true
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if(!isMoreDataLoading){
            //load additional results when user is scrolling down
            let scrollViewContentHeight = tableView.contentSize.height
            let scrollOffsetThreshold = scrollViewContentHeight - tableView.bounds.size.height
            //when user has scrolled past threshold, start data request
            if (scrollView.contentOffset.y > scrollOffsetThreshold && tableView.isDragging) {
                isMoreDataLoading = true
                //getAPIData()
            }
            
        }
    }
    
    
    // ––––– TODO: Update API to get an array of restaurant objects
    func getAPIData() {
        API.getRestaurants() { (restaurants) in
            guard let restaurants = restaurants else {
                return
            }
            self.restaurantsArray = restaurants

            self.tableView.reloadData()
        }
    }
    

    // Protocol Stubs
    // How many cells there will be
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if filteredData.isEmpty {
            return restaurantsArray.count
        } else {
            return filteredData.count
        }
    }
    

    // ––––– TODO: Configure cell using MVC
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Create Restaurant Cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantCell") as! RestaurantCell
        
        let restaurant: Restaurant
        
        if filteredData.isEmpty {
            restaurant = restaurantsArray[indexPath.row]
        }else{
            restaurant = filteredData[indexPath.row]
        }
         
       
        cell.r = restaurant
        
        return cell
    }
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text{
            filteredData = searchText.isEmpty ? restaurantsArray : restaurantsArray.filter({(r:Restaurant) -> Bool in
                return r.name.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
            })
            self.tableView.reloadData()
            
        }
        
    }
    
    // –––––– TODO: Override segue to pass the restaurant object to the DetailsViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //get cell that was tapped
        let cell = sender as! UITableViewCell
        
        //get indexPath of the cell that was tapped
        if let indexPath = tableView.indexPath(for: cell){
            //get the restaurant from the array
            let r = filteredData.isEmpty ? restaurantsArray[indexPath.row] : filteredData[indexPath.row]

            //declare the destination view controller
            let detailVC = segue.destination as! DetailsViewController
            //pass the restaurant object
            detailVC.r = r
        }
    }
    

}


