//
//  CenterViewController.swift
//  Beta
//
//  Created by 남기범 on 2018. 3. 25..
//  Copyright © 2018년 고정민. All rights reserved.
//

import UIKit
import GooglePlaces
import Alamofire
import GoogleMaps
import GooglePlaces

class CenterViewController: ViewController,UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count:Int = 0
        
        for var i in 0..<LocateInformation.count
        {
            if LocateInformation[i].lat != 0 && LocateInformation[i].lon != 0
            {
                count+=1
            }
        }
        print(count)
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell1 = tableView.dequeueReusableCell(withIdentifier: "resultcell", for: indexPath)
        
        
        tableView.rowHeight = (65*self.view.bounds.height)/568
        
        let userI = cell1.viewWithTag(9) as? UIImageView
        let shareI = cell1.viewWithTag(2) as? UIImageView
        
        userI?.image = usersImage[indexPath.row]
        shareI?.image = UIImage(named: "share1.png")!
        
        let textresult = cell1.viewWithTag(10) as? UILabel
        textresult?.text = "출발지:\(LocateInformation[indexPath.row].name)"
        
        return cell1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let LocateInforname = LocateInformation[indexPath.row].name.whiteSpacesRemoved()
        let sharetext = "[너와 나의 연결 거리]\n\(LocateInformation[indexPath.row].name) -> \(locatenamed)의 길찾기 결과입니다.\nhttp://m.map.naver.com/route.nhn?menu=route&sname=\(LocateInforname)&sx=\(LocateInformation[indexPath.row].lon)&sy=\(LocateInformation[indexPath.row].lat)&ename=\(locatenamed)&ex=\(lngC)&ey=\(latC)&pathType=1&showMap=true"
        
        let vc = UIActivityViewController(activityItems: [sharetext], applicationActivities: [])
        present(vc, animated: true)
        print(sharetext)
    }
    
    var centerP:Int=5
    var latC:Double=0.123
    var lngC:Double=0.324
    var locatenamed = ""
    @IBOutlet var googleMapContainer: UIView!
    var googleMapsView: GMSMapView!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        self.navigationController?.navigationBar.topItem?.title = ""
        self.viewDidAppear(true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.googleMapsView = GMSMapView(frame: self.googleMapContainer.frame)
        self.view.addSubview(self.googleMapsView)
        let position = CLLocationCoordinate2DMake(latC, lngC)
        let marker = GMSMarker(position: position)
        marker.map = self.googleMapsView
        marker.title = "중간지점 : \(locatenamed)"
        let camera = GMSCameraPosition.camera(withLatitude:latC, longitude: lngC, zoom: 15)
        self.googleMapsView.camera = camera
        print(locatenamed)
    }
    
    
}
extension String {
    func whiteSpacesRemoved() -> String {
        return self.filter { $0 != Character(" ") }
    }
}
