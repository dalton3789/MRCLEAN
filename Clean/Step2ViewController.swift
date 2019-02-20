//
//  Step2ViewController.swift
//  Clean
//
//  Created by Nguyen, Toan on 2/20/19.
//  Copyright © 2019 James. All rights reserved.
//

import UIKit
import MapKit

class Step2ViewController: UIViewController,CLLocationManagerDelegate {
    
    
    @IBOutlet weak var txt_name: UITextField!
    
    @IBOutlet weak var address: UITextField!
    
    @IBOutlet weak var txt_flatNum: UITextField!
    
    @IBOutlet weak var txt_flatName: UITextField!
    
    @IBOutlet weak var txt_phone: UITextField!
    
    
    let managerDelegate = CLLocationManager()
    var defaultLocation = CLLocation()
    var order = Order()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        managerDelegate.delegate = self
        managerDelegate.desiredAccuracy = kCLLocationAccuracyBest
        managerDelegate.requestWhenInUseAuthorization()
        managerDelegate.startUpdatingLocation()
        
        
        
    }
    
    
    
    @IBAction func getCurrentLocation(_ sender: UIButton) {
        getAdressName(coords: defaultLocation)
    }
    
   
    @IBAction func done(_ sender: UIButton) {
        
        order.address = txt_flatNum.text! + " , " + txt_flatName.text! + " , " + address.text!
        order.name = txt_name.text!
        order.phone = txt_phone.text!
        
        performSegue(withIdentifier: "segue_confirm", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segue_confirm" {
            let view = segue.destination as! ConfirmBookingViewController
            view.order = order
            
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        defaultLocation = locations[0]
        /*
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.02)
        
        let myLocation = CLLocationCoordinate2D(latitude: defaultLocation.coordinate.latitude, longitude: defaultLocation.coordinate.longitude)
        
        let region = MKCoordinateRegionMake(myLocation, span)
        */
        
     
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
                
                self.address.text = address
                
            }
        })
    }
    
}
