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

    private var count: Int = 1
    private var loadStatus: String = "initial"

    var reloadHandler: () -> Void = { _ in }

    func fetchArticles() {
        guard loadStatus != "fetching" && loadStatus != "full" else { return }
        loadStatus = "fetching"
        guard let url: URL = URL(string: "http://qiita.com/api/v2/items?page=\(count)&per_page=20") else { return }
        let task: URLSessionTask  = URLSession.shared.dataTask(with: url, completionHandler: {data, response, error in
            do {
                guard let data = data else {
                    self.loadStatus = "error"
                    return
                }
                guard let jsonArray = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? [Any] else {
                    self.loadStatus = "error"
                    return
                }
                let articlesJson = jsonArray.flatMap { (json: Any) -> [String: Any]? in
                    return json as? [String: Any]
                }
                let articles = articlesJson.map { (articleJson: [String: Any]) -> Article in
                    return Article(json: articleJson)
                }
                if articles.count == 0 {
                    self.loadStatus = "full"
                    return
                }
                DispatchQueue.main.async() { () -> Void in
                    self.articles = self.articles + articles
                    self.loadStatus = "loadmore"
                }
                self.count += 1
            }
            catch {
                print(error)
                self.loadStatus = "error"
            }
        })
        task.resume()
    }
}
