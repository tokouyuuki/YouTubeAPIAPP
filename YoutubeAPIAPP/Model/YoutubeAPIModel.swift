//
//  YoutubeAPIModel.swift
//  YoutubeAPIAPP
//
//  Created by 都甲裕希 on 2022/03/15.
//

import Foundation

//取得データを定義
struct VideoList: Codable{
    
    let pageInfo: PageInfo
    let items: [Item]
    
}
struct PageInfo: Codable{
    let resultsPerPage: Int
}

struct Item: Codable{
    let id: Id
    let snippet: Snippet
    
    struct Id: Codable{
        let videoId: String?
    }
    
    struct Snippet: Codable{
        let title: String?
        let thumbnails: Thumbnails
        let channelTitle: String?
    }
    
    struct Thumbnails: Codable{
        let high: Url
    }
    
    struct Url: Codable{
        let url: String?
    }
}

final class YoutubeAPIModel{
    
    static func fetchVideoListData(parameter q: String, completionHandler: @escaping (Result<[Item], ErrorTypeOfYoutubeAPIModel>) -> ()){
        let urlString = "https://www.googleapis.com/youtube/v3/search?key=AIzaSyDOAHl0mHDuFWo8DBlby-exeRDFtDirYvA&q=\(q)&part=snippet&maxResults=40".addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
        guard let url = URL(string: urlString) else {
            completionHandler(.failure(.illgalWord))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, err) in
            if err != nil{
                completionHandler(.failure(.netWorkError))
                return
            }
            
            guard let safeData = data else {
                completionHandler(.failure(.parseError))
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let decodeData = try decoder.decode( VideoList.self, from: safeData)
                if !decodeData.items.isEmpty {
                    completionHandler(.success(decodeData.items))
                } else {
                    completionHandler(.failure(.noData))
                }
            } catch {
                completionHandler(.failure(.parseError))
            }
        }
        task.resume()
    }
}
