//
//  ViewController.swift
//  Beta
//
//  Created by 고정민 on 2017. 9. 12..
//  Copyright © 2017년 고정민. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIAlertViewDelegate{

    @IBOutlet weak var CenterPoint: UILabel!
    @IBOutlet weak var Explain: UILabel!
    @IBOutlet weak var Message: UILabel!
    @IBOutlet weak var resultlabel: UILabel!
    

    @IBOutlet var selectedResult: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initTitleNew()
        // Do any additional setup after loading the view, typically from a nib.
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        application.statusBarStyle = .lightContent // .default
        return true
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
    
    @IBAction func didAlert(_ sender: Any) {
        let alert = UIAlertView(
            title: "인원 선택",
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
            self.selectedResult.setTitle("인원 선택", for: .normal)
            resultlabel.text = "인원 선택"
            break
        case 1 :
            self.selectedResult.setTitle("2명", for: .normal)
            resultlabel.text = "2명"
            break
        case 2 :
            self.selectedResult.setTitle("3명", for: .normal)
            resultlabel.text = "3명"
            break
        case 3 :
            self.selectedResult.setTitle("4명", for: .normal)
            resultlabel.text = "4명"
            break
        case 4 :
            self.selectedResult.setTitle("5명", for: .normal)
            resultlabel.text = "5명"
            break
        case 5 :
            self.selectedResult.setTitle("6명", for: .normal)
            resultlabel.text = "6명"
            break
        default:
            self.selectedResult.setTitle("인원 선택", for: .normal)
            resultlabel.text = "인원 선택"
            break
        }
    }
    
    @IBAction func onSubmit(_ sender: Any) {
        if let uvc = self.storyboard!.instantiateViewController(withIdentifier: "Second1ViewController") as? Second1ViewController{
            
            uvc.textd = self.resultlabel.text!
            
            LocateInformation[0].lat = 0
            LocateInformation[0].lon = 0
            LocateInformation[0].name = "위치검색 ->"
            LocateInformation[1].lat = 0
            LocateInformation[1].lon = 0
            LocateInformation[1].name = "위치검색 ->"
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
            
            //화면을 전환할 에니메이션 정의
            uvc.modalTransitionStyle = UIModalTransitionStyle.coverVertical
            //인자값으로 받은 뷰 컨트롤러로 화면 전환
            self.navigationController?.pushViewController(uvc, animated: true)
        }
    }
}

