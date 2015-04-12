//
//  libE.swift
//  sssss
//
//  Created by Hanghang Zhang on 4/12/15.
//  Copyright (c) 2015 Hanghang Zhang. All rights reserved.
//

import Foundation
func exprTransf(str:String,catalog:Array<String>,dic:Dictionary<String,String->String>,dicC:Dictionary<String,String>)->String{
    var cstr:String=str;
    var splitedStr = inputStrProcess(arrOfFunc+catalog,arrOfNum,str);
    var res:String="";
    for(var i:Int=0;i<count(splitedStr);i++){
        
        if(arrHas(catalog,splitedStr[i])){
            var toTrans:String=splitedStr[i];
            if(i+1<count(splitedStr) && arrHas(arrOfLBracket,splitedStr[i+1])){
                var para:String = splitedStr[i+1];
                i=i+2;
                var needR:Int = 1;
                while(needR != 0){
                    if(arrHas(arrOfLBracket,splitedStr[i])){needR++;}
                    else if(arrHas(arrOfRBracket,splitedStr[i])){needR--;}
                    para += splitedStr[i];
                    i++;
                }
                i--;
                res += dic[toTrans]!(para);
            }else{res += dicC[splitedStr[i]]!;}
        }else{res += splitedStr[i];}
    }
    return res;
}