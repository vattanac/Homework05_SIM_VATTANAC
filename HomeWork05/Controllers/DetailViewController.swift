//
//  DetailViewController.swift
//  HomeWork05
//
//  Created by Vattanac on 12/26/18.
//  Copyright © 2018 vattanac. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var article  : Article?
    
    @IBOutlet weak var ImageArticle: UIImageView!
    @IBOutlet weak var titleArticle: UILabel!
    @IBOutlet weak var desArticle: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //let a = DetailViewController.article
        
        let defaultImage = try! Data(contentsOf: URL(string: "http://www.markweb.in/primehouseware/images/noimage.png")!)
        
        print("***168**\(article)")
        let url = URL(string: (article!.imageUrl! ?? "http://www.markweb.in/primehouseware/images/noimage.png" ))
        let data = try? Data(contentsOf: url!)
        
        ImageArticle.image = UIImage(data: data ?? defaultImage )
        titleArticle.text = article!.title
        desArticle.text = article!.description
        
    }
    
    
}

