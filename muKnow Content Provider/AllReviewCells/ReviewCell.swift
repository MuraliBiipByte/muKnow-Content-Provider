//
//  ReviewCell.swift
//  muKnow Content Provider
//
//  Created by Apple on 01/07/21.
//

import UIKit

class ReviewCell: UITableViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var floatRatingView: FloatRatingView!
    @IBOutlet weak var reviewLbl: UILabel!
    
    var delegate : AllReviewsVC?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
