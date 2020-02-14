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
    
    let fileName = "theString.txt"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        textArray.append("Hellooooo")
        
        myTextView.text = savedText
        
        tableView.dataSource = self
        tableView.delegate = self
 
    }

    @IBAction func deleteButtonPressed(_ sender: Any) {
        if (currentIndex != -1) {
            textArray.remove(at: currentIndex)
            tableView.reloadData()
            currentIndex = -1
        }
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
            saveStringToFile(str: savedText, fileName: fileName)
            print(readStringFromFile(fileName: fileName))
        }
    }
    
    func saveStringToFile(str:String, fileName:String) {
        let filePath = getDocumentDir().appendingPathComponent(fileName)
        
        do {
            try str.write(to: filePath, atomically: true, encoding: .utf8)
            print("OK writing string ' \(str) ' to file")
        } catch {
            print("ERROR writing string ' \(str) ' to file")
        }
    }
    
    func readStringFromFile(fileName:String) -> String {
        let filePath = getDocumentDir().appendingPathComponent(fileName)
        
        do {
            let string = try String(contentsOf: filePath, encoding: .utf8)
            return string
        } catch {
            print("ERROR while reading \(fileName)")
        }
        return "empty"
    }
    
    func getDocumentDir() -> URL {
        let documentDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return documentDir[0]
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

