//
//  FirstViewController.swift
//  Quarantine
//
//  Created by tobiasmidskard on 19/05/2020.
//  Copyright © 2020 tobiasmidskard. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet weak var newConfirmed: UILabel!
    @IBOutlet weak var newDeaths: UILabel!
    @IBOutlet weak var newRecovered: UILabel!
    @IBOutlet weak var totalConfirmed: UILabel!
    @IBOutlet weak var totalDeaths: UILabel!
    @IBOutlet weak var totalRecovered: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getCovidData()
    }
    
    func updateView(data : GlobalCovidData) {
        DispatchQueue.main.async {
            self.totalConfirmed.text = "Confirmed: \(data.totalConfirmed)"
            self.totalRecovered.text = "Recovered: \(data.totalRecovered)"
            self.totalDeaths.text = "Deaths: \(data.totalDeaths)"
            self.newConfirmed.text = "Confirmed: \(data.newConfirmed)"
            self.newDeaths.text = "Deaths: \(data.newDeaths)"
            self.newRecovered.text = "Recovered: \(data.newRecovered)"
        }
    }
    
    func getCovidData() {
        if let url = URL(string: "https://api.covid19api.com/summary") {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    do {
                        let res = try! JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary
                        if let global = res!["Global"] as? NSDictionary {
                            let dataObject = GlobalCovidData(newConfirmed: global["NewConfirmed"] as! Int, totalConfirmed: global["TotalConfirmed"] as! Int, newDeaths: global["NewDeaths"] as! Int, totalDeaths: global["TotalDeaths"] as! Int, newRecovered: global["NewRecovered"] as! Int, totalRecovered: global["TotalRecovered"] as! Int)
                            self.updateView(data: dataObject)
                            
                        }
                    
                    }
                }
            }.resume()
        }
    }


}

