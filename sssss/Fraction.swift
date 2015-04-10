//
//  Fraction.swift
//  mlib
//
//  Created by Hanghang Zhang on 2/22/15.
//  Copyright (c) 2015 Hanghang Zhang. All rights reserved.
//

import Foundation
class Fraction:Comparable {
    var a:Int=0;
    var b:Int=1;
    init(){}
    init(val:Double){}
    init(a:Int,b:Int){
        self.a=a;
        self.b=b;
    }
    var value:Double{
        get{return Double(a)/Double(b);}
        set{
            self.a=0;
            self.b=1;
        }
    }
    func reciprocal()->Fraction?{
        if(a==0){return nil;}
        else{return Fraction(a:b,b:a);}
    }
    func reduction(){
        a=a/GCD(a,b);
        b=b/GCD(a,b);
    }
}
func print(Object:Fraction){
    print("\(Object.a)/\(Object.b)")
}
func+(right:Fraction,left:Fraction)->Fraction{
    var a:Int = LCM(right.b,left.b)/right.b;
    var b:Int = LCM(right.b,left.b)/left.b;
    return Fraction(a: right.a*a+left.a*b,b: LCM(right.b,left.b));
}
func-(right:Fraction,left:Fraction)->Fraction{
    return right+(left)*Fraction(a:-1,b:1);
}
func*(right:Fraction,left:Fraction)->Fraction{
    return Fraction(a:right.a*left.a,b:right.b*left.b);
}
func/(right:Fraction,left:Fraction)->Fraction{
    return right * left.reciprocal()!;
}
func>(right:Fraction,left:Fraction)->Bool{
    return right.value>left.value;
}
func<(right:Fraction,left:Fraction)->Bool{
    return right.value<left.value;
}
func==(right:Fraction,left:Fraction)->Bool{
    return right.value==left.value;
}