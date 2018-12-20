//
//  Second1ViewController.swift
//  Beta
//
//  Created by 남기범 on 2018. 2. 12..
//  Copyright © 2018년 고정민. All rights reserved.
//

import UIKit
import Alamofire

struct Locate{
    var lat:Double = 0
    var lon:Double = 0
    var name:String
}

var usersImage: [UIImage] = [
    UIImage(named: "user1.png")!,
    UIImage(named: "user2.png")!,
    UIImage(named: "user3.png")!,
    UIImage(named: "user4.png")!,
    UIImage(named: "user5.png")!,
    UIImage(named: "user6.png")!
]

var share = UIImage(named: "whitesearch.png")!

class UIRoundPrimaryButton: UIButton{
    required init(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)!;
        self.layer.cornerRadius = 5.0;
        self.backgroundColor = UIColor(red: 255/255, green: 132/255, blue: 102/255, alpha: 1);
        self.tintColor = UIColor.white
    }
}

var tmp1 = Locate(lat: 0, lon: 0, name: "위치검색 ->")
var tmp2 = Locate(lat: 0, lon: 0, name: "위치검색 ->")
var tmp3 = Locate(lat: 0, lon: 0, name: "위치검색 ->")
var tmp4 = Locate(lat: 0, lon: 0, name: "위치검색 ->")
var tmp5 = Locate(lat: 0, lon: 0, name: "위치검색 ->")
var tmp6 = Locate(lat: 0, lon: 0, name: "위치검색 ->")

var LocateInformation = [tmp1,tmp2,tmp3,tmp4,tmp5,tmp6]

//****************** json 객체
struct loca{
    var lat:Double = 0
    var lng:Double = 0
}

var lolo = loca(lat:0,lng:0)

var locat = [loca]()
var locatename = [String]()
var testname = ""
//******************
//***json 파싱 변환 객체 배열
var named = [String:Any]()
var retun = [String:Any]()

class Second1ViewController: UITableViewController,UIAlertViewDelegate{
    
