//
//  FirstCell.swift
//  muKnow Content Provider
//
//  Created by Apple on 27/05/21.
//

import UIKit

protocol FirstCellDelegate : class {
    
    func openWriteReviewVC(articleId : Int)
    func openRatingVC(articleId : Int)
}

class FirstCell: UITableViewCell {

    var delegate: FirstCellDelegate?
    
    @IBOutlet var articleNameLbl: UILabel!
    @IBOutlet var authorName: UILabel!
    
    @IBOutlet var ratingView: FloatRatingView!

    var articleId : Int?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func ratingBtnTapped(_ sender: UIButton) {
        self.delegate?.openRatingVC(articleId: self.articleId!)
    }
    
    @IBAction func writeReviewBtnTapped(_ sender: UIButton) {
        self.delegate?.openWriteReviewVC(articleId: self.articleId!)
    }
}
