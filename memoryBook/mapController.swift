//
//  mapController.swift
//  memoryBook
//
//  Created by Cody Miller on 10/18/15.
//  Copyright © 2015 Cody Miller. All rights reserved.
//

import UIKit
import Parse
import CoreLocation
import MapKit
class MapViewViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet var mapView: MKMapView!
    
    var MapViewLocationManager:CLLocationManager! = CLLocationManager()
    var currentLoc: PFGeoPoint! = PFGeoPoint()
    
    var postTitle: String!
    var postBody: String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.showsUserLocation = true
        mapView.delegate = self
        MapViewLocationManager.delegate = self
        MapViewLocationManager.startUpdatingLocation()
        mapView.setUserTrackingMode(MKUserTrackingMode.Follow, animated: true)
    }
    
    override func viewDidAppear(animated: Bool) {
        var annotationQuery = PFQuery(className: "memory")
        currentLoc = PFGeoPoint(location: MapViewLocationManager.location)
        annotationQuery.whereKey("Location", nearGeoPoint: currentLoc, withinMiles: 10)
        annotationQuery.findObjectsInBackgroundWithBlock {
            (memorys, error) -> Void in
            if error == nil {
                // The find succeeded.
                print("Successful query for annotations")
                let myMemorys = memorys! as [PFObject]
                
                for memory in myMemorys {
                    let point = memory["Location"] as! PFGeoPoint
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = CLLocationCoordinate2DMake(point.latitude, point.longitude)
                    self.mapView.addAnnotation(annotation)
                }
            } else {
                // Log details of the failure
                print("Error: \(error)")
            }
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
   
}