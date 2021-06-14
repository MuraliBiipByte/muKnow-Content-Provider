//
//  QuizQandACell.swift
//  muKnow Content Provider
//
//  Created by Apple on 02/06/21.
//

import UIKit

protocol QuizQandACellDelegate : class {
    func submitTapped(index : Int)
    func refreshSecondCell()
}


class QuizQandACell: UITableViewCell {

    var index: Int = 0
    var section: Int = 0
    
    var delegate: QuizQandACellDelegate?
    @IBOutlet weak var quizQandAContainer: UIView!
    @IBOutlet weak var questionLbl: UILabel!
    
    @IBOutlet weak var answerImgView: UIImageView!
    
    
    @IBOutlet weak var option1Btn: UIButton!
    @IBOutlet weak var option2Btn: UIButton!
    @IBOutlet weak var option3Btn: UIButton!
    @IBOutlet weak var option4Btn: UIButton!
    
    @IBOutlet weak var option1Lbl: UILabel!
    @IBOutlet weak var option2Lbl: UILabel!
    @IBOutlet weak var option3Lbl: UILabel!
    @IBOutlet weak var option4Lbl: UILabel!
    
    
    @IBOutlet weak var submitBtn: UIButton!
    
    @IBOutlet weak var correctAnswerLbl: UILabel!
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
    @IBAction func submitBtnTapped(_ sender: UIButton) {
        self.delegate?.submitTapped(index: sender.tag)
    } 
}
