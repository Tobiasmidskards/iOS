//
//  ViewController.swift
//  MapApp
//
//  Created by tobiasmidskard on 12/04/2020.
//  Copyright © 2020 tobiasmidskard. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    @IBOutlet weak var myMap: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let marker = MKPointAnnotation()
        marker.title = "Go here"
        let location = CLLocationCoordinate2D(latitude: 55.7, longitude: 12.5)
        marker.coordinate = location
        myMap.addAnnotation(marker)
        
        FirebaseRepo.startListener(vc: self)
        
    }
    
    func updateMarkers(markers: [MKPointAnnotation]) {
        myMap.removeAnnotations(myMap.annotations)
        for marker in markers {
            myMap.addAnnotation(marker)
        }
    }
    
}

