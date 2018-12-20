//
//  ViewCustom.swift
//  Beta
//
//  Created by 남기범 on 2018. 4. 1..
//  Copyright © 2018년 고정민. All rights reserved.
//

import Foundation
import UIKit

class ViewCustom:UIView{
    required init(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)!
        
        self.layer.cornerRadius = 10
    }
}
class ButtonCustom:UIButton{
    required init(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)!
        
        self.layer.cornerRadius = 10
    }
}

class ImageViewCustom:UIImageView{
    required init(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)!
        
        self.layer.cornerRadius = 10
        if #available(iOS 11.0, *) {
            self.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        } else {
            // Fallback on earlier versions
        }
        self.layer.masksToBounds=true
    }
}

class mainButtonCustom:UIButton{
    required init(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)!
        
        self.layer.cornerRadius = 15
    }
}
