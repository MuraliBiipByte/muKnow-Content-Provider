//
//  HomeCollectionViewCell.swift
//  muKnow Content Provider
//
//  Created by Apple on 04/04/21.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var myLoader: UIActivityIndicatorView!
    
    //Objects For popular courses
    @IBOutlet weak internal var imgPopular: UIImageView!
    @IBOutlet weak internal var popularTagName: UILabel!
    
    @IBOutlet var popularPrice: UILabel!
    @IBOutlet var popularSFC: UILabel!
      @IBOutlet var popularWSQ: UILabel!
    @IBOutlet var popularElearning: UILabel!
    
    
    //Objects For latest courses
    @IBOutlet weak internal var imglatestCourses: UIImageView!
    @IBOutlet weak internal var latestCourseTagName: UILabel!
    
    @IBOutlet var latestPrice: UILabel!
    @IBOutlet var latestSFC: UILabel!
    @IBOutlet var latestWSQ: UILabel!
    @IBOutlet var latestElearning: UILabel!
    
    
    //Objects For Favourite courses
 @IBOutlet var favouritesImg: UIImageView!
 @IBOutlet var favouritesPrice: UILabel!
 @IBOutlet var favouriteTitle: UILabel!
    
    
}
