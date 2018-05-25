//
//  HotPostsTableCell.swift
//  Travel-IT
//
//  Created by Ankit Singh on 23/03/18.
//  Copyright © 2018 Ankit Singh. All rights reserved.
//

import UIKit
import SDWebImage
class HotPostsTableCell: UITableViewCell {
    
    @IBOutlet var postMainImage: UIImageView!
    @IBOutlet var postTitle: UILabel!
    @IBOutlet var authorNameLabel: UILabel!
    @IBOutlet var postCommentsCountLabel: UILabel!
    @IBOutlet var postMoneyLabel: UILabel!
    @IBOutlet var postUpvotesCountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.authorNameLabel.addShadowWith(shadowOffset: CGSize(width: 5, height: 5), shadowOpacity: 5.0, shadowRadius: 12.0)
        self.postTitle.addShadowWith(shadowOffset: CGSize(width: 5, height: 5), shadowOpacity: 5.0, shadowRadius: 12.0)
     }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    // function to update single cell data
    func updateCellData(data: [String: AnyObject]) {
        self.postTitle.text = data["title"]! as? String
        if let author = data["author"] as? String {
            self.authorNameLabel.text = "By : \(author)"
        }
        let upvotesCount = data["net_votes"] as? Int
        self.postUpvotesCountLabel.text = "\(upvotesCount ?? 0)"
        let commentsCount = data["children"] as? Int
        self.postCommentsCountLabel.text = "\(commentsCount ?? 0)"
        self.postMoneyLabel.text = data["pending_payout_value"] as? String
        let metadata = data["json_metadata"]! as! String
        let data = metadata.data(using: .utf8)!
        do {
            if let jsonArray = try JSONSerialization.jsonObject(with: data, options : .allowFragments) as? [String:AnyObject]
            {
                if let images = jsonArray["image"] as? [String] {
                    let finalImage = images[0]
                    if let url = URL(string: finalImage) {
                        postMainImage.sd_setImage(with: url)
                    }
                }
            } else {
                print("bad json")
            }
        } catch let error as NSError {
            print(error)
        }
        
    }
    
}
