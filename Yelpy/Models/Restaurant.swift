//
//  Restaurant.swift
//  Yelpy
//
//  Created by Alexander Roman Montiel on 10/27/20.
//  Copyright © 2020 memo. All rights reserved.
//

import Foundation

class Restaurant {
    
    //properties
    var imageURL: URL?
    var url: URL?
    var name: String
    var mainCategory: String
    var phone: String
    var rating: Double
    var reviews: Int
    
    //constructor
    init(dict: [String: Any]) {
        imageURL = URL(string: dict["image_url"] as! String)
        name = dict["name"] as! String
        rating = dict["rating"] as! Double
        reviews = dict["review_count"] as! Int
        phone = dict["display_phone"] as! String
        url = URL(string: dict["url"] as! String)
        mainCategory = Restaurant.getMainCategory(dict: dict)
        
    }
    
    static func getMainCategory(dict: [String: Any]) -> String{
        let categories = dict["categories"] as! [[String: Any]]
        return categories[0]["title"] as! String
    }
}
