//
//  VideoListViewController.swift
//  YoutubeAPIAPP
//
//  Created by 都甲裕希 on 2022/03/15.
//

import UIKit

class VideoListViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    var searchText:String = ""
    
    private var presenter: VideoListViewPresenterInput?
    private var activityIndicatorView = UIActivityIndicatorView()
    
    private func inject(presenter: VideoListViewPresenterInput){
        self.presenter = presenter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let presenter = VideoListViewPresenter(view: self)
        self.inject(presenter: presenter)
        
        self.presenter?.loadView(searchText: searchText)
    }
    
}

extension VideoListViewController: VideoListViewPresenterOutput{
    
    func setTabelViewInfo() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        tableView.register(UINib(nibName: "VideoCell", bundle: nil), forCellReuseIdentifier: "videoCell")

    }
    
    func setNavigationBarInfo() {
        self.navigationItem.title = "検索結果"
    }
    
    func setActivityIndicatorViewInfo() {
        self.activityIndicatorView.center = CGPoint(x: self.view.frame.width / 2, y: self.view.frame.height / 3)
        self.activityIndicatorView.style = .large
        self.activityIndicatorView.color = .darkGray
        self.activityIndicatorView.hidesWhenStopped = true
        
        view.addSubview(activityIndicatorView)
    }
    
    func activityIndicatorViewStartAnimating() {
        self.activityIndicatorView.startAnimating()
    }
    
    func activityIndicatorViewStopAnimating() {
        self.activityIndicatorView.stopAnimating()
    }
    
    func showAlertAndTransitionToBackView(errorType error: ErrorTypeOfYoutubeAPIModel) {
        self.present(UIAlertController(errorType: error, handler: {
            self.navigationController?.popViewController(animated: true)
        }), animated: true, completion: nil)
    }
    
    func transitionToPlayerVC(videoId id: String) {
        let playerVC = self.storyboard?.instantiateViewController(withIdentifier: "playerVC") as! PlayerViewController
        playerVC.videoId = id
        self.navigationController?.pushViewController(playerVC, animated: true)
        
    }
    
    func reloadData() {
        self.tableView.reloadData()
    }
}

extension VideoListViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.presenter?.videoList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "videoCell") as! VideoCell
        let data = self.presenter?.videoList[indexPath.row]
        
        cell.configure(videoData: data!)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.presenter?.didSelectTableViewCell(indexPath: indexPath)
    }
    
}

extension UIAlertController{
    convenience init(errorType error: ErrorTypeOfYoutubeAPIModel,handler: @escaping () -> Void){
        self.init(title: error.alertTitle, message: error.alertMessege, preferredStyle: .alert)
        self.addAction(.init(title: "OK", style: .default, handler: { _ in
            handler()
        }))
    }
}
