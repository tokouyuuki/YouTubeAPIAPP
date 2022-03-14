//
//  SearchPresenter.swift
//  YoutubeAPIAPP
//
//  Created by 都甲裕希 on 2022/03/15.
//

import Foundation

enum ErrorTypeOfSearchVC{
    case textIsEmpty
    
    var alertTitle: String{
        switch self {
        case .textIsEmpty:
            return "検索キーワードが空です。"
        }
    }
    
    var alertMessege: String{
        switch self {
        case .textIsEmpty:
            return "検索キーワードを入力してください。"
        }
    }
    
}

protocol SearchViewPresenterInput{
    
    //ViewDidLoadを通知する
    func loadView()
    
    //検索ボタンのタップを通知する
    func pushSearchButton(text: String?)
    
}

protocol SearchViewPresenterOutput{
    
    //searchButtonの設定を指示
    func setSearchButtonInfo()
    
    //textFieldの設定を指示
    func setTextFieldInfo()
    
    //VideoListVCへの画面遷移を指示
    func transitionToVideoListsVC(text:String)
    
    //アラート表示を指示
    func showAlert(alertType: ErrorTypeOfSearchVC)
}

final class SearchViewPresenter: SearchViewPresenterInput{
    
    private var view: SearchViewPresenterOutput
    
    init(view:SearchViewPresenterOutput){
        self.view = view
    }
    
    func loadView() {
        self.view.setSearchButtonInfo()
        self.view.setTextFieldInfo()
    }
    
    func pushSearchButton(text: String?) {
        
        if !text!.isEmpty{
            self.view.transitionToVideoListsVC(text: text!)
        }else{
            self.view.showAlert(alertType: .textIsEmpty)
        }
        
    }
    
}
