//
//  PostsTableCell.swift
//  Travel-IT
//
//  Created by Ankit Singh on 17/03/18.
//  Copyright © 2018 Ankit Singh. All rights reserved.
//

import UIKit
import SDWebImage
class PostsTableCell: UITableViewCell {
    
    @IBOutlet var upvoteButton: UIButton!
    @IBOutlet var commentCountImageVw: UIImageView!
    @IBOutlet var moneyImageVw: UIImageView!
    @IBOutlet var upvoteCountImageVw: UIImageView!
    @IBOutlet var commentCountLabel: UILabel!
    @IBOutlet var moneyLabel: UILabel!
    @IBOutlet var upvoteCountLabel: UILabel!
    @IBOutlet var postMainImage: UIImageView!
    @IBOutlet var postTitle: UILabel!
    @IBOutlet var authorNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    // function to update single cell data
    func updateCellData(data: [String: AnyObject]) { 
        self.postTitle.text = data["title"]! as? String
        if let author = data["author"] as? String {
            self.authorNameLabel.text = "By : \(author))"
        }
        let upvoteCount = data["net_votes"] as? Int
        self.upvoteCountLabel.text = "\(upvoteCount ?? 0)"
        let commentCount = data["children"] as? Int
        self.commentCountLabel.text = "\(commentCount ?? 0)"
        self.moneyLabel.text = data["pending_payout_value"] as? String
        DispatchQueue.global(qos: .background).async {
            let metadata = data["json_metadata"]! as! String
            let data = metadata.data(using: .utf8)!
            do {
                if let jsonArray = try JSONSerialization.jsonObject(with: data, options : .allowFragments) as? [String:AnyObject]
                {
                    if let images = jsonArray["image"] as? [String] {
                        let finalImage = images[0]
                        print(finalImage)
                        if let url = URL(string: finalImage) {
                            self.postMainImage.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "travel_placeholder_image"), options: SDWebImageOptions.highPriority, completed: nil)
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
}
