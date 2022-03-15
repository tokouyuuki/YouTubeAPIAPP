//
//  VideoListPresenter.swift
//  YoutubeAPIAPP
//
//  Created by 都甲裕希 on 2022/03/15.
//

import Foundation

protocol VideoListViewPresenterInput{
    
    //画面表示用のデータを共有
    var videoList: [Item] { get }
    
    //viewDidLoadを通知する
    func loadView(searchText text: String)
    
    //セルのタップを通知する
    func didSelectTableViewCell(indexPath index: IndexPath)
    
}

protocol VideoListViewPresenterOutput{
    
    //tableViewの設定を指示
    func setTabelViewInfo()
    
    //navigationbarの設定を指示
    func setNavigationBarInfo()
    
    //activityIndicatorViewの設定を指示する
    func setActivityIndicatorViewInfo()
    
    //activityIndicatorViewのstartAnimating()を指示する
    func activityIndicatorViewStartAnimating()
    
    //activityIndicatorViewのstopAnimating()を指示する
    func activityIndicatorViewStopAnimating()
    
    //Erroralert表示・全画面への遷移を指示する
    func showAlertAndTransitionToBackView(errorType error: ErrorTypeOfYoutubeAPIModel)
    
    //PlayerVCへの画面遷移を指示
    func transitionToPlayerVC(videoId id:String)
    
    //tableViewのreloadを指示する。
    func reloadData()
    
}

final class VideoListViewPresenter: VideoListViewPresenterInput{
    
    var videoList: [Item] = []
    private var view: VideoListViewPresenterOutput
    
    init(view: VideoListViewPresenterOutput){
        self.view = view
    }
    
    func loadView(searchText text: String) {
        self.view.setTabelViewInfo()
        self.view.setNavigationBarInfo()
        self.view.setActivityIndicatorViewInfo()
        
        self.view.activityIndicatorViewStartAnimating()
        YoutubeAPIModel.fetchVideoListData(parameter: text) { result in
            switch result {
            case .success(let videoList):
                self.videoList = videoList
                DispatchQueue.main.async {
                    self.view.activityIndicatorViewStopAnimating()
                    self.view.reloadData()
                }
            case .failure(let errorType):
                DispatchQueue.main.async {
                    self.view.activityIndicatorViewStopAnimating()
                    self.view.showAlertAndTransitionToBackView(errorType: errorType)
                }
            }
        }
    }
    
    func didSelectTableViewCell(indexPath index: IndexPath) {
        
        let indexPathRow = index.row
        let videoId: String = self.videoList[indexPathRow].id.videoId ?? ""
        
        self.view.transitionToPlayerVC(videoId: videoId)
    }
}