    var BNumber:Int = 3
    var centerLocation = Locate(lat: 0, lon: 0, name: "중간지점")
    var x:Int = 0
    var sumLat:Double = 0
    var sumLon:Double = 0
    var pLat:Double = 0
    var pLon:Double = 0
    var distance=Array<Double>()
    var minDistance:Double = 0
    var CenterNumber:Int = 0
    var latCenter:Double=0
    var lngCenter:Double=0
    var textd="선택"
    
    
    override func viewDidLoad(){
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.topItem?.title = ""
        self.initTitleNew()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initTitleNew()
    {
        
        let containerView = UIView(frame:CGRect(x:0,y:0,width:200,height:36))
        
        let topTitle = UILabel(frame:CGRect(x:0,y:0,width:200,height:36))
        topTitle.numberOfLines = 1
        topTitle.textAlignment = .center
        topTitle.font = UIFont.systemFont(ofSize: 20)
        topTitle.textColor = UIColor.white
        topTitle.text = "연결거리"
        
        containerView.addSubview(topTitle)
        
        self.navigationItem.titleView = containerView
    }
    
    @IBAction func didreSelect(_ sender: Any) {
        let alert = UIAlertView(
            title: "선택",
            message: "인원을 선택해주세요",
            delegate:self,
            cancelButtonTitle:"취소",
            otherButtonTitles:"2명","3명","4명","5명","6명"
        )
        alert.show()
    }
    
    func alertView(_ alertView: UIAlertView, clickedButtonAt buttonIndex: Int) {
        
        switch buttonIndex{
        case alertView.cancelButtonIndex:
            self.viewWillAppear(false)
            break
        case 1 :
            textd = "2명"
            LocateInformation[2].lat = 0
            LocateInformation[2].lon = 0
            LocateInformation[2].name = "위치검색 ->"
            LocateInformation[3].lat = 0
            LocateInformation[3].lon = 0
            LocateInformation[3].name = "위치검색 ->"
            LocateInformation[4].lat = 0
            LocateInformation[4].lon = 0
            LocateInformation[4].name = "위치검색 ->"
            LocateInformation[5].lat = 0
            LocateInformation[5].lon = 0
            LocateInformation[5].name = "위치검색 ->"
            self.viewWillAppear(false)
            break
        case 2 :
            textd = "3명"
            LocateInformation[3].lat = 0
            LocateInformation[3].lon = 0
            LocateInformation[3].name = "위치검색 ->"
            LocateInformation[4].lat = 0
            LocateInformation[4].lon = 0
            LocateInformation[4].name = "위치검색 ->"
            LocateInformation[5].lat = 0
            LocateInformation[5].lon = 0
            LocateInformation[5].name = "위치검색 ->"
            self.viewWillAppear(false)
            break
        case 3 :
            textd = "4명"
            LocateInformation[4].lat = 0
            LocateInformation[4].lon = 0
            LocateInformation[4].name = "위치검색 ->"
            LocateInformation[5].lat = 0
            LocateInformation[5].lon = 0
            LocateInformation[5].name = "위치검색 ->"
            self.viewWillAppear(false)
            break
        case 4 :
            textd = "5명"
            LocateInformation[5].lat = 0
            LocateInformation[5].lon = 0
            LocateInformation[5].name = "위치검색 ->"
            self.viewWillAppear(false)
            break
        case 5 :
            textd = "6명"
            self.viewWillAppear(false)
            break
        default:
            textd = "선택"
            self.viewWillAppear(false)
            break
        }
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        //1번화면에서 선택한 명수에 따라 객체를 갯수에 맞게 표시
        
        
        print(self.view.bounds.height)
        tableView.rowHeight = self.view.bounds.height
        let user1 = cell.viewWithTag(101) as? UIImageView
        let user2 = cell.viewWithTag(102) as? UIImageView
        let user3 = cell.viewWithTag(103) as? UIImageView
        let user4 = cell.viewWithTag(104) as? UIImageView
        let user5 = cell.viewWithTag(105) as? UIImageView
        let user6 = cell.viewWithTag(106) as? UIImageView
        
        let detail1 = cell.viewWithTag(107) as? UILabel
        detail1?.text = LocateInformation[0].name
        let detail2 = cell.viewWithTag(108) as? UILabel
        detail2?.text = LocateInformation[1].name
        let detail3 = cell.viewWithTag(109) as? UILabel
        detail3?.text = LocateInformation[2].name
        let detail4 = cell.viewWithTag(110) as? UILabel
        detail4?.text = LocateInformation[3].name
        let detail5 = cell.viewWithTag(111) as? UILabel
        detail5?.text = LocateInformation[4].name
        let detail6 = cell.viewWithTag(112) as? UILabel
        detail6?.text = LocateInformation[5].name
        
        let button1 = cell.viewWithTag(113) as? UIButton
        let button2 = cell.viewWithTag(114) as? UIButton
        let button3 = cell.viewWithTag(115) as? UIButton
        let button4 = cell.viewWithTag(116) as? UIButton
        let button5 = cell.viewWithTag(117) as? UIButton
        let button6 = cell.viewWithTag(118) as? UIButton
        
        let reSelect = cell.viewWithTag(277) as? UIButton
        
        
        let selectView = cell.viewWithTag(197) as? UIView
        let view1 = cell.viewWithTag(171) as? UIView
        let view2 = cell.viewWithTag(172) as? UIView
        let view3 = cell.viewWithTag(173) as? UIView
        let view4 = cell.viewWithTag(174) as? UIView
        let view5 = cell.viewWithTag(175) as? UIView
        let view6 = cell.viewWithTag(176) as? UIView
        
        if textd == "선택"{
            reSelect?.setTitle("선택", for: .normal)
            user1?.isHidden = true
            user2?.isHidden = true
            user3?.isHidden = true
            user4?.isHidden = true
            user5?.isHidden = true
            user6?.isHidden = true
            
            detail1?.isHidden = true
            detail2?.isHidden = true
            detail3?.isHidden = true
            detail4?.isHidden = true
            detail5?.isHidden = true
            detail6?.isHidden = true
            
            button1?.isHidden = true
            button2?.isHidden = true
            button3?.isHidden = true
            button4?.isHidden = true
            button5?.isHidden = true
            button6?.isHidden = true
            
            view1?.isHidden = true
            view2?.isHidden = true
            view3?.isHidden = true
            view4?.isHidden = true
            view5?.isHidden = true
            view6?.isHidden = true
        }
        else if textd == "2명"{
            reSelect?.setTitle("2명", for: .normal)
            
            user1?.isHidden = false
            user2?.isHidden = false
            user3?.isHidden = true
            user4?.isHidden = true
            user5?.isHidden = true
            user6?.isHidden = true
            
            detail1?.isHidden = false
            detail2?.isHidden = false
            detail3?.isHidden = true
            detail4?.isHidden = true
            detail5?.isHidden = true
            detail6?.isHidden = true
            
            button1?.isHidden = false
            button2?.isHidden = false
            button3?.isHidden = true
            button4?.isHidden = true
            button5?.isHidden = true
            button6?.isHidden = true
            
            view1?.isHidden = false
            view2?.isHidden = false
            view3?.isHidden = true
            view4?.isHidden = true
            view5?.isHidden = true
            view6?.isHidden = true
        }
        else if textd == "3명"{
            reSelect?.setTitle("3명", for: .normal)
            
            user1?.isHidden = false
            user2?.isHidden = false
            user3?.isHidden = false
            user4?.isHidden = true
            user5?.isHidden = true
            user6?.isHidden = true
            
            detail1?.isHidden = false
            detail2?.isHidden = false
            detail3?.isHidden = false
            detail4?.isHidden = true
            detail5?.isHidden = true
            detail6?.isHidden = true
            
            button1?.isHidden = false
            button2?.isHidden = false
            button3?.isHidden = false
            button4?.isHidden = true
            button5?.isHidden = true
            button6?.isHidden = true
            
            view1?.isHidden = false
            view2?.isHidden = false
            view3?.isHidden = false
            view4?.isHidden = true
            view5?.isHidden = true
            view6?.isHidden = true
        }
        else if textd == "4명"{
            reSelect?.setTitle("4명", for: .normal)
            
            user1?.isHidden = false
            user2?.isHidden = false
            user3?.isHidden = false
            user4?.isHidden = false
            user5?.isHidden = true
            user6?.isHidden = true
            
            detail1?.isHidden = false
            detail2?.isHidden = false
            detail3?.isHidden = false
            detail4?.isHidden = false
            detail5?.isHidden = true
            detail6?.isHidden = true
            
            button1?.isHidden = false
            button2?.isHidden = false
            button3?.isHidden = false
            button4?.isHidden = false
            button5?.isHidden = true
            button6?.isHidden = true
            
            view1?.isHidden = false
            view2?.isHidden = false
            view3?.isHidden = false
            view4?.isHidden = false
            view5?.isHidden = true
            view6?.isHidden = true
        }
        else if textd == "5명"{
            reSelect?.setTitle("5명", for: .normal)
            
            user1?.isHidden = false
            user2?.isHidden = false
            user3?.isHidden = false
            user4?.isHidden = false
            user5?.isHidden = false
            user6?.isHidden = true
            
            detail1?.isHidden = false
            detail2?.isHidden = false
            detail3?.isHidden = false
            detail4?.isHidden = false
            detail5?.isHidden = false
            detail6?.isHidden = true
            
            button1?.isHidden = false
            button2?.isHidden = false
            button3?.isHidden = false
            button4?.isHidden = false
            button5?.isHidden = false
            button6?.isHidden = true
            
            view1?.isHidden = false
            view2?.isHidden = false
            view3?.isHidden = false
            view4?.isHidden = false
            view5?.isHidden = false
            view6?.isHidden = true
        }
        else if textd == "6명"{
            reSelect?.setTitle("6명", for: .normal)
            
            user1?.isHidden = false
            user2?.isHidden = false
            user3?.isHidden = false
            user4?.isHidden = false
            user5?.isHidden = false
            user6?.isHidden = false
            
            detail1?.isHidden = false
            detail2?.isHidden = false
            detail3?.isHidden = false
            detail4?.isHidden = false
            detail5?.isHidden = false
            detail6?.isHidden = false
            
            button1?.isHidden = false
            button2?.isHidden = false
            button3?.isHidden = false
            button4?.isHidden = false
            button5?.isHidden = false
            button6?.isHidden = false
            
            view1?.isHidden = false
            view2?.isHidden = false
            view3?.isHidden = false
            view4?.isHidden = false
            view5?.isHidden = false
            view6?.isHidden = false
        }
        else
        {
            
        }
        
        return cell
    }
    
    //몇번째 버튼인지 데이터값을 넘겨줌
    @IBAction func Button1action(_ sender: Any) {
        BNumber = 1
        performSegue(withIdentifier: "Manual", sender: self)
    }
    
    @IBAction func Button2action(_ sender: Any) {
        BNumber = 2
        performSegue(withIdentifier: "Manual", sender: self)
    }
    
    @IBAction func Button3action(_ sender: Any) {
        BNumber = 3
        performSegue(withIdentifier: "Manual", sender: self)
    }
    
    @IBAction func Button4action(_ sender: Any) {
        BNumber = 4
        performSegue(withIdentifier: "Manual", sender: self)
    }
    
    @IBAction func Button5action(_ sender: Any) {
        BNumber = 5
        performSegue(withIdentifier: "Manual", sender: self)
    }
    
    @IBAction func Button6action(_ sender: Any) {
        BNumber = 6
        performSegue(withIdentifier: "Manual", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let rvc = segue.destination as? testView{
            rvc.ButtonNumber = BNumber
        }
    }
    
    //마지막 화면에서 돌아왔을 때 다시 로딩
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()

        locat.removeAll()
        named.removeAll()
        retun.removeAll()
        distance.removeAll()
        sumLat=0
        sumLon=0
        pLon=0
        pLat=0
    }
    
    
    //**************json 파싱 및 화면전환
    
    @IBAction func SearchButton(_ sender: Any) {
        
        if let uvc = self.storyboard!.instantiateViewController(withIdentifier: "CenterViewController") as? CenterViewController{
            
            var count:Int = 0
            var textdsave:Int = 0
            
            for var i in 0..<LocateInformation.count
            {
                if LocateInformation[i].lat == 0 && LocateInformation[i].lon == 0
                {
                    count+=1
                }
            }
            
            if textd == "2명"
            {
                textdsave = 2
            }
            else if textd == "3명"
            {
                textdsave = 3
            }
            else if textd == "4명"
            {
                textdsave = 4
            }
            else if textd == "5명"
            {
                textdsave = 5
            }
            else if textd == "6명"
            {
                textdsave = 6
            }
            
            print(count)
            
            if LocateInformation.count-count == textdsave
            {
                if textd == "2명"
                {
                    for var i in 0..<2{
                        sumLat += LocateInformation[i].lat
                        sumLon += LocateInformation[i].lon
                    }
                
                    pLat = sumLat/2.0
                    pLon = sumLon/2.0
                    //좌표상으로의 중간값 구하기 아직 구현 놉
                }
                else if textd == "3명"
                {
                    for var i in 0..<3{
                        sumLat += LocateInformation[i].lat
                        sumLon += LocateInformation[i].lon
                    }
                
                    pLat = sumLat/3.0
                    pLon = sumLon/3.0
                }
                else if textd == "4명"
                {
                    for var i in 0..<4{
                        sumLat += LocateInformation[i].lat
                        sumLon += LocateInformation[i].lon
                    }
                
                    pLat = sumLat/4.0
                    pLon = sumLon/4.0
                }
                else if textd == "5명"
                {
                    for var i in 0..<5{
                        sumLat += LocateInformation[i].lat
                        sumLon += LocateInformation[i].lon
                    }
                
                    pLat = sumLat/5.0
                    pLon = sumLon/5.0
                }
                else if textd == "6명"
                {
                    for var i in 0..<6{
                        sumLat += LocateInformation[i].lat
                        sumLon += LocateInformation[i].lon
                    }
                
                    pLat = sumLat/6.0
                    pLon = sumLon/6.0
                }
                print(pLat)
                print(pLon)
                let url = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=\(pLat),\(pLon)&radius=10000&type=subway_station&key=AIzaSyC7MxwCmb6tRPL0jj9gPJIbFxC7QwZhPCI"
                let call = Alamofire.request(url,method:.post, encoding: URLEncoding.httpBody, headers: [:]).responseJSON { (response) in//response로 json 값을 받아옴
                    locatename.removeAll()
                    if let jsonObject = response.result.value as? [String: Any]{
                        if let res = jsonObject["results"] as? [[String:Any]]{//결과값을 객체 배열로 파싱
                            var lala = loca(lat:0,lng:0)
                            for resIndex in res{
                                named = resIndex["geometry"] as! [String:Any]//키 값 geometry 기준으로 객체 배열에 파싱
                                testname = resIndex["name"] as! String
                                retun = named["location"] as! [String:Any]//location 기준으로 객체 배열에 파싱
                                lala = loca(lat:retun["lat"] as! Double,lng:retun["lng"] as! Double)
                                //retun배열 에있는 키값들을 loca 구조체에 넣어줌
                                locat.append(lala)//loca로 이루어진 객체배열 locat에 값을 넣어줌
                                locatename.append(testname)
                            }
                            print(locatename)
                        }
                    
                        for var i in 0..<locat.count{
                            self.distance.append(sqrt((locat[i].lat-self.pLat)*(locat[i].lat-self.pLat)+(locat[i].lng-self.pLon)*(locat[i].lng-self.pLon)))
                        }
                    
                        self.minDistance = self.distance[0]
                    
                        for var i in 0..<self.distance.count{
                        
                            if self.minDistance>self.distance[i]
                            {
                                self.minDistance=self.distance[i]
                                self.CenterNumber=i
                            }
                        
                        }
                        self.latCenter = locat[self.CenterNumber].lat
                        self.lngCenter = locat[self.CenterNumber].lng
                        uvc.latC = self.latCenter
                        uvc.lngC = self.lngCenter
                        uvc.locatenamed = locatename[self.CenterNumber]
                    
                        uvc.centerP = self.CenterNumber
                        //화면을 전환할 에니메이션 정의
                        uvc.modalTransitionStyle = UIModalTransitionStyle.coverVertical
                        //인자값으로 받은 뷰 컨트롤러로 화면 전환
                        self.navigationController?.pushViewController(uvc, animated: true)
                    }
                }
            }
            else if LocateInformation.count-count != textdsave
            {
                let alerted = UIAlertView(
                    title: "지도검색",
                    message: "모든 인원의 위치가 확인되지 않았습니다.",
                    delegate:self,
                    cancelButtonTitle:"취소"
                )
                alerted.show()
            }
        }
    }

    
}
extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}
