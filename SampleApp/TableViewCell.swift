//
//  TableViewCell.swift
//  SampleApp
//
//  Created by 深津裕樹 on 2017/07/19.
//  Copyright © 2017年 sample. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func bindData(text: String) {
        label.text = text
    }
    
}
