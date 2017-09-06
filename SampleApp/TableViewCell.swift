//
//  TableViewCell.swift
//  SampleApp
//
//  Created by 深津裕樹 on 2017/07/19.
//  Copyright © 2017年 sample. All rights reserved.
//

import UIKit
import SDWebImage

class TableViewCell: UITableViewCell {

    @IBOutlet weak var aaa: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func bindData(text: String) {
        guard let imageUrl = URL(string: text) else { return }
        aaa.sd_setImage(with: imageUrl, completed: nil)
    }
    
}
