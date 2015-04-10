//
//  libC.swift
//  sssss
//
//  Created by Hanghang Zhang on 3/20/15.
//  Copyright (c) 2015 Hanghang Zhang. All rights reserved.
//

import Foundation
func+(right:Matrix,left:Matrix)->Matrix?{
    if(right.nor != left.nor || right.noc != left.noc){
        return nil;
    }
    var A:Array<Double>=Array<Double>();
    for(var i=0 ; i <= right.mat.endIndex ;i++){
        A.append(right.mat[i]+left.mat[i]);
    }
    return Matrix(r:right.nor,c:right.noc,m:A);
}
func-(right:Matrix,left:Matrix)->Matrix?{
    if(right.nor != left.nor || right.noc != left.noc){
        return nil;
    }
    var A:Array<Double>=Array<Double>();
    for(var i=0 ; i <= right.mat.endIndex ;i++){
        A.append(right.mat[i]-left.mat[i]);
    }
    return Matrix(r:right.nor,c:right.noc,m:A);
}
func*(right:Matrix,left:Matrix)->Matrix?{
    if(right.nor != left.noc){
        return nil;
    }
    var A:Array<Double>=Array<Double>();
    for(var i=1;i<=right.nor*left.noc;i++){
        var sum:Double=0;
        var a:Int = i%right.nor;
        if(a==0){
            a=right.nor;
        }
        var b:Int = (i-1)/left.noc + 1;
        for(var j=1;j<=left.nor;j++){
            sum += right.getE(b,c:j)*left.getE(j,c:a);
        }
        A.append(sum);
    }
    return Matrix(r:right.nor,c:left.noc,m:A);
}
func/(right:Matrix,left:Matrix)->Matrix?{return nil;}
func*(right:Double,left:Matrix)->Matrix?{
    var A:Array<Double>=Array<Double>();
    for(var i=0;i<=left.mat.endIndex;i++){
        A.append(right*left.mat[i]);
    }
    return Matrix(r:left.nor,c:left.noc,m:A);
}
func*(right:Matrix,left:Double)->Matrix?{
    return left*right;
}
func/(right:Matrix,left:Double)->Matrix?{
    return right*(1/left);
}


func+(right:Function?,left:Function?)->Function?{
    if(right==nil||left==nil){
        return nil;
    }else{
        return Add(a: right,b: left);
    }
}
func-(right:Function?,left:Function?)->Function?{
    if(right==nil||left==nil){
        return nil;
    }else{
        return Sub(a: right,b: left);
    }
}
func*(right:Function?,left:Function?)->Function?{
    if(right==nil||left==nil){
        return nil;
    }else{
        return Mul(a:right,b:left);
    }
}
func/(right:Function?,left:Function?)->Function?{
    if(right==nil||left==nil){
        return nil;
    }else{
        return Div(a:right,b:left);
    }
}
func^(right:Function?,left:Function?)->Function?{
    if(right==nil||left==nil){
        return nil;
    }else{
        return Pow(a:right,b:left);
    }
}
func integral(f:Function?,a:Double?,b:Double?)->Double{
    var sum:Double = 0;
    var ul:Double? = b;
    var ll:Double? = a;
    if(b==nil){ul=100000;}
    if(a==nil){ll = -100000;}
    for(var s=ll!;s<=ul!; s+=0.002){
        sum += 0.002*(f!.equ(s+0.001));
    }
    return sum;
}//definite integral
