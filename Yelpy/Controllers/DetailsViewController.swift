//
//  DetailsViewController.swift
//  Yelpy
//
//  Created by Alexander Roman Montiel on 10/27/20.
//  Copyright © 2020 memo. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var restaurantTypeLabel: UILabel!
    
    @IBOutlet weak var restaurantImageView: UIImageView!
    @IBOutlet weak var starsImageView: UIImageView!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var reviewsNumberLabel: UILabel!
    
    var r: Restaurant!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        restaurantNameLabel.text = r.name
        restaurantTypeLabel.text = r.mainCategory
        restaurantImageView.af.setImage(withURL: r.imageURL!)
        starsImageView.image = Stars.dict[r.rating]!
        phoneNumberLabel.text = r.phone
        reviewsNumberLabel.text = String(r.reviews)
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
