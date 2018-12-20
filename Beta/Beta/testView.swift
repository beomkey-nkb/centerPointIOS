//
//  testView.swift
//  Beta
//
//  Created by 남기범 on 2018. 4. 30..
//  Copyright © 2018년 고정민. All rights reserved.
//

import GoogleMaps
import GooglePlaces
import GooglePlacePicker
import CoreLocation
import Alamofire

class testView: ViewController,GMSAutocompleteResultsViewControllerDelegate,GMSMapViewDelegate{
    
    @IBOutlet var googleMapContainer: UIView!
    var googleMapsView: GMSMapView!
    
    var resultsViewController: GMSAutocompleteResultsViewController?
    var searchController: UISearchController?
    var resultView: UITextView?
    
    var ButtonNumber : Int = 0
    var tmp = Locate(lat: 0, lon: 0, name: "")
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        self.googleMapsView = GMSMapView(frame: self.googleMapContainer.frame)
        self.view.addSubview(self.googleMapsView)
        
        let camera = GMSCameraPosition.camera(withLatitude: 37.6, longitude: 127, zoom: 15)
        self.googleMapsView.camera = camera
        self.googleMapsView.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initTitleNew()
        
        self.navigationController?.navigationBar.topItem?.title = ""
        
        resultsViewController = GMSAutocompleteResultsViewController()
        resultsViewController?.delegate = self
        
        searchController = UISearchController(searchResultsController: resultsViewController)
        searchController?.searchResultsUpdater = resultsViewController
        
        // Put the search bar in the navigation bar.
        searchController?.searchBar.sizeToFit()
        navigationItem.titleView = searchController?.searchBar
        
        // When UISearchController presents the results view, present it in
        // this view controller, not one further up the chain.
        definesPresentationContext = true
        
        // Prevent the navigation bar from being hidden when searching.
        searchController?.hidesNavigationBarDuringPresentation = false
    }
    
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
                           didAutocompleteWith place: GMSPlace) {
        searchController?.isActive = false
        // Do something with the selected place.
        self.tmp.name = place.name
        self.tmp.lat=place.coordinate.latitude
        self.tmp.lon=place.coordinate.longitude
        
        self.googleMapsView.clear()
        
        print("Place name: \(place.name)")
        print("Place address: \(place.formattedAddress)")
        print("Place attributions: \(place.attributions)")
        
        let position = CLLocationCoordinate2DMake(place.coordinate.latitude, place.coordinate.longitude)
        let marker = GMSMarker(position: position)
        
        let camera = GMSCameraPosition.camera(withLatitude: place.coordinate.latitude, longitude: place.coordinate.longitude, zoom: 15)
        self.googleMapsView.camera = camera
        
        marker.title = "검색주소 : \(place.name)"
        marker.map = self.googleMapsView

    }
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
                           didFailAutocompleteWithError error: Error){
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
    @IBAction func moveData(_ sender: Any) {
        LocateInformation[ButtonNumber-1]=tmp
        _=navigationController?.popViewController(animated: true)
    }
    var resultname:String = ""
    
    func mapView(_ mapView: GMSMapView, didLongPressAt coordinate: CLLocationCoordinate2D) {
        self.googleMapsView.clear()
        
        let geoURL="https://maps.googleapis.com/maps/api/geocode/json?latlng=\(coordinate.latitude),\(coordinate.longitude)&key=AIzaSyC7MxwCmb6tRPL0jj9gPJIbFxC7QwZhPCI"
        let call1 = Alamofire.request(geoURL,method:.post, encoding: URLEncoding.httpBody, headers: [:]).responseJSON { (response) in
            if let jsonObject = response.result.value as? [String: Any]
            {
                if let res = jsonObject["results"] as? [[String:Any]]
                {
                    for resIndex in res{
                        self.resultname = resIndex["formatted_address"] as! String
                        break
                    }
                }
            }
            print(self.resultname)
            
            self.tmp.name = self.resultname
            self.tmp.lat=coordinate.latitude
            self.tmp.lon=coordinate.longitude
            
            let clickposition = CLLocationCoordinate2DMake(coordinate.latitude, coordinate.longitude)
            let clickmarker = GMSMarker(position: clickposition)
            
            let clickcamera = GMSCameraPosition.camera(withLatitude: coordinate.latitude, longitude: coordinate.longitude, zoom: 15)
            self.googleMapsView.camera = clickcamera
            
            clickmarker.title = "검색주소 : \(self.resultname)"
            clickmarker.map = self.googleMapsView
        }
        
    }
    
}
