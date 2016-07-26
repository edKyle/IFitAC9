//
//  MapViewController.swift
//  IFitAC9
//
//  Created by Kyle on 7/22/16.
//  Copyright © 2016 Alphacamp. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate{

    @IBOutlet weak var loadingLabel: UILabel!
    @IBOutlet weak var activityRun: UIActivityIndicatorView!
    @IBOutlet weak var MapView: MKMapView!
    static var theStoreUserTap:[String:String] = [:]
    
    var beginItem : MKMapItem?
    var destinationItem : MKMapItem?
    var storeAnnotationCoord :CLLocationCoordinate2D?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.MapView.delegate = self
        locationManger.delegate = self
        
        activityRun.hidden = true
        loadingLabel.hidden = true
        
    }
    override func viewWillAppear(animated: Bool) {
        putStoreOnMap()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    // 定位User
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let userLocation = locations.first
        
        let latDelta: CLLocationDegrees = 0.05
        let lonDelta: CLLocationDegrees = 0.05
        
        let span: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lonDelta)
        let location: CLLocationCoordinate2D = (userLocation?.coordinate)!
        
        let region: MKCoordinateRegion = MKCoordinateRegion(center: location, span: span)
        
        self.MapView.setRegion(region, animated: true)
        
        beginItem = MKMapItem(placemark: MKPlacemark(coordinate:location, addressDictionary: nil))
        destinationItem = MKMapItem(placemark: MKPlacemark(coordinate:storeAnnotationCoord!, addressDictionary: nil))
        
        loadDirection(beginItem!, destinationItem: destinationItem!, withTransportType: .Walking)
        
    }
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print(error)
    }
    
    // 將poly line 放入 overlay
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay)-> MKOverlayRenderer{
        if overlay is MKPolyline{
            let polylineRenderer = MKPolylineRenderer(overlay: overlay)
            polylineRenderer.strokeColor = UIColor.init(red: 255/255, green: 153/255, blue: 153/255, alpha: 1)
            polylineRenderer.lineWidth = 5
            
            activityRun.stopAnimating()
            activityRun.hidden = true
            loadingLabel.hidden = true
            
            return polylineRenderer
        }
        return MKPolygonRenderer()
        
    }
    
    @IBAction func goButton(sender: AnyObject) {
        
        self.activityRun.startAnimating()
        self.activityRun.hidden = false
        self.loadingLabel.hidden = false
        locationManger.requestLocation()
        self.MapView.showsUserLocation = true
        
    }
    
    // 放店家資訊在大頭針上
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "SpotPin"
        
        if annotation.isKindOfClass(MKUserLocation) {
            return nil
        }
        var annotationView: MKPinAnnotationView? = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier) as? MKPinAnnotationView
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            
            let storeImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
            storeImageView.image = UIImage(named: "iFit")
            storeImageView.contentMode = .ScaleAspectFit
            
            annotationView?.leftCalloutAccessoryView = storeImageView
            annotationView?.animatesDrop = true
            annotationView?.canShowCallout = true
        }
        return annotationView
    }
    
    
    // 放大頭針在地圖店家位置上 function
    func putStoreOnMap(){
        let annotation = MKPointAnnotation()
        annotation.title = MapViewController.theStoreUserTap["iFit shop"]
        annotation.coordinate = CLLocationCoordinate2D(latitude: Double(MapViewController.theStoreUserTap["lat"]!)!,longitude: Double(MapViewController.theStoreUserTap["long"]!)!)
        
        storeAnnotationCoord = annotation.coordinate
        self.MapView.addAnnotation(annotation)
        
        self.MapView.showAnnotations(self.MapView.annotations, animated: true)
    }
    
    //產生poly line function
    func loadDirection(beginItem:MKMapItem, destinationItem:MKMapItem, withTransportType transporType: MKDirectionsTransportType){
        
        let directionsRequest = MKDirectionsRequest()
        directionsRequest.source = beginItem
        directionsRequest.destination = destinationItem
        directionsRequest.transportType = transporType
        directionsRequest.requestsAlternateRoutes = false
        
        let calculateDirection = MKDirections(request: directionsRequest)
        calculateDirection.calculateDirectionsWithCompletionHandler { (response: MKDirectionsResponse?, error: NSError?) in
            if error == nil{
                if response?.routes != nil{
                    
                    for route in (response?.routes)!{
                        
                        self.MapView.removeOverlays(self.MapView.overlays)
                        self.MapView.addOverlay(route.polyline)
                        
                    }
                }
            }
        }
    }
}
