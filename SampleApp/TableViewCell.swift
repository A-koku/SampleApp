//
//  TableViewCell.swift
//  SampleApp
//
//  Created by 深津裕樹 on 2017/07/19.
//  Copyright © 2017年 sample. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var userIdLabel: UILabel!
    @IBOutlet weak var userThumbImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func bindData(article: Article) {
        titleLabel.text = article.title
        userIdLabel.text = article.userId

        let profileImageUrl = URL(string: article.profileImageUrlString)!
        let session = URLSession(configuration: .default)
        let downloadImageTask = session.dataTask(with: profileImageUrl) { (data, response, error) in
            guard let imageData = data else { return }
            let imageimage = UIImage(data: imageData)
            DispatchQueue.main.async() { () -> Void in
                self.userThumbImageView.image = imageimage
            }
        }
        downloadImageTask.resume()
    }
}
