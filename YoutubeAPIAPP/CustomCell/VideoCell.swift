//
//  VideoCell.swift
//  YoutubeAPIAPP
//
//  Created by 都甲裕希 on 2022/03/15.
//

import UIKit
import SDWebImage

class VideoCell: UITableViewCell {
    
    @IBOutlet weak var thumbnailImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var channelTitleLabel: UILabel!
    

    func configure(videoData data: Item){
        
        titleLabel.text = data.snippet.title
        channelTitleLabel.text = data.snippet.channelTitle
        
        guard let url = URL(string: data.snippet.thumbnails.default.url) else {
            thumbnailImage.image = UIImage(named: "noImage")
            return
        }
        
        thumbnailImage.sd_setImage(with: url, completed: nil)
        
    }
    
}
