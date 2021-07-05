//
//  AllReviewsVC.swift
//  muKnow Content Provider
//
//  Created by Apple on 01/07/21.
//

import UIKit

class AllReviewsVC: UIViewController,FloatRatingViewDelegate {

    @IBOutlet weak var allReviewsTV: UITableView!
    
    var trainerID = ""
    var articlesID : Int?
    
    var reviewDetailsArr = [AnyObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let lefticonButton = UIButton(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 35, height: 35)))
        lefticonButton.setBackgroundImage(UIImage(named: "muknowAppLogo"), for: .normal)
        //   btn1.addTarget(self, action: Selector("action1:"), forControlEvents: .TouchUpInside)
        
        
        let leftbarButton = UIBarButtonItem(customView: lefticonButton)
        navigationItem.leftBarButtonItem = leftbarButton
        // Do any additional setup after loading the view.
        allReviewsTV.register(UINib(nibName: "ReviewCell", bundle: nil), forCellReuseIdentifier: "ReviewCellID" )
        
        allReviewsTV.estimatedRowHeight = 44.0;
        allReviewsTV.rowHeight = UITableView.automaticDimension;
        
        
        allReviewsTV.delegate = self
        allReviewsTV.dataSource = self
        
        let loginResponse = fetchLoginResponse()
        self.trainerID = (loginResponse?.trainerId)!
        
        allReviewsTV.isHidden = true
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.getAllReviewsList()
    }
    func showAlert(message:String)
    {
        Message.shared.Alert(Title:APP_NAME, Message: message, TitleAlign: .normal, MessageAlign: .normal, Actions: [Message.AlertActionWithOutSelector(Title: "Ok")], Controller: self)
    }
    
    func getAllReviewsList()
    {
        self.view.StartLoading()
        ApiManager().postRequest(service: WebServices.REVIEWS, params: "\(articlesID!)") { (result, success) in
            self.view.StopLoading()
            
            
            if success == false
            {
                self.showAlert(message: result as! String)
                return
            }
            else
            {
                let response = result as! [String : Any]
                print("Review Response :",response)
                
                
                if (response["data"] as? NSDictionary) != nil {
                   let data = (response["data"] as? NSDictionary)
                    if (data!["response"] as? NSDictionary) != nil {
                        let resp = (data!["response"] as? NSDictionary)
                        //baseURL = "\(resp!["base_url"]!)"
                        
                        
                        if (resp!["data"] as? NSDictionary) != nil {
                            let data = (resp!["data"] as? NSDictionary)
                            
                            
                            self.reviewDetailsArr = data!["review_details"] as! [AnyObject]
                            
                            
                            if (self.reviewDetailsArr.count > 0)
                            {
                                self.allReviewsTV.reloadData()
                                self.allReviewsTV.isHidden = false
                                
                            }else{
                                self.allReviewsTV.isHidden = true
                            }
          
                        }
                    }
                }
            }
            
            
        }
    }
    
    @IBAction func back_Tapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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
extension AllReviewsVC : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviewDetailsArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewCellID", for: indexPath) as! ReviewCell
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor.clear
        cell.delegate = self
        
        
        
        let tmpDict = reviewDetailsArr[indexPath.row] as! NSDictionary
        //let tmpAny = tmpDict.value(forKey: "user_data") as! [AnyObject]
        
        
        //cell.nameLbl.text =  tmpDict.value(forKey: "full_name") as? String
        cell.reviewLbl.text =  tmpDict.value(forKey: "comment") as? String
        
        if let rating = (tmpDict["rate"] as? NSString)?.doubleValue {
          // totalfup is a Double here
            cell.floatRatingView.rating = rating
        }
        else {
          // dict["totalfup"] isn't a String
          // you can try to 'as? Double' here
            cell.floatRatingView.rating = tmpDict["rate"] as! Double
        }
        
        cell.floatRatingView.editable = false
        
        cell.floatRatingView.type = .wholeRatings
        cell.floatRatingView.delegate = self
        cell.floatRatingView.backgroundColor = UIColor.clear
        return cell
    }
    
    
}
