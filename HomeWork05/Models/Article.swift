//
//  Article.swift
//  HomeWork05
//
//  Created by Vattanac on 12/26/18.
//  Copyright © 2018 vattanac. All rights reserved.
//

import Foundation
import ObjectMapper

class Article :Mappable{
    
    var title:String!
    var imageUrl:String!
    var description:String!
    var Id:Int!
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        title <- map["TITLE"]
        imageUrl  <- map["IMAGE"]
        description <- map["DESCRIPTION"]
        Id <- map["ID"]
    }
    
    
}
