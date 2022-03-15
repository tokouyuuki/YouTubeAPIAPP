//
//  WebViewController.swift
//  YoutubeAPIAPP
//
//  Created by 都甲裕希 on 2022/03/15.
//

import UIKit
import youtube_ios_player_helper

class PlayerViewController: UIViewController {
    
    var videoId: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let youtubeView = YTPlayerView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        youtubeView.load(withVideoId: videoId)
        view.addSubview(youtubeView)
        // Do any additional setup after loading the view.
    }
    
    

}
