//
//  Post.swift
//  InsagramCloneApp
//
//  Created by Perez Willie Nwobu on 1/28/19.
//  Copyright © 2019 Perez Willie Nwobu. All rights reserved.
//

import Foundation
class Post {
    var caption : String
    var photoURL : String
    
    init(captionText : String, photoURLString : String){
        caption = captionText
        photoURL = photoURLString
    }
}
