//
//  ViewController.swift
//  CustomTableViewCell
//
//  Created by tobiasmidskard on 12/04/2020.
//  Copyright © 2020 tobiasmidskard. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var stories = [Story]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stories.append(Story(txt: "Hi there", img: ""))
        stories.append(Story(txt: "I have no image", img: ""))
        stories.append(Story(txt: "nice car there", img: "Car0"))
        tableView.dataSource = self // assign this class to handle data for the tableView
        tableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if stories[indexPath.row].hasImage() {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "cell2") as? TableViewCellTextAndImage {
                cell.myLabel.text = stories[indexPath.row].text
                cell.myImage.image = UIImage(named: stories[indexPath.row].image)
                return cell
            }
        } else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "cell1") as? TableViewCellTextOnly {
                cell.myLabel.text = stories[indexPath.row].text
                return cell
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return stories[indexPath.row].hasImage() ? 250 : 80
    }
    
}

