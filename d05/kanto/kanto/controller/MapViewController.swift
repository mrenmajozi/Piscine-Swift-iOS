//
//  MapViewController.swift
//  kanto
//
//  Created by Njabulo MAJOZI on 2018/10/08.
//  Copyright © 2018 mrenmajozi. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    private let ecole42Coordinates: [CLLocationDegrees] = [48.8966491, 2.31834989999993]
    var locationManager = CLLocationManager()
    var placeLocation:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.requestLocationAccess()
        self.setPlacesOfInterest()
        self.setPosition(latitude: ecole42Coordinates[0], logitude: ecole42Coordinates[1], title: "Ecole 42", subtitle: "Private, nonprofit and tuition-free computer programming school.")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if let _chosenPlaceLocation = placeLocation {
            self.forwardGeocode(address: _chosenPlaceLocation, display: true)
        } else {
            self.setPosition(latitude: ecole42Coordinates[0], logitude: ecole42Coordinates[1], title: "Ecole 42", subtitle: "Private, nonprofit and tuition-free computer programming school.")
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
    private func requestLocationAccess() {
        if CLLocationManager.authorizationStatus() != .authorizedWhenInUse {
            self.locationManager.requestWhenInUseAuthorization()
        }
        
        if CLLocationManager.locationServicesEnabled() {
            self.locationManager.delegate = self
            self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            self.locationManager.distanceFilter = 10
            self.locationManager.startUpdatingHeading()
        }
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
     * CHANGE MAP TYPE
     */
    @IBAction func mapSegmentedControlAction(_ sender: UISegmentedControl) {
        switch (sender.selectedSegmentIndex) {
        case 0:
            self.mapView.mapType = MKMapType.standard
        case 1:
            self.mapView.mapType = MKMapType.satellite
        default:
            self.mapView.mapType = MKMapType.hybrid
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
     * PLACES OF INTEREST
     */
    private func setPlacesOfInterest(){
        DispatchQueue.global(qos: .background).async {
            for _address in KantoData.getPlaces() {
                self.forwardGeocode(address: _address, display: false)
            }
        }
    }
    
    /*
     * GEOCODE
     */
    private func forwardGeocode(address _address: String, display _display: Bool) {
        DispatchQueue.global(qos: .background).async {
            let _geocoder = CLGeocoder()
            _geocoder.geocodeAddressString(_address) { (placemarks, error) in
                if let error = error {
                    print("Unable to Forward Geocode Address (\(error))")
                    print("Unable to Find Location for Address")
                } else {
                    if let _placemarks = placemarks, _placemarks.count > 0 {
                        if let _name = _placemarks.first?.name, let _country = _placemarks.first?.country, let _coordinate = _placemarks.first?.location?.coordinate {
                            
                            if _display {
                                self.setPosition(latitude: _coordinate.latitude, logitude: _coordinate.longitude, title: _name, subtitle: _country)
                            } else {
                                self.setAnnotation(latitude: _coordinate.latitude, logitude: _coordinate.longitude, title: _name, subtitle: _country)
                            }
                        }
                    }
                }
            }
        }
    }
    
    private func reverseGeocode(latitude _latitude: CLLocationDegrees, logitude _longitude: CLLocationDegrees) -> [String] {
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: _latitude, longitude: _longitude)
        var content:[String] = ["Current Location", ""]
        
        geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
            // Place details
            var placeMark: CLPlacemark!
            placeMark = placemarks?[0]
            
            if let city = placeMark.subAdministrativeArea, let country = placeMark.country {
                content[0] = city
                content[1] = country
            }
        })
        
        return content
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension MapViewController: CLLocationManagerDelegate {
    /*
     * EVENT: LOCATION UPDATE
     ** Get User Current Location
     ** Stop Generation of User Current Location
     ** Update map region
     */
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Map Location Displayed Updated")
        
        let _currentUserLocation:CLLocation = locations[0] as CLLocation
        self.locationManager.stopUpdatingLocation()
        
        let _currentUserLocationData = self.reverseGeocode(latitude: _currentUserLocation.coordinate.latitude, logitude:  _currentUserLocation.coordinate.longitude)
        
        self.setPosition(latitude: _currentUserLocation.coordinate.latitude, logitude:  _currentUserLocation.coordinate.longitude, title: _currentUserLocationData[0], subtitle: _currentUserLocationData[1])
    }
}

extension MapViewController: MKMapViewDelegate {
    /*
    * CHANGE ANNOTATION PIN
     */
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "AnnotationView")
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "AnnotationView")
        }
    
        annotationView?.image = UIImage(named: KantoData.getRandomPin())
        annotationView?.canShowCallout = true
        
        return annotationView
    }
    
    /*
     * EVENT: ANNOTATION CLICK
     */
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print("Annotation Selected: \(String(describing: view.annotation?.title))")
    }
}

