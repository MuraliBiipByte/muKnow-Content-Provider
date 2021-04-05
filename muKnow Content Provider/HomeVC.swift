//
//  HomeVC.swift
//  muKnow Content Provider
//
//  Created by Apple on 04/03/21.
//

import UIKit

class HomeVC: UIViewController {
    
    @IBOutlet weak var notificationBtn: UIButton!
    
    @IBOutlet var popularCollectionView: UICollectionView!
    @IBOutlet var popularviewHeight: NSLayoutConstraint!
    @IBOutlet var latestCollectionView: UICollectionView!
    @IBOutlet var latestViewHeight: NSLayoutConstraint!
    @IBOutlet var favouritesViewHeight: NSLayoutConstraint!
    @IBOutlet var favouriteCollectionView: UICollectionView!
    
    var latestCourses = [AnyObject]()
    var popularCourses = [AnyObject]()
    var favouriteCourses = [AnyObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.popularCollectionView.delegate = self
        self.popularCollectionView.dataSource = self

        self.navigationController?.setNavigationBarHidden(false, animated: true)
        let lefticonButton = UIButton(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 35, height: 35)))
        lefticonButton.setBackgroundImage(UIImage(named: "muknowAppLogo"), for: .normal)
        
        let leftbarButton = UIBarButtonItem(customView: lefticonButton)
        let righticonButton = UIButton(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 20, height: 20)))
        righticonButton.setBackgroundImage(UIImage(named: "searchIcon"), for: .normal)
        righticonButton.addTarget(self, action: #selector(self.goToSearchPage), for: UIControl.Event.touchUpInside)
        
        let rightbarButton = UIBarButtonItem(customView: righticonButton)
        
        navigationItem.leftBarButtonItem = leftbarButton
        navigationItem.rightBarButtonItem = rightbarButton
        
        
        
        self.popularviewHeight.constant = 0
        self.popularCollectionView.isHidden = true
        
        self.latestViewHeight.constant = 0
        self.latestCollectionView.isHidden = true
        
        self.favouritesViewHeight.constant = 0
        self.favouriteCollectionView.isHidden = true
        
//        self.favouritesView.isHidden = true
        
        getTrainerDashBoard()
        
    }
    @objc private func goToSearchPage() {
//        let searchVc = self.storyboard?.instantiateViewController(withIdentifier: "LGWSearchVCSBID") as! LGWSearchVC
//        self.navigationController?.pushViewController(searchVc, animated: true)
    }
            
    func getTrainerDashBoard() {
        //let params = ["token":"24"] as [String:Any]
        self.view.StartLoading()
        
        ApiManager().getRequest(service: WebServices.DASHBOARD, param: "24") { [self] (result, success) in
                        self.view.StopLoading()
            
                        if success == false
                        {
                            self.showAlert(message: result as! String)
                            return
                        }
                        else
                        {
                            let response = result as! [String : Any]
                            print("Dashboard Response :",response)
                            if (response["data"] as? NSDictionary) != nil {
                               let data = (response["data"] as? NSDictionary)
                                if (data!["response"] as? NSDictionary) != nil {
                                    let resp = (data!["response"] as? NSDictionary)
                                    if (resp!["data"] as? NSDictionary) != nil {
                                        let data = (resp!["data"] as? NSDictionary)
                                        popularCourses = data!["popular_articles"] as! [AnyObject]
                                        
                                        if (self.popularCourses.count > 0)
                                        {
                                            self.popularCollectionView.isHidden = false
                                            self.popularviewHeight.constant = 160
                                            self.popularCollectionView.reloadData()
                                        }
                                    }
                                }
                            }else{
                                
                            }
                        }
        }
//        ApiManager().getRequestWithParameters(service: WebServices.DASHBOARD, params: params) { (result, success) in
//            self.view.StopLoading()
//                        if success == false
//                        {
//                            self.showAlert(message: result as! String)
//                            return
//                        }
//                        else
//                        {
//                            let response = result as! [String : Any]
//                            print("Dashboard Response :",response)
//                        }
//
//        }
        
//        ApiManager().getRequest(service:WebServices.DASHBOARD)
//        { (result, success) in
//            self.view.StopLoading()
//
//            if success == false
//            {
//                self.showAlert(message: result as! String)
//                return
//            }
//            else
//            {
//                let response = result as! [String : Any]
//                print("Dashboard Response :",response)
//
//               /*
//                 self.featuredCourses = (response["data_feautred"] as? [AnyObject]) != nil  ?  (response["data_feautred"] as! [AnyObject]) : []
//
//
//                if (self.featuredCourses.count > 0)
//                {
//                    self.featuredCollectionView.isHidden = false
//                    self.featuredViewHeight.constant = 160
//                    self.featuredCollectionView.reloadData()
//                }
//
//
//                self.latestCourses = (response["data_latest"] as? [AnyObject]) != nil  ?  (response["data_latest"] as! [AnyObject]) : []
//
//                if (self.latestCourses.count > 0)
//                {
//                    self.latestCollectionView.isHidden = false
//                    self.latestViewHeight.constant = 160
//                    self.latestCollectionView.reloadData()
//                }
//
//                self.popularCourses = (response["data_popular"] as? [AnyObject]) != nil  ?  (response["data_popular"] as! [AnyObject]) : []
//
//                if (self.popularCourses.count > 0)
//                {
//                    self.popularCollectionView.isHidden = false
//                    self.popularviewHeight.constant = 160
//                    self.popularCollectionView.reloadData()
//                }
//
//                var favOriginalArr = NSDictionary()
//
//
//                if response["data_favourite"] != nil {
//
//
//                    self.favouritesArr = response["data_favourite"] as! NSDictionary
//
//
//
//
//                    favOriginalArr = self.favouritesArr["original"] as! NSDictionary
//
//
//                    self.favouriteCourses = (favOriginalArr["data"] as? [AnyObject]) != nil  ?  (favOriginalArr["data"] as! [AnyObject]) : []
//                    //
//                    print(self.favouriteCourses)
//                    //
//                    //
//                    if (self.favouriteCourses.count > 0)
//                    {
//                        self.favouriteCollectionView.isHidden = false
//                        self.favouritesView.isHidden = false
//                        self.favouritesViewHeight.constant = 215
//                        self.favouriteCollectionView.reloadData()
//                    }
//
//                } */
//
//
//
//
//
//
//
//            }
//        }
        
        
    }
    
    func showAlert(message:String)
      {
          Message.shared.Alert(Title:APP_NAME, Message: message, TitleAlign: .normal, MessageAlign: .normal, Actions: [Message.AlertActionWithOutSelector(Title: "Ok")], Controller: self)
      }
    
    @IBAction func notificationBtnTapped(_ sender: UIButton) {
        
        /* let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let courseViewController = storyboard.instantiateViewController(withIdentifier: "NotificationsViewController")
        self.navigationController?.pushViewController(courseViewController, animated: false) */
        
        
        let notificationVCObj = UIStoryboard.MainStoryBoard.NotificationVC()
        self.navigationController?.pushViewController(notificationVCObj!, animated: true)
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

extension HomeVC : UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
       {
           
           if collectionView == popularCollectionView {
               return popularCourses.count
           }else if collectionView == latestCollectionView{
               return latestCourses.count
           }else {
               return favouriteCourses.count
           }
       }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        
        let  cell = collectionView.dequeueReusableCell(withReuseIdentifier:
            "HomeCollectionViewCellID", for: indexPath) as! HomeCollectionViewCell
        
        if collectionView == popularCollectionView
        {
            
            cell.contentView.layer.cornerRadius = 8
            cell.contentView.layer.masksToBounds = true
            
         let imageURL =  "\(WebServices.BASE_URL)\(self.popularCourses[indexPath.row]["path"] as! String)".addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
         if (imageURL!.hasSuffix(".pdf")){
                cell.imgPopular.contentMode = .scaleAspectFit
                
            }else{
                cell.imgPopular.contentMode = .scaleAspectFill
            }
            
//            cell.imgPopular.sd_setImage(with: URL(string: image!), placeholderImage: UIImage(named: "PlaceholderImg"))
         
         cell.myLoader.isHidden = false
         cell.myLoader.startAnimating()
         cell.imgPopular.loadImageUsingCacheWithURLString(imageURL!, placeHolder: UIImage(named: "PlaceholderImg"), loader: cell.myLoader)
            
         cell.popularTagName.text = self.popularCourses[indexPath.row]["title"] as? String
            
          
         cell.popularPrice.text =  String(format: " $ %.2f", arguments: [Double("\(self.popularCourses[indexPath.row]["price"]! ?? "0")")!])
                
            if let isLearning = self.popularCourses[indexPath.row]["is_elearning"] as? Int {
                
                if isLearning == 0 {
                    cell.popularElearning.isHidden = true
                }else{
                    cell.popularElearning.isHidden = false
                }
            }else{
                cell.popularElearning.isHidden = true
            }
            
            
                      
                     
            if let sfcBooking = self.popularCourses[indexPath.row]["skills_future_credit_claimable"] as? Int {
                          if sfcBooking == 0 {
                               cell.popularSFC.isHidden = true
                          }
                          else{
                                cell.popularSFC.isHidden = false
                          }
                      }else{
                           cell.popularSFC.isHidden = true
                      }
                      
               
                      if let wscBooking = self.popularCourses[indexPath.row]["is_wsq"] as? Int {
                          if wscBooking == 0 {
                              cell.popularWSQ.isHidden = true
                          }
                          else {
                              cell.popularWSQ.isHidden = false
                          }
                      }else
                      {
                           cell.popularWSQ.isHidden = true
                      }
                  
            
        }
        
        return cell
    }
}
