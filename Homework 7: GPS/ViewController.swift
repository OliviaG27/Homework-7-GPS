//
//  ViewController.swift
//  Homework 7: GPS
//
//  Created by Olivia Gennaro

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var distanceLabel: UILabel!
    
    let locMan: CLLocationManager = CLLocationManager()
    var startLocation: CLLocation!
    
    // Yakutsk Coordinates
    let yakutskLatitude: CLLocationDegrees = 62.0397
    let yakutskLongitude: CLLocationDegrees = 129.7422
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let newLocation: CLLocation=locations[0]
        NSLog("Somthing is happening")
        
        // horizontal accuracy less than 0 means failure at gps level
        if newLocation.horizontalAccuracy >= 0 {
            
            let yakutsk:CLLocation = CLLocation(latitude: yakutskLatitude, longitude: yakutskLongitude)
            
            let delta:CLLocationDistance = yakutsk.distance(from: newLocation)
            
            let miles: Double = (delta * 0.000621371) + 0.5
              // meters to rounded miles
            
            if miles < 3 {
                // Stop updating the location
                locMan.stopUpdatingLocation()
                // Congratulate the user
                distanceLabel.text = "Welcome to\nYakutsk!"
            } else {
                let commaDelimited: NumberFormatter = NumberFormatter()
                commaDelimited.numberStyle = NumberFormatter.Style.decimal
                
              distanceLabel.text=commaDelimited.string(from: NSNumber(value: miles))! + " miles"
            }
            
            
        }
        else {
            // add action if error with GPS
        }
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        locMan.delegate = self
        locMan.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        locMan.distanceFilter = 1609; // a mile (in meters)
        locMan.requestWhenInUseAuthorization() // verify access to gps
        locMan.startUpdatingLocation()
        startLocation = nil
    }


}
