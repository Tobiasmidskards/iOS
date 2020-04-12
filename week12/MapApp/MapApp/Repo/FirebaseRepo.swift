//
//  FirebaseRepo.swift
//  MapApp
//
//  Created by tobiasmidskard on 12/04/2020.
//  Copyright © 2020 tobiasmidskard. All rights reserved.
//

import Foundation
import FirebaseFirestore
import MapKit

class FirebaseRepo {
    
    private static let db = Firestore.firestore()
    private static let path = "locations"
    
    static func startListener(vc: ViewController) {
        print("Listener started")
        db.collection(path).addSnapshotListener { (snap, error) in
            
            if error != nil {
                return
            }
            
            var markers = [MKPointAnnotation]()
            
            for doc in snap!.documents {
                let map  = doc.data()
                let text = map["text"] as! String
                let geoPoint = map["coordinates"] as! GeoPoint
                let mkAnnotation = MKPointAnnotation()
                mkAnnotation.title = text
                let coordinate = CLLocationCoordinate2D(latitude: geoPoint.latitude, longitude: geoPoint.longitude)
                mkAnnotation.coordinate = coordinate
                markers.append(mkAnnotation)
            }
            vc.updateMarkers(markers: markers)
        }
        
    }
    
}
