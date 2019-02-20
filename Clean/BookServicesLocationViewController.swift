//
//  BookServicesLocationViewController.swift
//  Clean
//
//  Created by Nguyen, Toan on 2/19/19.
//  Copyright © 2019 James. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class BookServicesLocationViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var map: MKMapView!
    
    let managerDelegate = CLLocationManager()
    var defaultLocation = CLLocation()
    var addressL = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        managerDelegate.delegate = self
        managerDelegate.desiredAccuracy = kCLLocationAccuracyBest
        managerDelegate.requestWhenInUseAuthorization()
        managerDelegate.startUpdatingLocation()
    }
    

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        defaultLocation = locations[0]
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.02)
        
        let myLocation = CLLocationCoordinate2D(latitude: defaultLocation.coordinate.latitude, longitude: defaultLocation.coordinate.longitude)
        
        let region = MKCoordinateRegionMake(myLocation, span)
        
        map.setRegion(region, animated: true)
        
        getAdressName(coords: defaultLocation)
        map.showsUserLocation = true
    }
    
  
    @IBAction func getAddress(_ sender: UIButton) {
        getAdressName(coords: defaultLocation)
       // print("the address is : " + self.addressL)
    }
    
    func getAdressName(coords: CLLocation) {
     let geo = CLGeocoder()
        var address = ""
        
        geo.reverseGeocodeLocation(coords, completionHandler: {(placemark, error) -> Void in
            if error != nil {
                print("Failed")
                return
            }
            if ((placemark?.count)!) > 0 {
                let pm = placemark?[0] as! CLPlacemark!
               // self.addressL = (pm?.subThoroughfare)! + " " + (pm?.thoroughfare)! + (pm?.locality)! + "," + (pm?.administrativeArea)! + " " + (pm?.postalCode)! + " " + (pm?.isoCountryCode)!
                
                //address = (pm?.subLocality)! + " " + (pm?.thoroughfare)! + " " + (pm?.locality)! + "," + (pm?.isoCountryCode)! + " " + (pm?.administrativeArea)!
                
                if pm?.subThoroughfare != nil {
                    address += (pm?.subThoroughfare)! + " "
                }
                if pm?.thoroughfare != nil {
                    address += (pm?.thoroughfare)! + " , "
                }
                if pm?.subLocality != nil {
                    address += (pm?.subLocality)! + " , "
                }
                
                if pm?.subAdministrativeArea != nil {
                    address += (pm?.subAdministrativeArea)! + " , "
                }
                if pm?.administrativeArea != nil {
                    address += (pm?.administrativeArea)! 
                }
                
                print(address)
                
            }
        })
    }

}
