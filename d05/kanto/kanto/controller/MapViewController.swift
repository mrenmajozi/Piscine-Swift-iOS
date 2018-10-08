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

class MapViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var mapView: MKMapView!
    private let ecole42Coordinates: [CLLocationDegrees] = [48.8966491, 2.31834989999993]
    var locationManager = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        setInitialPosition(latitude: ecole42Coordinates[0], logitude: ecole42Coordinates[1])
        setAnnotation(latitude: ecole42Coordinates[0], logitude: ecole42Coordinates[1], title: "Ecole 42", subtitle: "Private, nonprofit and tuition-free computer programming school.")
    }
    
    /*
     * SETUP
     ** Request Geolocation access
     ** Delegate to receive events updates
     ** Accuracy of data
     ** Minimum meters to start updating
     ** Start generation of updates
     */
    private func setUp() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.distanceFilter = 10
        locationManager.startUpdatingHeading()
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
    private func setInitialPosition(latitude _latitude: CLLocationDegrees, logitude _longitude: CLLocationDegrees){
        let _location = CLLocation(latitude: _latitude, longitude: _longitude)
        let _regionRadius: CLLocationDistance = 100
        let _coordinateRegion = MKCoordinateRegionMakeWithDistance(_location.coordinate, _regionRadius, _regionRadius)
        mapView.setRegion(_coordinateRegion, animated: true)
    }
    
    /*
     * Set Annotation
     ** Coordinate
     ** Title
     ** Subtitle
     */
    private func setAnnotation(latitude _latitude: CLLocationDegrees, logitude _longitude: CLLocationDegrees, title _title: String, subtitle _subtitle: String) {
        let _annotation = MKPointAnnotation()
        let _centerCoordinate = CLLocationCoordinate2D(latitude: _latitude, longitude: _longitude)
        _annotation.coordinate = _centerCoordinate
        _annotation.title = _title
        _annotation.subtitle = _subtitle
        mapView.addAnnotation(_annotation)
    }
    
    /*
     * CHANGE MAP TYPE
     */
    @IBAction func mapSegmentedControlAction(_ sender: UISegmentedControl) {
        switch (sender.selectedSegmentIndex) {
        case 0:
            mapView.mapType = MKMapType.standard
        case 1:
            mapView.mapType = MKMapType.satellite
        default:
            mapView.mapType = MKMapType.hybrid
        }
    }
    
    /*
     * GEOLOCATE USER
     ** 
     */
    @IBAction func currentLocationAction(_ sender: UIButton) {
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

