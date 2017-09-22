//
//  ViewModel.swift
//  SampleApp
//
//  Created by 深津裕樹 on 2017/09/22.
//  Copyright © 2017年 sample. All rights reserved.
//

import UIKit

class ViewModel {

    var articles: [Article] = [] {
        didSet {
            reloadHandler()
        }
    }

    var reloadHandler: () -> Void = { _ in }

    func fetchArticles() {
        guard let url: URL = URL(string: "http://qiita.com/api/v2/items") else { return }
        let task: URLSessionTask  = URLSession.shared.dataTask(with: url, completionHandler: {data, response, error in
            do {
                guard let data = data else { return }
                guard let jsonArray = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? [Any] else { return }
                let articlesJson = jsonArray.flatMap { (json: Any) -> [String: Any]? in
                    return json as? [String: Any]
                }
                let articles = articlesJson.map { (articleJson: [String: Any]) -> Article in
                    return Article(json: articleJson)
                }
                DispatchQueue.main.async() { () -> Void in
                    self.articles = articles
                }
            }
            catch {
                print(error)
            }
        })
        task.resume()
    }
}
