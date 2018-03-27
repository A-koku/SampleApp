//
//  ViewController.swift
//  SampleApp
//
//  Created by 深津裕樹 on 2017/05/23.
//  Copyright © 2017年 sample. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var ref: DatabaseReference!

    var messages: [String] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
        ref = Database.database().reference().child("posts")

        ref.observe(.childAdded, with: { snapshot in
            print("!!!!!!!!!!!!!!!!!!!!!!!!!!")
            print(snapshot)
            guard let snapShotValue = snapshot.value as? [String: Any] else { return }
            print(snapShotValue)
            guard let title = snapShotValue["title"] as? String else { return }
            print(title)
            self.messages = self.messages + [title]
        })


    }
}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TableViewCell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as! TableViewCell
        cell.bindData(text: messages[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("section: \(indexPath.section) index: \(indexPath.row)")
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        return
    }
}
