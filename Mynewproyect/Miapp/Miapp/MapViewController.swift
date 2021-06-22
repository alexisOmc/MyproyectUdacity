//
//  MapViewController.swift
//  Miapp
//
//  Created by Alexis Omar Marquez Castillo on 28/04/21.
//  Copyright © 2021 udacity. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
   checkLocationService()
    
    }
    func setUpLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
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
}
extension MapViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // voy
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        // voy
    }
}

