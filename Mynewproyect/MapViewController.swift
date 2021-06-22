//
//  MapViewController.swift
//  Mynewproyect
//
//  Created by Alexis Omar Marquez Castillo on 13/04/21.
//  Copyright © 2021 udacity. All rights reserved.
//

import UIKit
import MapKit
import CoreData
import CoreLocation
class MapViewController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var labelDelete: UILabel!
    @IBOutlet weak var pinDelete: UIButton!
    @IBOutlet weak var mapView: MKMapView!
 
    
    var deletedPin : Bool?
    let locationManager = CLLocationManager()
    let regionMeters: Double = 10000
    let myAnnotation: MKPointAnnotation = MKPointAnnotation()
    let newPin = MKPointAnnotation()

    @IBAction func pinDelete(_ sender: Any) {
        if labelDelete.isHidden == !isEditing {
                   labelDelete.isHidden = false
                   deletedPin = true
                   
               }else{
                   if labelDelete.isHidden == isEditing{
                       labelDelete.isHidden = true
                       deletedPin = false
                       
                       
                       
                   }
               }
    }

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       checkLocationService()
        
    
    }
    func setUpLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    func centerUserLocation(){
        if let location = locationManager.location?.coordinate{
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionMeters, longitudinalMeters: regionMeters)
            mapView.setRegion(region, animated: true)
        }
    }
    
    func checkLocationService() {
        if CLLocationManager.locationServicesEnabled(){
            setUpLocationManager()
        }else{
            //Muestra alerta
        }
    }

    func checkLocationAutorization(){
        switch CLLocationManager.authorizationStatus(){
        case .authorizedWhenInUse:
            mapView.showsUserLocation = true
            centerUserLocation()
            locationManager.startUpdatingLocation()
        case .denied:
            // Muestra alerta deciendo que de permiso a la app
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            // Muestra alerta diciendo que sucede
            break
        case .authorizedAlways:
            break
       
        }
    }


    func locationUser(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        mapView.removeAnnotation(newPin)

        let location = locations.last! as CLLocation

        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))

        //set region on the map
        mapView.setRegion(region, animated: true)

        newPin.coordinate = location.coordinate
        mapView.addAnnotation(newPin)
    
    let longPress = UILongPressGestureRecognizer(target: self, action: #selector(MapViewController.mapLongPress(_:))) // colon needs to pass through info
       longPress.minimumPressDuration = 1.5 // in seconds
       //add gesture recognition
       mapView.addGestureRecognizer(longPress)
}


   // func called when gesture recognizer detects a long press

    @objc func mapLongPress(_ recognizer: UIGestureRecognizer) {

       print("A long press has been detected.")

       let touchedAt = recognizer.location(in: self.mapView) // adds the location on the view it was pressed
       let touchedAtCoordinate : CLLocationCoordinate2D = mapView.convert(touchedAt, toCoordinateFrom: self.mapView) // will get coordinates

       let newPin = MKPointAnnotation()
       newPin.coordinate = touchedAtCoordinate
       mapView.addAnnotation(newPin)
   func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

       let location = locations.last! as CLLocation

       let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
       let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))




       //set region on the map
       self.mapView.setRegion(region, animated: true)



   }
    
   }
}

extension MapViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {return}
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region =  MKCoordinateRegion.init(center: center, latitudinalMeters: regionMeters, longitudinalMeters: regionMeters)
        mapView.setRegion(region, animated: true)
        }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAutorization()
    }

}
