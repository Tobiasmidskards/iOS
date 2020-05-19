//
//  SecondViewController.swift
//  Quarantine
//
//  Created by tobiasmidskard on 19/05/2020.
//  Copyright © 2020 tobiasmidskard. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var deathLabel: UILabel!
    
    let formatter = DateFormatter()
    var data = [DenmarkHistoryDay(Date: Date(), Deaths: 0)]
    var fetched = false
    var timer: Timer? = nil
    var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        getHistory()
    }
    
    @IBAction func startTimeLine(_ sender: UIButton) {
        if (timer == nil && fetched) {
            formatter.dateFormat = "MMM d, yyyy"
            self.timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) {
                // this is the code that the timer runs every second
                (_:Timer)->Void in //  the Timer object is passed in, but we ignore it
                self.index += 1 ; // increment the score
                self.dayLabel.text = self.formatter.string(from: self.data[self.index].Date)
                self.deathLabel.text = "Deaths: \(self.data[self.index].Deaths)"
                
                if (self.index >= self.data.count - 1) {
                    self.index = 0
                    self.timer?.invalidate()
                    self.timer = nil
                }
            }
        }
    }
    
    func setData(data : [Any]) {
        DispatchQueue.main.async {
            for dayDict in data {
                if let dict = dayDict as? [String: Any] {
                    if (dict["Province"] as? String == "") {
                        let date = dict["Date"] as! String
                        let deaths = dict["Deaths"] as! Int
                        
                        let dateFormatted = self.formatter.date(from: date)!
                        
                        let day = DenmarkHistoryDay(Date: dateFormatted, Deaths: deaths)
                        
                        self.data.append(day)
                        
                    }
                    
                }
            }
            self.fetched = true;
        }
    }
    
    func getHistory() {
        
        if let url = URL(string: "https://api.covid19api.com/dayone/country/denmark") {
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let httpResponse = response as? HTTPURLResponse,
                    (200...299).contains(httpResponse.statusCode) else {
                    return
                }
                
                if let data = data {
                    do {
                        let historyArray = try! JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions()) as? [Any]
                        
                        self.setData(data: historyArray!)
                    }
                }
                
            }.resume()
        }
    }

}

