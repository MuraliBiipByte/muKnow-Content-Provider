//
//  HomeVC.swift
//  muKnow Content Provider
//
//  Created by Apple on 04/03/21.
//

import UIKit
import YouTubePlayer
class HomeVC: UIViewController {
    
    
    
    @IBOutlet var popularCollectionView: UICollectionView!
    @IBOutlet var popularviewHeight: NSLayoutConstraint!
    @IBOutlet var latestCollectionView: UICollectionView!
    @IBOutlet var latestViewHeight: NSLayoutConstraint!
    @IBOutlet var favouritesViewHeight: NSLayoutConstraint!
    @IBOutlet var favouriteCollectionView: UICollectionView!
    
    @IBOutlet weak var favouritesView: UIView!
    
    var popularCoursesFromResponse = [AnyObject]()
    var popularCourses = [AnyObject]()
    var latestCourses = [AnyObject]()
    var favouriteCourses = [AnyObject]()
    
    
    var baseURL = "" //: String? = nil
    
    var trainerID = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.popularCollectionView.delegate = self
        self.popularCollectionView.dataSource = self
        
        self.latestCollectionView.delegate = self
        self.latestCollectionView.dataSource = self
        
        self.favouriteCollectionView.delegate = self
        self.favouriteCollectionView.dataSource = self

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
        self.favouritesView.isHidden = true
        
        
        
        let loginResponse = fetchLoginResponse()
        self.trainerID = (loginResponse?.trainerId)!
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getTrainerDashBoard()
    }
    
    @objc private func goToSearchPage() {
//        let searchVc = self.storyboard?.instantiateViewController(withIdentifier: "LGWSearchVCSBID") as! LGWSearchVC
//        self.navigationController?.pushViewController(searchVc, animated: true)
    }
            
    func getTrainerDashBoard() {
        //let params = ["token":"24"] as [String:Any]
        self.view.StartLoading()
        
        
        ApiManager().postRequest(service: WebServices.DASHBOARD, params: trainerID) { [self] (result, success) in
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
                        baseURL = "\(resp!["base_url"]!)"
                        
                        
                        if (resp!["data"] as? NSDictionary) != nil {
                            let data = (resp!["data"] as? NSDictionary)
                            
                            
                            
                            popularCourses = data!["popular_articles"] as! [AnyObject]
                            if (self.popularCourses.count > 0)
                            {
                                if self.popularCourses.count == 1 {
                                    if self.popularCourses[0]["title"] != nil {
                                        self.popularCollectionView.isHidden = false
                                        self.popularviewHeight.constant = 160
                                        self.popularCollectionView.reloadData()
                                    }
                                }else{
                                    self.popularCollectionView.isHidden = false
                                    self.popularviewHeight.constant = 160
                                    self.popularCollectionView.reloadData()
                                }
                            }
                            
                            //popularCourses[0] as![AnyObject]
                            
                            /*
                             popularCoursesFromResponse = data!["popular_articles"] as! [AnyObject]
                            if (self.popularCoursesFromResponse.count > 0)
                            {
                                if self.popularCoursesFromResponse.count == 1{
                                    
                                    if self.popularCoursesFromResponse[0] is [AnyObject] {
                                        
                                        self.popularCourses = self.popularCoursesFromResponse[0] as! [AnyObject]
                                        
                                        self.popularCollectionView.isHidden = false
                                        self.popularviewHeight.constant = 160
                                        self.popularCollectionView.reloadData()
                                    }else{
                                        
                                    }
                                    
//                                                let tmpPopularCourses = self.popularCourses[0] as! [AnyObject]
//                                                if tmpPopularCourses.count > 0 {
//                                                    self.popularCollectionView.isHidden = false
//                                                    self.popularviewHeight.constant = 160
//                                                    self.popularCollectionView.reloadData()
//                                                }
                                    
                                    if self.popularCoursesFromResponse[0]["title"] != nil{
                                        self.popularCollectionView.isHidden = false
                                        self.popularviewHeight.constant = 160
                                        self.popularCollectionView.reloadData()
                                    }
                                    else{
                                        print("No title for Popular COurses...")
                                    }
                                }else{
                                    self.popularCollectionView.isHidden = false
                                    self.popularviewHeight.constant = 160
                                    self.popularCollectionView.reloadData()
                                }

                            } */
                            
                            
                            
                            latestCourses = data!["latest_articles"] as! [AnyObject]
                            if (self.latestCourses.count > 0)
                            {
                                if self.latestCourses.count == 1 {
                                    if self.latestCourses[0]["title"] != nil {
                                        self.latestCollectionView.isHidden = false
                                        self.latestViewHeight.constant = 160
                                        self.latestCollectionView.reloadData()
                                    }
                                }else{
                                    self.latestCollectionView.isHidden = false
                                    self.latestViewHeight.constant = 160
                                    self.latestCollectionView.reloadData()
                                }
                            }
                            
                            
                            favouriteCourses = data!["favourite_articles"] as! [AnyObject]
                            
                            /*
                            self.favouriteCourses = (favOriginalArr["data"] as? [AnyObject]) != nil  ?  (favOriginalArr["data"] as! [AnyObject]) : []
                            print(self.favouriteCourses)  */
                            
                            if (self.favouriteCourses.count > 0)
                            {
                                if self.favouriteCourses.count == 1 {
                                    if self.favouriteCourses[0]["title"] != nil{
                                        self.favouriteCollectionView.isHidden = false
                                        self.favouritesView.isHidden = false
                                        self.favouritesViewHeight.constant = 215
                                        self.favouriteCollectionView.reloadData()
                                    }
                                }else{
                                    self.favouriteCollectionView.isHidden = false
                                    self.favouritesView.isHidden = false
                                    self.favouritesViewHeight.constant = 215
                                    self.favouriteCollectionView.reloadData()
                                }
                            }
                        }
                    }
                }else{
                    
                }
            }

        }
        
