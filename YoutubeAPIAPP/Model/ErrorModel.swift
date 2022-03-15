//
//  ErrorModel.swift
//  YoutubeAPIAPP
//
//  Created by 都甲裕希 on 2022/03/15.
//

import Foundation

//検索画面でのエラータイプを定義
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

//API通信時のエラータイプを定義
enum ErrorTypeOfYoutubeAPIModel:Error{
    case illgalWord
    case netWorkError
    case parseError
    case noData
    
    var alertTitle: String{
        switch self {
        case .illgalWord:
            return "不正な文字列です"
        case .netWorkError:
            return "ネットワークに接続できません"
        case .parseError:
            return "予期せぬエラーが発生しました"
        case .noData:
            return "検索結果がありません"
        }
    }
    
    var alertMessege: String{
        switch self {
        case .illgalWord:
            return "検索キーワードを確認してください。"
        case .netWorkError:
            return "ネットワーク接続を確認してください。"
        case .parseError:
            return ""
        case .noData:
            return "検索キーワードを確認してください。"
        }
    }
}
