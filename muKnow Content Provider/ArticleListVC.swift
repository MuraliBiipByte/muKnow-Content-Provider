//
//  ArticleListVC.swift
//  muKnow Content Provider
//
//  Created by Apple on 09/04/21.
//

import UIKit

class ArticleListVC: UIViewController {

    var articleListArr = [AnyObject]()
    var trainerID = ""
    
    @IBOutlet weak var articleListTV: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.setNavigationBarHidden(false, animated: true)
        let lefticonButton = UIButton(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 35, height: 35)))
        lefticonButton.setBackgroundImage(UIImage(named: "muknowAppLogo"), for: .normal)
        
        let leftbarButton = UIBarButtonItem(customView: lefticonButton)
        navigationItem.leftBarButtonItem = leftbarButton
        
        articleListTV.delegate = self
        articleListTV.dataSource = self
        
        self.articleListTV.isHidden = true
        self.articleListTV.tableFooterView = UIView.init(frame: CGRect.zero)
        
        let loginResponse = fetchLoginResponse()
        self.trainerID = (loginResponse?.trainerId)!
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        callArticleListService()
    }
    
    func callArticleListService() {
        self.view.StartLoading()
        
        ApiManager().postRequest(service: WebServices.ARTICLE_LIST, params: self.trainerID) { [self] (result, success) in
            self.view.StopLoading()

            if success == false
            {
                self.showAlert(message: result as! String)
                return
            }
            else
            {
                let response = result as! [String : Any]
                print("ArticleList Response :",response)
                
                if (response["data"] as? NSDictionary) != nil {
                   let data = (response["data"] as? NSDictionary)
                    if (data!["response"] as? NSDictionary) != nil {
                        let resp = (data!["response"] as? NSDictionary)
                    
                        if (resp!["data"] as? NSDictionary) != nil {
                            let data = (resp!["data"] as? NSDictionary)
                            self.articleListArr = data!["articles_list"] as! [AnyObject]
                            
                            if self.articleListArr.count > 0 {
                                articleListTV.reloadData()
                                articleListTV.isHidden = false
                            }
                        }
                    }
                }
            }

        }
        
        /*
        ApiManager().getRequest(service: WebServices.ARTICLE_LIST, param: self.trainerID) { [self] (result, success) in
                        self.view.StopLoading()
            
                        if success == false
                        {
                            self.showAlert(message: result as! String)
                            return
                        }
                        else
                        {
                            let response = result as! [String : Any]
                            print("ArticleList Response :",response)
                            
                            if (response["data"] as? NSDictionary) != nil {
                               let data = (response["data"] as? NSDictionary)
                                if (data!["response"] as? NSDictionary) != nil {
                                    let resp = (data!["response"] as? NSDictionary)
                                
                                    if (resp!["data"] as? NSDictionary) != nil {
                                        let data = (resp!["data"] as? NSDictionary)
                                        self.articleListArr = data!["articles_list"] as! [AnyObject]
                                        
                                        if self.articleListArr.count > 0 {
                                            articleListTV.reloadData()
                                            articleListTV.isHidden = false
                                        }
                                    }
                                }
                            }
                        }
        } */
    }
    
    func showAlert(message:String)
      {
          Message.shared.Alert(Title:APP_NAME, Message: message, TitleAlign: .normal, MessageAlign: .normal, Actions: [Message.AlertActionWithOutSelector(Title: "Ok")], Controller: self)
      }
    
    
    @IBOutlet weak var homeBtn: UIButton!
    @IBOutlet weak var articleListBtn: UIButton!
    @IBOutlet weak var notificationBtn: UIButton!
    @IBOutlet weak var profileBtn: UIButton!
    
    @IBAction func homeBtnTapped(_ sender: UIButton) {
        let homePageVObj = UIStoryboard.MainStoryBoard.HomePageVC()
        self.navigationController?.pushViewController(homePageVObj!, animated: false)
    }
    
    @IBAction func articleListBtnTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func notificationBtnTapped(_ sender: UIButton) {
                let notificationVCObj = UIStoryboard.MainStoryBoard.NotificationVC()
                self.navigationController?.pushViewController(notificationVCObj!, animated: false)
    }
    
    @IBAction func profileBtnTapped(_ sender: UIButton) {
//        let profileVCObj = UIStoryboard.MainStoryBoard.ProfileVC()
//        self.navigationController?.pushViewController(profileVCObj!, animated: false)
        
        let myAccountVCObj = UIStoryboard.MainStoryBoard.MyAccountVC()
        self.navigationController?.pushViewController(myAccountVCObj!, animated: false)
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
extension ArticleListVC : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articleListArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleLIstCellID") as! ArticleLIstCell
        cell.titleLbl.text = "\(String(describing: self.articleListArr[indexPath.row]["title"]!!))"
        cell.shortDescLbl.text = "\(String(describing: self.articleListArr[indexPath.row]["short_description"]!!))"
        cell.countLbl.text = "\(String(describing: self.articleListArr[indexPath.row]["article_views_count"]!!))"
        
//        textLabel?.layer.cornerRadius = textLabel?.frame.size.height/2.0
//        textLabel?.layer.masksToBounds = true
        
//        cell.countLbl.layer.cornerRadius = cell.titleLbl.frame.size.height/2.0
//        cell.countLbl.layer.masksToBounds = true
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "ArticleDetailsVCSBID") as! ArticleDetailsVC
        //self.Articles_List = ArrTotalArticlesList[0] as! [AnyObject]
        controller.articleId = self.articleListArr[indexPath.row]["id"] as? Int
        
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
