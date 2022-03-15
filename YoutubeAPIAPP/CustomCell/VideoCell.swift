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
        
        let title: String = data.snippet.title ?? "---"
        let channelTitle = data.snippet.channelTitle ?? "---"
        titleLabel.text = title
        channelTitleLabel.text = channelTitle
        
        guard let url = data.snippet.thumbnails.high.url else {
            thumbnailImage.image = UIImage(named: "noImage")
            return
        }
        
        thumbnailImage.sd_setImage(with: URL(string: url), completed: nil)
        
    }
    
}
