//
//  ArticleDetailViewController.swift
//  SampleApp
//
//  Created by 深津裕樹 on 2017/09/23.
//  Copyright © 2017年 sample. All rights reserved.
//

import UIKit

class ArticleDetailViewController: UIViewController {

    @IBOutlet weak var bodyLabel: UILabel!

    var article: Article?

    override func viewDidLoad() {
        super.viewDidLoad()
        bodyLabel.text = article?.body
    }
}
