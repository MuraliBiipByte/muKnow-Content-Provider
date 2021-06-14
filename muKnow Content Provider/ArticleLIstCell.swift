//
//  ArticleLIstCell.swift
//  muKnow Content Provider
//
//  Created by Apple on 09/04/21.
//

import UIKit

class ArticleLIstCell: UITableViewCell {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var shortDescLbl: UILabel!
    @IBOutlet weak var countLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        
        
    }

    override func layoutSubviews() {
        
        
        countLbl.layer.masksToBounds = true
        print("Height " ,countLbl.frame.size.height)
        print("Weight " , countLbl.frame.size.width)
        countLbl.layer.cornerRadius = countLbl.frame.size.height/2
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
