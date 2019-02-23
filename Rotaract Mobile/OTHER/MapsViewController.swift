//
//  MapsViewController.swift
//  Rotaract Mobile
//
//  Created by Jonathan Gurusinghe on 7/11/18.
//  Copyright © 2018 Jonathan Gurusinghe. All rights reserved.
//

import UIKit
import GoogleMaps
import Firebase

class MapsViewController: UIViewController {
    
    var ref:DatabaseReference?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //setting the firebase reference
        ref = Database.database().reference()
        
        //listen from database and reference
        ref?.child("markers").observe(.value, with: { (snapshot) -> Void in
        
            let objName = snapshot.key
            print("key: \(objName)")
            let value = snapshot.value as? NSDictionary
            let title = value!["title"] as! String
            let snippet = value!["snippet"] as! String
            let longitude = value!["long"] as! Double
            let latitude = value!["lat"] as! Double
            
            //Location finding of longitude and latitude
            GMSServices.provideAPIKey("AIzaSyD__eSyKx0K2qc8LGEFcvi_ez6My6CVJ1Y")
            
            let camera = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: 20)
            let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
            self.view = mapView
            
            let currentLocation = CLLocationCoordinate2DMake(latitude, longitude)
            let marker = GMSMarker(position: currentLocation)
            marker.title = title
            marker.snippet = snippet
            marker.map = mapView
            mapView.settings.myLocationButton = true
            mapView.isMyLocationEnabled = true
            mapView.settings.zoomGestures = true
           
        })
    
        
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
