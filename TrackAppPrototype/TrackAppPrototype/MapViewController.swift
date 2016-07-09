//
//  MapViewController.swift
//  TrackAppPrototype
//
//  Created by Melissa Boring on 7/9/16.
//  Copyright © 2016 melbo. All rights reserved.
//

import UIKit
import MapKit


class MapViewController: UIViewController,MKMapViewDelegate,CLLocationManagerDelegate,UIImagePickerControllerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
 

    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //must ask for permission to use location services
        //below combined with setting the NSLocationWhenInUseUsageDescription and NSLocationAlwaysUsageDescription keys in info.plist
        locationManager.delegate = self
        locationManager .requestWhenInUseAuthorization()
        locationManager .requestAlwaysAuthorization()
        
        mapView.delegate = self
        mapView.showsUserLocation = true
        mapView.showsPointsOfInterest = true
        
        //load locations which creates an array of annotations
        
        //set the mapView's annotations
        
        //but I also want to include POI -- Core Location?
    }
    
    // MARK : Map User location
    func mapView(mapView: MKMapView, didUpdateUserLocation userLocation: MKUserLocation) {

        let region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 800, 800)
        mapView .setRegion(region, animated: true)
        
        let melPointAnnotation = MKPointAnnotation()
        melPointAnnotation.coordinate = userLocation.coordinate
        melPointAnnotation.title = "Where is Mel?"
        melPointAnnotation.subtitle = "Mel is here!"
        
        mapView.addAnnotation(melPointAnnotation)
    }
    
    // MARK : Track
    @IBAction func trackLocation(sender: UIBarButtonItem) {

        //alert controller with image picker , camera , cancel actions
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .Alert)
        
        //photo action
        let photoAction = UIAlertAction(title: "Photo Library", style: .Default, handler: {
            action in
            
            let picker = UIImagePickerController()
            picker.sourceType = .PhotoLibrary
            self.presentViewController(picker, animated: true, completion: nil)
        })
        
        //camera action
        let cameraAction = UIAlertAction(title: "Camera", style: .Default, handler: {
            action in
            
            //check to see if camera is available (not available on simulator) and set the sourceType
            let isCameraAvailable = UIImagePickerController .isCameraDeviceAvailable(UIImagePickerControllerCameraDevice.Front)
            let cameraPicker = UIImagePickerController()
            
            cameraPicker.sourceType = (isCameraAvailable) ? .Camera : .PhotoLibrary
            
            self.presentViewController(cameraPicker, animated: true, completion: nil)
        })
        
        //cancel action
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        
        alertController.addAction(photoAction)
        alertController.addAction(cameraAction)
        alertController.addAction(cancelAction)
        
        presentViewController(alertController, animated: true, completion: nil)

    }

}
