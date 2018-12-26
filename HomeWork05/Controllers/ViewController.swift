//
//  ViewController.swift
//  HomeWork05
//
//  Created by Vattanac on 12/26/18.
//  Copyright © 2018 vattanac. All rights reserved.
//


import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher


class ViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    var articleList = [Article]()
    var pagenation = 1
    static var article  : Article!
    var refreshcontrol = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData(pagenation: pagenation)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        tableView.refreshControl = refreshcontrol
        refreshcontrol.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        
    }
    
    @objc func refreshData(){
        articleList.removeAll()
        pagenation = 1
        getData(pagenation: pagenation)
        tableView.reloadData()
        refreshcontrol.endRefreshing()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articleList.count
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        getData(pagenation: pagenation)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedProgram = articleList[indexPath.row]
        let destinationVC = DetailViewController()
        self.performSegue(withIdentifier: "detail", sender: self)
        print("detail")
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailViewController {
            destination.article = articleList[(tableView.indexPathForSelectedRow?.row)!]
        }
    }
    
    @IBAction func AddButton(_ sender: Any) {
        
        self.performSegue(withIdentifier: "add", sender: self)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = Bundle.main.loadNibNamed("TableViewCell", owner: self, options: nil)?.first as! TableViewCell
        cell.titleArticle.text =  articleList[indexPath.row].title ?? "no title"
        cell.authorArticle.text = "kok dara"
        
        
        if articleList[indexPath.row].description == nil || articleList[indexPath.row].description == "" {
            articleList[indexPath.row].description = "no description"
        }
        
        //        cell.hidenlabel.text = String(articleList[indexPath.row].Id)
        cell.desArticle.text = articleList[indexPath.row].description //?? "No description"
        
        let imageString = articleList[indexPath.row].imageUrl ?? "http://www.markweb.in/primehouseware/images/noimage.png"
        
        //MARK: Kingfisher
        let url = URL(string: imageString)
        cell.ImageArticle.kf.indicatorType = .activity
        cell.ImageArticle.kf.setImage(
            with: url,
            placeholder: #imageLiteral(resourceName: "noimage"),
            options: [
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
        return cell
        
    }
    
    //MARK:WillDisplayCell
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let lastrow = articleList.count - 1
        if lastrow == indexPath.row{
            pagenation = pagenation + 1
            getData(pagenation: pagenation)
            tableView.insertRows(at: [indexPath], with: .fade)
            
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 116
    }
    
    func postData(){
        
    }
    
    //MARK: swape to delete ROW
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "delete") { (action, view , handler) in
            
            let idfordelete =  self.articleList[indexPath.row].Id
            self.deleteData(id: idfordelete!)
            
            
            self.articleList.remove(at: indexPath.row)
            //                tableView.deleteRows(at: [indexPath], with: .fade)
            handler(true)
            
        }
        let cofiguration = UISwipeActionsConfiguration(actions: [delete])
        cofiguration.performsFirstActionWithFullSwipe = true
        
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let edit = UIContextualAction(style: .normal, title: "edit") { (action, view , handler) in
            
            self.performSegue(withIdentifier: "add", sender: self)
            
            
            EditeViewController.article = self.articleList[indexPath.row]
            
            
        }
        let cofiguration = UISwipeActionsConfiguration(actions: [edit])
        cofiguration.performsFirstActionWithFullSwipe = true
        
        return UISwipeActionsConfiguration(actions: [edit])
    }
    
    
    func deleteData(id:Int){
        let url = "http://api-ams.me/v1/api/articles/" + String(id)
        let header = ["Authorization": "Basic QU1TQVBJQURNSU46QU1TQVBJUEBTU1dPUkQ="]
        
        Alamofire.request(url, method: .delete, headers: header).responseJSON { (response) in
            
            guard response.result.error == nil else {
                // got an error in getting the data, need to handle it
                print("error calling DELETE on /todos/1")
                if let error = response.result.error {
                    print("Error: \(error)")
                }
                return
            }
            print("DELETE ok")
        }
    }
    
    func getData(pagenation:Int) -> [Article] {
        
        //var myArray = [Article]()
        let url = "http://api-ams.me/v1/api/articles?page=" + String(pagenation) + "&limit=15"
        let header = ["Authorization": "Basic QU1TQVBJQURNSU46QU1TQVBJUEBTU1dPUkQ="]
        
        Alamofire.request(url, method: .get
            , parameters: nil , headers: header).responseJSON { (response) in
                
                guard response.result.isSuccess else{
                    print("error")
                    return
                }
                let json = response.result.value as! [String:Any]
                let jsondata = json["DATA"] as! [[String:Any]]
                //print(jsondata)
                
                for article in jsondata{
                    self.articleList.append(Article(JSON: article)!)
                    self.tableView.reloadData()
                }
                for i in self.articleList{
                    
                    
                }
        }
        
        return  self.articleList
    }
    
    
    
}


