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
}