//        ApiManager().getRequest(service: WebServices.DASHBOARD, param: self.trainerID) { [self] (result, success) in
//                        self.view.StopLoading()
//            
//                        if success == false
//                        {
//                            self.showAlert(message: result as! String)
//                            return
//                        }
//                        else
//                        {
//                            let response = result as! [String : Any]
//                            print("Dashboard Response :",response)
//                            if (response["data"] as? NSDictionary) != nil {
//                               let data = (response["data"] as? NSDictionary)
//                                if (data!["response"] as? NSDictionary) != nil {
//                                    let resp = (data!["response"] as? NSDictionary)
//                                    baseURL = "\(resp!["base_url"]!)"
//                                    
//                                    
//                                    if (resp!["data"] as? NSDictionary) != nil {
//                                        let data = (resp!["data"] as? NSDictionary)
//                                        popularCoursesFromResponse = data!["popular_articles"] as! [AnyObject]
//                                        
//                                        
//                                        //popularCourses[0] as![AnyObject]
//                                        
//                                        if (self.popularCoursesFromResponse.count > 0)
//                                        {
//                                            if self.popularCoursesFromResponse.count == 1{
//                                                
//                                                if self.popularCoursesFromResponse[0] is [AnyObject] {
//                                                    
//                                                    self.popularCourses = self.popularCoursesFromResponse[0] as! [AnyObject]
//                                                    
//                                                    self.popularCollectionView.isHidden = false
//                                                    self.popularviewHeight.constant = 160
//                                                    self.popularCollectionView.reloadData()
//                                                }else{
//                                                    
//                                                }
//                                                
////                                                let tmpPopularCourses = self.popularCourses[0] as! [AnyObject]
////                                                if tmpPopularCourses.count > 0 {
////                                                    self.popularCollectionView.isHidden = false
////                                                    self.popularviewHeight.constant = 160
////                                                    self.popularCollectionView.reloadData()
////                                                }
//                                                
//                                                if self.popularCoursesFromResponse[0]["title"] != nil{
//                                                    self.popularCollectionView.isHidden = false
//                                                    self.popularviewHeight.constant = 160
//                                                    self.popularCollectionView.reloadData()
//                                                }
//                                                else{
//                                                    print("No title for Popular COurses...")
//                                                }
//                                            }else{
//                                                self.popularCollectionView.isHidden = false
//                                                self.popularviewHeight.constant = 160
//                                                self.popularCollectionView.reloadData()
//                                            }
//
//                                        }
//                                        
//                                        
//                                        
//                                        latestCourses = data!["latest_articles"] as! [AnyObject]
//                                        if (self.latestCourses.count > 0)
//                                        {
//                                            if self.latestCourses.count == 1 {
//                                                if self.latestCourses[0]["title"] != nil {
//                                                    self.latestCollectionView.isHidden = false
//                                                    self.latestViewHeight.constant = 160
//                                                    self.latestCollectionView.reloadData()
//                                                }
//                                            }else{
//                                                self.latestCollectionView.isHidden = false
//                                                self.latestViewHeight.constant = 160
//                                                self.latestCollectionView.reloadData()
//                                            }
//                                        }
//                                        
//                                        
//                                        favouriteCourses = data!["favourite_articles"] as! [AnyObject]
//                                        
//                                        /*
//                                        self.favouriteCourses = (favOriginalArr["data"] as? [AnyObject]) != nil  ?  (favOriginalArr["data"] as! [AnyObject]) : []
//                                        print(self.favouriteCourses)  */
//                                        
//                                        if (self.favouriteCourses.count > 0)
//                                        {
//                                            if self.favouriteCourses.count == 1 {
//                                                if self.favouriteCourses[0]["title"] != nil{
//                                                    self.favouriteCollectionView.isHidden = false
//                                                    self.favouritesView.isHidden = false
//                                                    self.favouritesViewHeight.constant = 215
//                                                    self.favouriteCollectionView.reloadData()
//                                                }
//                                            }else{
//                                                self.favouriteCollectionView.isHidden = false
//                                                self.favouritesView.isHidden = false
//                                                self.favouritesViewHeight.constant = 215
//                                                self.favouriteCollectionView.reloadData()
//                                            }
//                                        }
//                                    }
//                                }
//                            }else{
//                                
//                            }
//                        }
//        }
    }
    
    func showAlert(message:String)
      {
          Message.shared.Alert(Title:APP_NAME, Message: message, TitleAlign: .normal, MessageAlign: .normal, Actions: [Message.AlertActionWithOutSelector(Title: "Ok")], Controller: self)
      }
    
    @IBOutlet weak var homeBtn: UIButton!
    @IBOutlet weak var articleListBtn: UIButton!
    @IBOutlet weak var notificationBtn: UIButton!
    @IBOutlet weak var profileBtn: UIButton!
    
    @IBAction func articleListBtnTapped(_ sender: UIButton) {
        let articleListVCObj = UIStoryboard.MainStoryBoard.ArticleListVC()
        self.navigationController?.pushViewController(articleListVCObj!, animated: false)
    }
    
    @IBAction func notificationBtnTapped(_ sender: UIButton) {
        
        /* let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let courseViewController = storyboard.instantiateViewController(withIdentifier: "NotificationsViewController")
        self.navigationController?.pushViewController(courseViewController, animated: false) */
        
        
        let notificationVCObj = UIStoryboard.MainStoryBoard.NotificationVC()
        self.navigationController?.pushViewController(notificationVCObj!, animated: false)
    }

   
    @IBAction func profileBtnTapped(_ sender: UIButton) {
        /*
        let profileVCObj = UIStoryboard.MainStoryBoard.ProfileVC()
        self.navigationController?.pushViewController(profileVCObj!, animated: false) */
        
        let myAccountVCObj = UIStoryboard.MainStoryBoard.MyAccountVC()
        self.navigationController?.pushViewController(myAccountVCObj!, animated: false)
    }
    
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
        
        
        
        cell.contentView.layer.cornerRadius = 8
        cell.contentView.layer.masksToBounds = true
        
        if collectionView == popularCollectionView
        {
            cell.popularElearning.isHidden = true
            cell.popularSFC.isHidden = true
            cell.popularWSQ.isHidden = true
            cell.popularPrice.isHidden = true
            
            var theImgURL : String? = ""
            
            if self.popularCourses[indexPath.row].count > 0 {
                
                let fileType = self.popularCourses[indexPath.row]["file_type"] as? String
                if fileType == "2"{
                    if (self.popularCourses[indexPath.row]["image1"]) is NSNull {
                        if (self.popularCourses[indexPath.row]["image2"]) is NSNull {
                            if (self.popularCourses[indexPath.row]["image3"]) is NSNull {
                                theImgURL = "No Image URL"
                                cell.myLoader.isHidden = true
                            }else{
                                theImgURL = self.baseURL + ((self.popularCourses[indexPath.row]["image3"])! as! String)
                            }
                        }else{
                            theImgURL = self.baseURL + ((self.popularCourses[indexPath.row]["image2"])! as! String)
                        }
                    }else{
                        theImgURL = self.baseURL + ((self.popularCourses[indexPath.row]["image1"])! as! String)
                    }
                    
                    cell.imgPopular.contentMode = .scaleAspectFill
                     cell.myLoader.isHidden = false
                     cell.myLoader.startAnimating()
                     theImgURL = theImgURL?.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
                     cell.imgPopular.loadImageUsingCacheWithURLString(theImgURL!, placeHolder: UIImage(named: "muknowAppLogo"), loader: cell.myLoader)
                }else if fileType == "3"{
                    //let videoThumb = self.popularCourses[indexPath.row]["video_thumb"] as? String // video_thumb
                    theImgURL = self.baseURL + ((self.popularCourses[indexPath.row]["video_thumb"])! as! String)
                    if theImgURL == nil{
                        print("No URL for video Image")
                        cell.myLoader.isHidden = true
                    }else{
                        cell.imgPopular.contentMode = .scaleAspectFill
                         cell.myLoader.isHidden = false
                         cell.myLoader.startAnimating()
                         theImgURL = theImgURL?.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
                         cell.imgPopular.loadImageUsingCacheWithURLString(theImgURL!, placeHolder: UIImage(named: "muknowAppLogo"), loader: cell.myLoader)
                    }
                }
                else if fileType == "4"{
                    let thumbnailStr = self.popularCourses[indexPath.row]["url_link"] as? String
                    if (thumbnailStr == nil){
                        print("No url for youtube image...")
                        cell.myLoader.isHidden = true
                    }else{
                        
                        /*
                        let thumbnailStr = "\(dict.value(forKey: "link")!)"
                        let theUrl = URL.init(string: thumbnailStr)!
                        
                        let vid = YouTubePlayer.videoIDFromYouTubeURL(theUrl)
                        let youtubeImgStr = "https://img.youtube.com/vi/" + vid! + "/1.jpg"
                        let youtubeImgURL = URL.init(string: youtubeImgStr)
                        
                        
                        cell.articleImage.sd_setImage(with: youtubeImgURL, placeholderImage: UIImage(named: "ic_placeholder_articles_item.png")) { (img, err, cacheType, url) in
                            print("Youtube thumbnail img generated...")
                        } */
                        
                        let theUrl = URL.init(string: thumbnailStr!)!
                        let vid = YouTubePlayer.videoIDFromYouTubeURL(theUrl)
                        let youtubeImgStr = "https://img.youtube.com/vi/" + vid! + "/1.jpg"
                        let youtubeImgURL = URL.init(string: youtubeImgStr)
                        
                        cell.imgPopular.sd_setImage(with: youtubeImgURL, placeholderImage: UIImage(named: "muknowAppLogo")) { (img, err, cacheType, url) in
                            print("Youtube thumbnail img generated...")
                        }
                    }
                }
                else if  (fileType == "5" || fileType == "6") {
                    if (self.popularCourses[indexPath.row]["file_thumb"]) is NSNull {
                        print("No image for pdf/ppt from backend...")
                        cell.myLoader.isHidden = true
                    }else{
                        let pdfImage = self.popularCourses[indexPath.row]["file_thumb"] as? String
                        theImgURL = self.baseURL + pdfImage!
                    }
                    
                    cell.imgPopular.contentMode = .scaleAspectFill
                     cell.myLoader.isHidden = false
                     cell.myLoader.startAnimating()
                     theImgURL = theImgURL?.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
                     cell.imgPopular.loadImageUsingCacheWithURLString(theImgURL!, placeHolder: UIImage(named: "muknowAppLogo"), loader: cell.myLoader)
                }
               
            /*
             if (theImgURL!.hasSuffix(".pdf")){
                    cell.imgPopular.contentMode = .scaleAspectFit
                    
            }else{
                    cell.imgPopular.contentMode = .scaleAspectFill
            }*/
                
    //            cell.imgPopular.sd_setImage(with: URL(string: image!), placeholderImage: UIImage(named: "PlaceholderImg"))
             
           
                cell.imgPopular.contentMode = .scaleAspectFill
                cell.popularTagName.text = self.popularCourses[indexPath.row]["title"] as? String
            }else{
                print("0 data in PopularCourses Array....")
            }
            
            
            
        
         
            
        }else if collectionView == latestCollectionView {
            
            cell.latestElearning.isHidden = true
            cell.latestSFC.isHidden = true
            cell.latestWSQ.isHidden = true
            cell.latestPrice.isHidden = true
            
            //let fileType =  self.Dict["file_type"] as? String
            
            var theImgURL : String? = nil
            
            if self.latestCourses[indexPath.row].count > 0 {
                
                
                let fileType = self.latestCourses[indexPath.row]["file_type"] as? String
                if fileType == "2"{
                    if (self.latestCourses[indexPath.row]["image1"]) is NSNull {
                        if (self.latestCourses[indexPath.row]["image2"]) is NSNull {
                            if (self.latestCourses[indexPath.row]["image3"]) is NSNull {
                                //theImgURL = "No Image URL"
                            }else{
                                theImgURL = self.baseURL + ((self.latestCourses[indexPath.row]["image3"])! as! String)
                            }
                        }else{
                            theImgURL = self.baseURL + ((self.latestCourses[indexPath.row]["image2"])! as! String)
                        }
                    }else{
                        theImgURL = self.baseURL + ((self.latestCourses[indexPath.row]["image1"])! as! String)
                    }

                    if theImgURL != nil {
                        cell.myLoader.isHidden = false
                        cell.myLoader.startAnimating()
                        theImgURL = theImgURL?.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
                        cell.imglatestCourses.loadImageUsingCacheWithURLString(theImgURL!, placeHolder: UIImage(named: "PlaceholderImg"), loader: cell.myLoader)
                    }else{
                        cell.myLoader.isHidden = true
                        cell.imglatestCourses.image = UIImage(named: "muknowAppLogo")
                        cell.imglatestCourses.contentMode = .scaleAspectFill
                    }


                }
                else if fileType == "3"{
                    //let videoThumb = self.popularCourses[indexPath.row]["video_thumb"] as? String // video_thumb
                    theImgURL = self.baseURL + ((self.latestCourses[indexPath.row]["video_thumb"])! as! String)
                    if theImgURL == nil{
                        print("No URL for video Image")
                        cell.myLoader.isHidden = true
                    }else{
                        cell.imglatestCourses.contentMode = .scaleAspectFill
                         cell.myLoader.isHidden = false
                         cell.myLoader.startAnimating()
                         theImgURL = theImgURL?.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
                         cell.imglatestCourses.loadImageUsingCacheWithURLString(theImgURL!, placeHolder: UIImage(named: "muknowAppLogo"), loader: cell.myLoader)
                    }
                }
                else if fileType == "4"{
                    let thumbnailStr = self.latestCourses[indexPath.row]["url_link"] as? String
                    if (thumbnailStr == nil){
                        print("No url for youtube image...")
                    }else{
                        
                        /*
                        let thumbnailStr = "\(dict.value(forKey: "link")!)"
                        let theUrl = URL.init(string: thumbnailStr)!
                        
                        let vid = YouTubePlayer.videoIDFromYouTubeURL(theUrl)
                        let youtubeImgStr = "https://img.youtube.com/vi/" + vid! + "/1.jpg"
                        let youtubeImgURL = URL.init(string: youtubeImgStr)
                        
                        
                        cell.articleImage.sd_setImage(with: youtubeImgURL, placeholderImage: UIImage(named: "ic_placeholder_articles_item.png")) { (img, err, cacheType, url) in
                            print("Youtube thumbnail img generated...")
                        } */
                        
                        let theUrl = URL.init(string: thumbnailStr!)!
                        let vid = YouTubePlayer.videoIDFromYouTubeURL(theUrl)
                        let youtubeImgStr = "https://img.youtube.com/vi/" + vid! + "/1.jpg"
                        let youtubeImgURL = URL.init(string: youtubeImgStr)
                        
                        cell.imglatestCourses.sd_setImage(with: youtubeImgURL, placeholderImage: UIImage(named: "muknowAppLogo")) { (img, err, cacheType, url) in
                            print("Youtube thumbnail img generated...")
                        }
                    }
                }
                else if (fileType == "5" || fileType == "6" ){
                    if (self.latestCourses[indexPath.row]["file_thumb"]) is NSNull {
                        print("No image for pdf/ppt from backend...")
                    }else{
                        let pdfImage = self.latestCourses[indexPath.row]["file_thumb"] as? String
                        theImgURL = self.baseURL + pdfImage!
                    }
                      
                    if theImgURL != nil {
                        cell.myLoader.isHidden = false
                        cell.myLoader.startAnimating()
                        theImgURL = theImgURL?.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
                        cell.imglatestCourses.loadImageUsingCacheWithURLString(theImgURL!, placeHolder: UIImage(named: "muknowAppLogo"), loader: cell.myLoader)
                    }else{
                        cell.myLoader.isHidden = true
                        cell.imglatestCourses.image = UIImage(named: "muknowAppLogo")
                        cell.imglatestCourses.contentMode = .scaleAspectFill
                    }

                    
                }


                
    //            cell.imgPopular.sd_setImage(with: URL(string: image!), placeholderImage: UIImage(named: "PlaceholderImg"))
             
             
                
                cell.imglatestCourses.contentMode = .scaleAspectFill
             cell.latestCourseTagName.text = self.latestCourses[indexPath.row]["title"] as? String
            }
            
        }else{
            
            cell.favouritesPrice.isHidden = true
            
            var theImgURL : String? = nil
            
            if self.favouriteCourses[indexPath.row].count > 0 {
                
                let fileType = self.favouriteCourses[indexPath.row]["file_type"] as? String
                if fileType == "2" {
                    if (self.favouriteCourses[indexPath.row]["image1"]) is NSNull {
                        if (self.favouriteCourses[indexPath.row]["image2"]) is NSNull {
                            if (self.favouriteCourses[indexPath.row]["image3"]) is NSNull {
                                //theImgURL = "No Image URL"
                            }else{
                                theImgURL = self.baseURL + ((self.favouriteCourses[indexPath.row]["image3"])! as! String)
                            }
                        }else{
                            theImgURL = self.baseURL + ((self.favouriteCourses[indexPath.row]["image2"])! as! String)
                        }
                    }else{
                        theImgURL = self.baseURL + ((self.favouriteCourses[indexPath.row]["image1"])! as! String)
                    }
                    if theImgURL != nil {
                        cell.myLoader.isHidden = false
                        cell.myLoader.startAnimating()
                        theImgURL = theImgURL?.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
                        cell.self.favouritesImg.loadImageUsingCacheWithURLString(theImgURL!, placeHolder: UIImage(named: "PlaceholderImg"), loader: cell.myLoader)
                    }else{
                        cell.myLoader.isHidden = true
                        cell.self.favouritesImg.image = UIImage(named: "muknowAppLogo")
                        cell.self.favouritesImg.contentMode = .scaleAspectFill
                    }

                }else if fileType == "3"{
                    //let videoThumb = self.popularCourses[indexPath.row]["video_thumb"] as? String // video_thumb
                    theImgURL = self.baseURL + ((self.favouriteCourses[indexPath.row]["video_thumb"])! as! String)
                    if theImgURL == nil{
                        print("No URL for video Image")
                        cell.myLoader.isHidden = true
                    }else{
                        cell.favouritesImg.contentMode = .scaleAspectFill
                         cell.myLoader.isHidden = false
                         cell.myLoader.startAnimating()
                         theImgURL = theImgURL?.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
                         cell.favouritesImg.loadImageUsingCacheWithURLString(theImgURL!, placeHolder: UIImage(named: "muknowAppLogo"), loader: cell.myLoader)
                    }
                }
                
                else if fileType == "4"{
                    let thumbnailStr = self.latestCourses[indexPath.row]["url_link"] as? String
                    if (thumbnailStr == nil){
                        print("No url for youtube image...")
                    }else{
                        
                        /*
                        let thumbnailStr = "\(dict.value(forKey: "link")!)"
                        let theUrl = URL.init(string: thumbnailStr)!
                        
                        let vid = YouTubePlayer.videoIDFromYouTubeURL(theUrl)
                        let youtubeImgStr = "https://img.youtube.com/vi/" + vid! + "/1.jpg"
                        let youtubeImgURL = URL.init(string: youtubeImgStr)
                        
                        
                        cell.articleImage.sd_setImage(with: youtubeImgURL, placeholderImage: UIImage(named: "ic_placeholder_articles_item.png")) { (img, err, cacheType, url) in
                            print("Youtube thumbnail img generated...")
                        } */
                        
                        let theUrl = URL.init(string: thumbnailStr!)!
                        let vid = YouTubePlayer.videoIDFromYouTubeURL(theUrl)
                        let youtubeImgStr = "https://img.youtube.com/vi/" + vid! + "/1.jpg"
                        let youtubeImgURL = URL.init(string: youtubeImgStr)
                        
                        cell.favouritesImg.sd_setImage(with: youtubeImgURL, placeholderImage: UIImage(named: "muknowAppLogo")) { (img, err, cacheType, url) in
                            print("Youtube thumbnail img generated...")
                        }
                    }
                }
                else if  (fileType == "5" || fileType == "6" ){
                    if (self.favouriteCourses[indexPath.row]["file_thumb"]) is NSNull {
                        print("No image for pdf/ppt from backend...")
                    }else{
                        let pdfImage = self.favouriteCourses[indexPath.row]["file_thumb"] as? String
                        theImgURL = self.baseURL + pdfImage!
                    }
                }
                
                cell.favouritesImg.contentMode = .scaleAspectFill
                if theImgURL != nil {
                    /*if (theImgURL!.hasSuffix(".pdf")){
                           cell.favouritesImg.contentMode = .scaleAspectFit
                           
                   }else{
                           cell.favouritesImg.contentMode = .scaleAspectFill
                   }*/
                    
                    cell.myLoader.isHidden = false
                    cell.myLoader.startAnimating()
                    theImgURL = theImgURL?.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
                    cell.favouritesImg.loadImageUsingCacheWithURLString(theImgURL!, placeHolder: UIImage(named: "muknowAppLogo"), loader: cell.myLoader)
                }else{
                    cell.myLoader.isHidden = true
                    cell.favouritesImg.image = UIImage(named: "muknowAppLogo")
                    cell.favouritesImg.contentMode = .scaleAspectFill
                }

                
    //            cell.imgPopular.sd_setImage(with: URL(string: image!), placeholderImage: UIImage(named: "PlaceholderImg"))
             
             
                
            
             cell.favouriteTitle.text = self.favouriteCourses[indexPath.row]["title"] as? String
            }
            
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "ArticleDetailsVCSBID") as! ArticleDetailsVC
        
        if collectionView == popularCollectionView
        {
            controller.articleId = self.popularCourses[indexPath.row]["article_id"] as? Int //[indexPath.row]
//            vc.lessonId =  self.popularCourses[indexPath.row]["id"] as? Int
            //controller.articleId = self.articleListArr[indexPath.row]["id"] as? Int
        }
        
        if collectionView == latestCollectionView
        {
            //vc.lessonId =  self.latestCourses[indexPath.row]["id"] as? Int
            controller.articleId = self.latestCourses[indexPath.row]["article_id"] as? Int
            
        }
        
        if collectionView == favouriteCollectionView
        {
            //vc.lessonId =  self.favouriteCourses[indexPath.row]["id"] as? Int
            controller.articleId = self.favouriteCourses[indexPath.row]["article_id"] as? Int
        }
        
        
        //self.Articles_List = ArrTotalArticlesList[0] as! [AnyObject]
        
        
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

