//
//  TableViewCell.swift
//  HomeWork05
//
//  Created by Vattanac on 12/26/18.
//  Copyright © 2018 vattanac. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var hidenlabel: UILabel!
    @IBOutlet weak var ImageArticle: UIImageView!
    @IBOutlet weak var titleArticle: UILabel!
    @IBOutlet weak var authorArticle: UILabel!
    @IBOutlet weak var desArticle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        desArticle.adjustsFontSizeToFitWidth = false;
        desArticle.lineBreakMode = NSLineBreakMode.byTruncatingTail
        
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }
    
}

