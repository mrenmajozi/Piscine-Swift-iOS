//
//  MainViewController.swift
//  Rush 01 Plan 42
//
//  Created by Njabulo MAJOZI on 2018/10/13.
//  Copyright © 2018 Njabulo MAJOZI. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import MapboxGeocoder
import MapboxDirections
import MapboxCoreNavigation
import MapboxNavigation

class MainViewController: UIViewController, MKMapViewDelegate {
    private let geocoder = Geocoder(accessToken: "pk.eyJ1IjoibXJlbm1ham96aSIsImEiOiJjam41ank3ZGgzcXlnM3BxeWltOG80YmI3In0.K-6yKKNPjW2der9PqohRyA")
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var originTextField: UITextField!
    @IBOutlet weak var destinationTextField: UITextField!
    @IBOutlet weak var operationType: UIButton!
    
    
    private let locationManager:CLLocationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupLocationManager()
    }
    
    private func alertMessage(title _title: String, message _message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: _title, message: _message, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                switch action.style{
                case .default:
                    print("default")
                    
                case .cancel:
                    print("cancel")
                    
                case .destructive:
                    print("destructive")
                }}))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    /*
     * SETUP
     ** Request Geolocation access
     ** Delegate to receive events updates
     ** Accuracy of data
     ** Minimum meters to start updating
     ** Start generation of updates
     */
    private func setupMapView() {
        self.mapView.delegate = self
        self.mapView.showsScale = true
        self.mapView.showsPointsOfInterest = true
        self.mapView.showsUserLocation = true
    }
    
    private func setupLocationManager() {
        setupMapView()
        if CLLocationManager.authorizationStatus() != .authorizedWhenInUse {
            self.locationManager.requestWhenInUseAuthorization()
        }
        
        if CLLocationManager.locationServicesEnabled() {
            self.locationManager.delegate = self
            self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
            self.locationManager.distanceFilter = 10
            self.locationManager.startUpdatingHeading()
        }
    }
    
    /*
     * WIDGETS FUNCTIONS
     ** DESTINATION DROP DOWN
     */
    @IBAction func destinationInputViewAction(_ sender: UIButton) {
        if sender.currentImage == UIImage(named: "down-arrow") {
            self.originTextField.placeholder = "Origin Place"
            self.destinationTextField.isHidden = false
            sender.setImage(UIImage(named: "up-arrow"), for: UIControlState.normal)
            self.operationType.setTitle("NAVIGATE", for: UIControlState.normal)
        } else {
            self.originTextField.placeholder = "Search Place"
            self.destinationTextField.isHidden = true
            sender.setImage(UIImage(named: "down-arrow"), for: UIControlState.normal)
            self.operationType.setTitle("SEARCH", for: UIControlState.normal)
        }
    }
    
    
    /*
     * SEARCH OR NAVIGATE
     */
    @IBAction func searchOrNavigateAction(_ sender: UIButton) {
        if sender.currentTitle == "SEARCH" {
            print("SEARCH")
            let _searchAddress = self.originTextField?.text!
            if (_searchAddress?.count)! > 0 {
                let _originOptions = ForwardGeocodeOptions(query: _searchAddress!)
                let _originTask = geocoder.geocode(_originOptions) { (placemarks, attribution, error) in
                    guard let placemark = placemarks?.first else {
                        self.alertMessage(title: "ORIGIN ADDRESS ERROR", message: "Origin place doesnt exist")
                        return
                    }
                    print("ORIGIN FORWARD GEOCODE: DONE")
                    print(placemark.name)
                    print(placemark.qualifiedName!)
                    
                    let coordinate = placemark.location?.coordinate
                    print("\(coordinate?.latitude), \(coordinate?.longitude)")
                    #if !os(tvOS)
                        let formatter = CNPostalAddressFormatter()
                        print(formatter.string(from: placemark.postalAddress!))
                    #endif
                    self.setPosition(latitude: (coordinate?.latitude)!, logitude: (coordinate?.longitude)!, title: _searchAddress!, subtitle: "")
                }
            } else {
                self.alertMessage(title: "ORIGIN ADDRESS ERROR", message: "Please enter origin address")
            }
        } else {
            print("NAVIGATE")
            self.navigate()
        }
    }
    
    
    /*
     * GEOLOCATE USER
     ** Start Generation of User Current Location
     */
    @IBAction func currentLocationAction(_ sender: UIButton) {
        self.getCurrentLocation()
    }
    
    private func getCurrentLocation() {
        print("Get Current Location")
        self.locationManager.startUpdatingLocation()
    }
    
    /*
     * SET POSITION REGION
     ** Coordinate Region
     *** Location Coodinates
     **** Latitude
     **** Longitude
     *** Latitude Meters Radius
     *** Longitude Meters Radius
     */
    private func setPosition(latitude _latitude: CLLocationDegrees, logitude _longitude: CLLocationDegrees, title _title: String, subtitle _subtitle: String){
        let _location = CLLocation(latitude: _latitude, longitude: _longitude)
        let _regionRadius: CLLocationDistance = 1000
        let _coordinateRegion = MKCoordinateRegionMakeWithDistance(_location.coordinate, _regionRadius, _regionRadius)
        self.mapView.setRegion(_coordinateRegion, animated: true)
        self.setAnnotation(latitude: _latitude, logitude: _longitude, title: _title, subtitle: _subtitle)
    }
    
    /*
     * SET ANNOTATION
     ** Coordinate
     ** Title
     ** Subtitle
     */
    private func setAnnotation(latitude _latitude: CLLocationDegrees, logitude _longitude: CLLocationDegrees, title _title: String, subtitle _subtitle: String) {
        let _annotation = MKPointAnnotation()
        _annotation.coordinate = CLLocationCoordinate2D(latitude: _latitude, longitude: _longitude)
        _annotation.title = _title
        _annotation.subtitle = _subtitle
        self.mapView.addAnnotation(_annotation)
    }
    
    /*
     * GEOCODE
     */
    private func navigate() {
        print("ORIGIN FORWARD GEOCODE: ENTER")
        
        let _originAddress = self.originTextField?.text!
        if (_originAddress?.count)! > 0 {
            let _originOptions = ForwardGeocodeOptions(query: _originAddress!)
            let _originTask = geocoder.geocode(_originOptions) { (placemarks, attribution, error) in
                guard let placemark = placemarks?.first else {
                    self.alertMessage(title: "ORIGIN ADDRESS ERROR", message: "Origin place doesnt exist")
                    return
                }
                print("ORIGIN FORWARD GEOCODE: DONE")
                print(placemark.name)
                print(placemark.qualifiedName!)
                
                let coordinate = placemark.location?.coordinate
                print("\(coordinate?.latitude), \(coordinate?.longitude)")
                #if !os(tvOS)
                let formatter = CNPostalAddressFormatter()
                print(formatter.string(from: placemark.postalAddress!))
                #endif
                
                self.destinationForwardGeocode(originCoordinates: [(coordinate?.latitude)!, (coordinate?.longitude)!])
            }
        } else {
            self.alertMessage(title: "ORIGIN ADDRESS ERROR", message: "Please enter origin address")
        }
    }
    
    private func destinationForwardGeocode(originCoordinates _originCoordinates: [CLLocationDegrees]?) {
        print("DESTINATION FORWARD GEOCODE: ENTER")
        
        if let _destinationAddress = self.destinationTextField.text {
            let _destinationOptions = ForwardGeocodeOptions(query: _destinationAddress)
            let _destinationTask = geocoder.geocode(_destinationOptions) { (placemarks, attribution, error) in
                guard let placemark = placemarks?.first else {
                    self.alertMessage(title: "DESTINATION ADDRESS ERROR", message: "Destination place doesnt exist")
                    return
                }
                print("DESTINATION FORWARD GEOCODE: DONE")
                print(placemark.name)
                print(placemark.qualifiedName!)
                
                let coordinate = placemark.location?.coordinate
                print("\(coordinate?.latitude), \(coordinate?.longitude)")
                
                
                #if !os(tvOS)
                    let formatter = CNPostalAddressFormatter()
                    print(formatter.string(from: placemark.postalAddress!))
                #endif
                self.directions(placemarks: [_originCoordinates!, [(coordinate?.latitude)!, (coordinate?.longitude)!]])
            }
        } else {
            self.alertMessage(title: "DESTINATION ADDRESS ERROR", message: "Please enter destination address")
        }
    }
    
    func directions(placemarks _placemarks: [[CLLocationDegrees]]) {
        print("NAVIGATE: ENTER")
        let _originLatitude = _placemarks[0][0]
        let _originLongitude = _placemarks[0][1]
        let _destinationLatitude = _placemarks[1][0]
        let _destinationLongitude = _placemarks[1][1]
        
        print("NAVIGATE: COORDINATE EXIST")
        
        let origin = Waypoint(coordinate: CLLocationCoordinate2D(latitude: _originLatitude, longitude: _originLongitude), name: "Origin")
        let destination = Waypoint(coordinate: CLLocationCoordinate2D(latitude: _destinationLatitude, longitude: _destinationLongitude), name: "Destination")
        let options = NavigationRouteOptions(waypoints: [origin, destination])
        
        print("NAVIGATE: PROCESS")
        Directions.shared.calculate(options) { (waypoints, routes, error) in
            guard let route = routes?.first else {
                self.alertMessage(title: "NAVIGATION ERROR", message: "Can't navigate to specified addresses")
                return
            }
            print("NAVIGATE: DONE")
            let navigationViewController = NavigationViewController.init(for: route)
            self.present(navigationViewController, animated: true, completion: nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension MainViewController: CLLocationManagerDelegate {
    /*
     * EVENT: LOCATION UPDATE
     ** Get User Current Location
     ** Stop Generation of User Current Location
     ** Update map region
     */
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Map Location Displayed Updated")
        
        let _currentUserLocation:CLLocation = locations[0] as CLLocation
        
        self.mapView.removeAnnotations(self.mapView.annotations)
        
        self.setPosition(latitude: _currentUserLocation.coordinate.latitude, logitude:  _currentUserLocation.coordinate.longitude, title: "Current Location", subtitle: "")
    }
}

//extension MainViewController: MKMapViewDelegate {
//    /*
//     * CHANGE ANNOTATION PIN
//     */
//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "AnnotationView")
//
//        if annotationView == nil {
//            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "AnnotationView")
//        }
//
//        annotationView?.image = UIImage(named: "pin")
//        annotationView?.canShowCallout = true
//
//        return annotationView
//    }
//
//    /*
//     * EVENT: ANNOTATION CLICK
//     */
//    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
//        print("Annotation Selected: \(String(describing: view.annotation?.title))")
//    }
//}

