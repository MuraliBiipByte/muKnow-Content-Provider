//
//  DescriptionCell.swift
//  muKnow Content Provider
//
//  Created by Apple on 30/05/21.
//

import UIKit



protocol DescriptionCellDelegate : class {
//    func openFile(selectedImg:UIImage,fileUrl:URL,alteredFileName:String)
//    func downloadFile(url : URL,fileName : String,destinationUrl : URL,index : Int)
//    func didFileNotFound(message : String)
    
    func refreshSecondCell()
}

class DescriptionCell: UITableViewCell {

    @IBOutlet weak var quizLbl: UILabel!
    @IBOutlet weak var quizLblheightCons: NSLayoutConstraint!
    @IBOutlet weak var quizLblTopBorder: UILabel!
    @IBOutlet weak var quizLblBottomBorder: UILabel!
    
    @IBOutlet weak var descriptionLbl: UILabel!
    var delegate: DescriptionCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func doDefaultUI(){
        self.delegate?.refreshSecondCell()
    }
    
}
