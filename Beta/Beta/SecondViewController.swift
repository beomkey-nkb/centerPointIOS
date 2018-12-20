//
//  SecondViewController.swift
//  Beta
//
//  Created by 남기범 on 2017. 9. 15..
//  Copyright © 2017년 고정민. All rights reserved.
//

import UIKit

class SecondViewController : UIViewController,UITableViewDataSource,UITableViewDelegate{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultText.text = textd
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if textd == "1명"{
            return 1
        }
        else if textd == "2명"{
            return 2
        }
        else if textd == "3명"{
            return 3
        }
        else if textd == "4명"{
            return 4
        }
        else if textd == "5명"{
            return 5
        }
        else if textd == "6명"{
            return 6
        }
        else
        {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let title = cell.viewWithTag(101) as? UILabel
        title?.text = "\(indexPath.row+1)user"
        
        let detail = cell.viewWithTag(102) as? UILabel
        detail?.text = "위치선택"
        return cell
    }
    
    var textd=""
    
    @IBOutlet weak var resultText: UILabel!
    
    @IBAction func backB(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
}
