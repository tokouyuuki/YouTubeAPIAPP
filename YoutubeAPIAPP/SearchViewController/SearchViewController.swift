//
//  SearchViewController.swift
//  YoutubeAPIAPP
//
//  Created by 都甲裕希 on 2022/03/15.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    
    private var presenter:SearchViewPresenterInput?
    
    func inject(presenter:SearchViewPresenterInput){
        self.presenter = presenter
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        let presenter = SearchViewPresenter(view: self)
        self.inject(presenter: presenter)
        
        self.presenter?.loadView()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func pushSearchButton(_ sender: Any) {
        
        self.presenter?.pushSearchButton(text: self.textField.text)
    }
    
}

extension SearchViewController: SearchViewPresenterOutput{
    
    func setTextFieldInfo() {
        self.textField.delegate = self
        self.textField.placeholder = "動画を検索"
    }
    
    func setSearchButtonInfo() {
        self.searchButton.layer.cornerRadius = 5
    }
    
    func transitionToVideoListsVC(text: String) {
        let videoListVC = self.storyboard?.instantiateViewController(withIdentifier: "videoListVC") as! VideoListViewController
        videoListVC.searchText = text
        self.navigationController?.pushViewController( videoListVC, animated: true)
    }
    
    func showAlert(alertType: ErrorTypeOfSearchVC) {
        self.present(UIAlertController(errorType: alertType), animated: true, completion: nil)
    }
}

extension SearchViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
            self.textField.endEditing(true)
            return true
        
        }
        
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
            self.view.endEditing(true)
        
        }
}

extension UIAlertController {
    convenience init(errorType error: ErrorTypeOfSearchVC){
        self.init(title: error.alertTitle, message: error.alertMessege, preferredStyle: .alert)
        self.addAction(.init(title: "OK", style: .default, handler: nil))
    }
}
