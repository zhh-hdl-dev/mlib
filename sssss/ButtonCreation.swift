//
//  ButtonCreation.swift
//  sssss
//
//  Created by Hanghang Zhang on 4/4/15.
//  Copyright (c) 2015 Hanghang Zhang. All rights reserved.
//

import Foundation
import UIKit
class ButtonCreation: NSObject {
    var act:(SView->Void)?=nil;
    private var director:SView?;
    init(directorView:SView){director = directorView;}
    func createButton(baseView: UIView) {
        var button:UIButton = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        button.frame = CGRectMake(150,0,50,24)
        button.setTitle("Delete", forState: UIControlState.Normal)
        button.addTarget(self, action: Selector("buttonTouched:"), forControlEvents: UIControlEvents.TouchUpInside)
        func temAct(directorView:SView){
            for(var i:Int=0;i<count(directorView.arrOfUI);i++){
                if(directorView.arrOfUI[i]==baseView){
                    directorView.arrOfUI[i].removeFromSuperview();
                    directorView.allRemoveAt(i);
                    directorView.update();
                    break;
                }
            }
        }
        act = temAct;
        baseView.addSubview(button);
    }
    func buttonTouched(sender: AnyObject){act?(director!);}
}