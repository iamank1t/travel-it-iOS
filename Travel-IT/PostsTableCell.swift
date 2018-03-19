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
        self.postTitle.text = data["title"]! as! String
        self.authorNameLabel.text = data["author"] as! String
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
