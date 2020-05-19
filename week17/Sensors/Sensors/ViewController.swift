//
//  ViewController.swift
//  Sensors
//
//  Created by tobiasmidskard on 19/05/2020.
//  Copyright © 2020 tobiasmidskard. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {

    @IBOutlet weak var stepsLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var paceLabel: UILabel!
    @IBOutlet weak var startStopButton: UIButton!
    
    let sensor = CMPedometer()
    
    var running = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stepsLabel.text = "steps =  0"
        distanceLabel.text = "distance =  0"
        paceLabel.text = "pace = 0"
        startStopButton.setTitle("Start", for: .normal)
    }

    @IBAction func startStopButton(_ sender: UIButton) {
        if running {
            running = false
            startStopButton.setTitle("Stop", for: .normal)
            sensor.stopUpdates()
        } else {
            running = true
            startStopButton.setTitle("Stop", for: .normal)
            sensor.startUpdates(from: Date()) { (data, error) in
                DispatchQueue.main.async {
                    self.stepsLabel.text = "steps = \(data?.numberOfSteps ?? 0.0)"
                    self.distanceLabel.text = "distance = \(data?.distance?.intValue ?? 0) m."
                    self.paceLabel.text = "pace = \(((data?.currentPace?.doubleValue ?? 0.0) * 3.6).rounded()) km/t"
                }
            }
        }
    }
    
}

