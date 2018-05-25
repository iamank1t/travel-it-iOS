//
//  Client.swift
//  Travel-IT
//
//  Created by Ankit Singh on 25/05/18.
//  Copyright © 2018 Ankit Singh. All rights reserved.
//

import UIKit

let baseURL:String = "https://v2.steemconnect.com"
let appId:String = ""

//GET /get_discussions_by_trending
let discussions_by_trending = "https://api.steemjs.com/get_discussions_by_trending?"

//GET /get_discussions_by_created
let discussions_by_created = "https://api.steemjs.com/get_discussions_by_created?"

//GET /get_discussions_by_hot
let discussions_by_hot = "https://api.steemjs.com/get_discussions_by_hot?"

//GET /get_accounts
let get_accounts = "https://api.steemjs.com/get_accounts?"

let get_content_replies = "https://api.steemjs.com/get_content_replies?"

let get_login_url = "https://v2.steemconnect.com/oauth2/authorize?client_id=travel-it-app&redirect_uri=https://github.com/cnsteem/sc2-angular&scope=vote,comment"

//GET /get_search
let get_search_result = "https://api.asksteem.com/search?q=steemthink"

//POST /broadcast
let post_broadcast = "https://v2.steemconnect.com/api/broadcast/"


class STClient: NSObject {
    
    typealias STClientCallBack = (_ response: Any?,_ error: Error?)->()
}
