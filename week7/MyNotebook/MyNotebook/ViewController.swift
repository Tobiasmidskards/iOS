//
//  ViewController.swift
//  MyNotebook
//
//  Created by tobiasmidskard on 14/02/2020.
//  Copyright © 2020 tobiasmidskard. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var myTextView: UITextView!
    
    @IBOutlet weak var tableView: UITableView!
    
    var savedText = "Starting here.."
    var currentIndex = -1
    
    var textArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        textArray.append("Hello")
        textArray.append("How are you")
        
        myTextView.text = savedText
        
        tableView.dataSource = self
        tableView.delegate = self
    }

    @IBAction func buttonPressed(_ sender: Any) {
        savedText = myTextView.text!
        if (savedText != "") {
            if (currentIndex == -1) {
                textArray.append(savedText)
            } else {
                textArray[currentIndex] = savedText
                currentIndex = -1
            }
            tableView.reloadData()
            myTextView.text = ""
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return textArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1")
        cell?.textLabel?.text = textArray[indexPath.row]
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myTextView.text = textArray[indexPath.row]
        currentIndex = indexPath.row
    }
    
}

