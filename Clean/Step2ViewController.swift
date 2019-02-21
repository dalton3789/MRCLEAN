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
    
    @IBOutlet weak var map: MKMapView!
    
    
    let managerDelegate = CLLocationManager()
    var defaultLocation = CLLocation()
    var order = Order()
    
    var activityIndicator = CustomIndicator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        managerDelegate.delegate = self
        managerDelegate.desiredAccuracy = kCLLocationAccuracyBest
        managerDelegate.requestWhenInUseAuthorization()
        managerDelegate.startUpdatingLocation()
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dissmissInput)))
        
        /*
        activityIndicator.addIndicator(view: self, alpha: 0.8)
        activityIndicator.startIndicator()
        sleep(3)
        activityIndicator.stopIndicator(view: self)
         */
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    
    @IBAction func getCurrentLocation(_ sender: UIButton) {
        getAdressName(coords: defaultLocation)
        map.isHidden = false
    }
    
   
    @IBAction func done(_ sender: UIButton) {
       
        
        if validateAll() {
            order.address = txt_flatNum.text! + " , " + txt_flatName.text! + " , " + address.text!
            order.name = txt_name.text!
            order.phone = txt_phone.text!
            
            /*
             let request_content = ["email": "", "name": order.name, "phone":order.phone, "address" : order.address, "date":order.date, "startTime": "", "note" : order.note, "endTime" : order.totalTime, "total" : order.totalCost] as [String: Any]
             let link = Config.destination + "/function/createRequestBook.php"
             
             server.sendHTTPrequsetWithData(request_content, link)
             
             */
            order.AddUser(order.name, order.address, UUID().uuidString, order.phone, order.date, order.totalTime, order.totalCost, order.note)
            
            performSegue(withIdentifier: "segue_confirm", sender: self)
        }
        
        
      
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segue_confirm" {
            let view = segue.destination as! ConfirmBookingViewController
            view.order = order
            
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        defaultLocation = locations[0]
        
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.02)
        
        let myLocation = CLLocationCoordinate2D(latitude: defaultLocation.coordinate.latitude, longitude: defaultLocation.coordinate.longitude)
        
        let region = MKCoordinateRegionMake(myLocation, span)
        map.setRegion(region, animated: true)
        map.showsUserLocation = true
        
        
     
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
    
    func dissmissInput(){
        txt_name.resignFirstResponder()
        address.resignFirstResponder()
        txt_flatNum.resignFirstResponder()
        txt_flatName.resignFirstResponder()
        txt_phone.resignFirstResponder()
    }
    
    func validateAll() -> Bool {
        var isValid = true
        
        if ((txt_name.text?.isEmpty)!){
            showAlert(view: self, title: "Lỗi", alert: "Vui lòng nhập tên khách hàng")
            isValid = false
        }
        if ((txt_phone.text?.isEmpty)!){
            showAlert(view: self, title: "Lỗi", alert: "Vui lòng nhập số điện thoại")
            isValid = false
        }
        if ((address.text?.isEmpty)!){
            alertMain.message = "Vui lòng nhập địa chi"
            showAlert(view: self, title: "Lỗi", alert: "Vui lòng nhập địa chỉ")
            isValid = false
        }
        
        return isValid
    }
    
}
