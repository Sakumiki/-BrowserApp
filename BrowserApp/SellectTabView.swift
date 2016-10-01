//
//  SellectTabView.swift
//  BrowserApp
//
//  Created by Tatsuo Yamashita on 2016/09/15.
//  Copyright © 2016年 Sakumiki. All rights reserved.
//

import UIKit

class SellectTabView: UIView {

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.customViewCommonInit()
    }
    
    func customViewCommonInit(){
        let view = Bundle.main.loadNibNamed("SellectTabView", owner: self, options: nil)?.first as! UIView
        view.frame = self.bounds
        view.autoresizingMask = [UIViewAutoresizing.flexibleWidth,UIViewAutoresizing.flexibleHeight]
        self.addSubview(view)
    }

}
