//
//  thirdViewcontroller.swift
//  Beta
//
//  Created by 남기범 on 2017. 11. 23..
//  Copyright © 2017년 고정민. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import GooglePlacePicker
import CoreLocation

class thirdViewcontroller: UIViewController, UISearchBarDelegate , LocateOnTheMap,GMSAutocompleteFetcherDelegate,CLLocationManagerDelegate{
    
    var ButtonNumber : Int = 0
    var tmp = Locate(lat: 0, lon: 0, name: "")
    
    /**
     * Called when an autocomplete request returns an error.
     * @param error the error that was received.
     */
    public func didFailAutocompleteWithError(_ error: Error) {
        //        resultText?.text = error.localizedDescription
    }
    
    /**
     * Called when autocomplete predictions are available.
     * @param predictions an array of GMSAutocompletePrediction objects.
     */
    public func didAutocomplete(with predictions: [GMSAutocompletePrediction]) {
        //self.resultsArray.count + 1
        
        for prediction in predictions {
            
            if let prediction = prediction as GMSAutocompletePrediction!{
                self.resultsArray.append(prediction.attributedFullText.string)
            }
        }
        self.searchResultController.reloadDataWithArray(self.resultsArray)
        //   self.searchResultsTable.reloadDataWithArray(self.resultsArray)
        print(resultsArray)
    }
    
    @IBOutlet var googleMapContainer: UIView!
    
    var googleMapsView: GMSMapView!
    var searchResultController: SearchResultsController!
    var resultsArray = [String]()
    var gmsFetcher: GMSAutocompleteFetcher!
    var locationManager:CLLocationManager!
    
    
    override func viewDidLoad(){
        super.viewDidLoad()
        self.initTitleNew()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        self.googleMapsView = GMSMapView(frame: self.googleMapContainer.frame)
        self.view.addSubview(self.googleMapsView)
        
        let camera = GMSCameraPosition.camera(withLatitude: 37.6, longitude: 127, zoom: 15)
        self.googleMapsView.camera = camera
        searchResultController = SearchResultsController()
        searchResultController.delegate = self
        gmsFetcher = GMSAutocompleteFetcher()
        gmsFetcher.delegate = self
    }
    
    func initTitleNew()
    {
        //컨테이너 네비게이션바 메인
        let containerView = UIView(frame:CGRect(x:0,y:0,width:200,height:36))
        
        let topTitle = UILabel(frame:CGRect(x:0,y:0,width:200,height:36))
        topTitle.numberOfLines = 1
        topTitle.textAlignment = .center
        topTitle.font = UIFont.systemFont(ofSize: 20)
        topTitle.textColor = UIColor.white
        topTitle.text = "CenterPoint"
        
        containerView.addSubview(topTitle)
        
        self.navigationItem.titleView = containerView
    }
    /**
     action for search location by address
     
     - parameter sender: button search location
     */
    @IBAction func searchWithAddress(_ sender: Any) {
        let searchController = UISearchController(searchResultsController: searchResultController)
        
        searchController.searchBar.delegate = self
        
        self.present(searchController, animated:true, completion: nil)
        
        
    }
    
    /**
     Locate map with longitude and longitude after search location on UISearchBar
     
     - parameter lon:   longitude location
     - parameter lat:   latitude location
     - parameter title: title of address location
     */
    func locateWithLongitude(_ lon: Double, andLatitude lat: Double, andTitle title: String) {
        DispatchQueue.main.async { () -> Void in
            
            let position = CLLocationCoordinate2DMake(lat, lon)
            let marker = GMSMarker(position: position)
            
            let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: lon, zoom: 15)
            self.googleMapsView.camera = camera
            
            marker.title = "검색주소 : \(title)"
            marker.map = self.googleMapsView
            
            //데이터값 받음
            self.tmp.lat=lat
            self.tmp.lon=lon
            self.tmp.name=title
            
        }
    }
    
    @IBAction func MoveData(_ sender: Any) {
        LocateInformation[ButtonNumber-1]=tmp
        _=navigationController?.popViewController(animated: true)
    }
    /**
     Searchbar when text change
     
     - parameter searchBar:  searchbar UI
     - parameter searchText: searchtext description
     */
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.resultsArray.removeAll()
        gmsFetcher?.sourceTextHasChanged(searchText)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    
}



