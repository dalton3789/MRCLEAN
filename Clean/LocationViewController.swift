//
//  LocationViewController.swift
//  Clean
//
//  Created by Nguyen, Toan on 2/23/19.
//  Copyright © 2019 James. All rights reserved.
//

import UIKit
import MapKit

class LocationViewController: UIViewController, CLLocationManagerDelegate {

    
    let managerDelegate = CLLocationManager()
    var defaultLocation = CLLocation()
    
    @IBOutlet weak var map: MKMapView!
    
    @IBOutlet weak var txt_location: UITextField!
    
    @IBOutlet weak var txt_flatNum: UITextField!
    
    @IBOutlet weak var txt_flatName: UITextField!
    
    @IBOutlet weak var btn_select: UIButton!
    
    var activityIndicator = CustomIndicator()
    
    let shareActions = SharedFunctions()
    
    let globalVariables = GlobalValues()
    
    var passDelegate : PassData?
    
    var location = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.addIndicator(view: self, alpha: 1)
        activityIndicator.startIndicator()
       
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dissmissInput)))
        
        managerDelegate.delegate = self
        managerDelegate.desiredAccuracy = kCLLocationAccuracyBest
        managerDelegate.requestWhenInUseAuthorization()
        managerDelegate.startUpdatingLocation()
        
        
        shareActions.roundBorder(control: txt_location, width: 1, color: UIColor.clear.cgColor , radius: 10)
        shareActions.roundBorder(control: txt_flatNum, width: 1, color: UIColor.clear.cgColor , radius: 10)
        shareActions.roundBorder(control: txt_flatName, width: 1, color: UIColor.clear.cgColor , radius: 10)
        
        

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func selectLocation(_ sender: UIButton) {
        if !(txt_flatNum.text?.isEmpty)! {
            location = txt_flatNum.text! + " , "
        }
        if !(txt_flatName.text?.isEmpty)! {
            location += txt_flatName.text! + " , "
        }
        location += txt_location.text!
        
        UserDefaults.standard.set(location, forKey: globalVariables.user_address)
        navigationController?.popViewController(animated: true)
        passDelegate?.passData(data: "Done")
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        defaultLocation = locations[0]
        
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.02)
        
        let myLocation = CLLocationCoordinate2D(latitude: defaultLocation.coordinate.latitude, longitude: defaultLocation.coordinate.longitude)
        
        let region = MKCoordinateRegionMake(myLocation, span)
        map.setRegion(region, animated: true)
        map.showsUserLocation = true
        getAdressName(coords: defaultLocation)
        
        
        
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
                
                self.txt_location.text = address
                self.activityIndicator.stopIndicator()
                
            }
        })
    }


    func dissmissInput(){
        txt_flatNum.resignFirstResponder()
        txt_flatName.resignFirstResponder()
        txt_location.resignFirstResponder()
    }
}
