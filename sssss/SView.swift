//
//  SView.swift
//  sssss
//
//  Created by Hanghang Zhang on 4/4/15.
//  Copyright (c) 2015 Hanghang Zhang. All rights reserved.
//

import Foundation
import UIKit

class SView{
    var arrOfUI:Array<UIView>=Array<UIView>();
    var arrOfFN:Array<String>=Array<String>();// name of function
    var arrOfMN:Array<String>=Array<String>();// name of matrix
    var arrOfSavingData:Array<String>=Array<String>();
    var scrollV:UIScrollView?;
    private var arrOfBC:Array<ButtonCreation>=Array<ButtonCreation>();//list of 'delete'
    init(scV:UIScrollView){scrollV=scV;}
    func getArrOfMN()->Array<String>{return arrOfMN;}
    func allRemoveAt(index:Int){
        arrOfUI.removeAtIndex(index);
        arrOfBC.removeAtIndex(index);
        arrOfMN.removeAtIndex(index);
        arrOfSavingData.removeAtIndex(index);
    }
    func getSavingData()->Array<String>{return arrOfSavingData;}
    func addL(str:String){
        arrOfBC.append(ButtonCreation(directorView:self));
        arrOfSavingData.append(str);
        var nView:UIView=UIView(frame:CGRectMake(0,0,200,24));
        var nLab:UILabel=UILabel(frame:CGRectMake(0,0,150,24));
        nLab.text=str;
        arrOfBC[count(arrOfBC)-1].createButton(nView);
        arrOfMN.append(str.componentsSeparatedByString(":")[0]);
        nView.addSubview(nLab);
        arrOfUI.append(nView);
        scrollV?.addSubview(nView);
        update();
    }
    func update(){for(var i:Int=0;i<count(arrOfUI);i++){arrOfUI[i].frame.origin.y=24*CGFloat(i);}}
}