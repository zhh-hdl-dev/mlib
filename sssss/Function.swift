//
//  Function.swift
//  mlib
//
//  Created by Hanghang Zhang on 2/21/15.
//  Copyright (c) 2015 Hanghang Zhang. All rights reserved.
//
import Foundation
import UIKit
class Function:Forma{
    var var1:Function?=nil;
    var var2:Function?=nil;
    var cons:Double=0;
    var type:String="";
    init(){}
    init(a:Function?,b:Function?){
        var1=a;
        var2=b;
    }
    init(a:Function?){
        var1=a;
    }
    init(a:Double){
        cons=a;
    }
    func d()->Function?{
        return nil;
    }
    func v()->(Double->Double)?{
        return nil;
    }
    func v()->((Double,Double)->Double)?{
        return nil;
    }
    func p()->String?{
        return nil;
    }
    func spp()->UIView?{
        var tfS=fontSize;
        fontSize=sfontSize;
        var res=pp();
        fontSize=tfS;
        return res;
    }
    func equ(v:Double)->Double{
        return 0;
    }
    func pp()->UIView?{
        return nil;
    }
}
class UniaryFunction:Function{
    override init(a:Function?){
        super.init(a:a);
    }
//    override func p(){
//        print(type);
//        var1!.p();
//    }
    override func equ(v: Double)->Double {
        return self.v()!(var1!.equ(v));
    }
    override func pp()->UIView?{
        var a = UILabel();
        var c = UILabel();
        c.text=")";
        a.text=type+"(";
        c.font = UIFont(name:"Courier",size:fontSize);
        a.font = UIFont(name:"Courier",size:fontSize);
        c.sizeToFit();
        a.sizeToFit();
        a.frame=CGRectMake(0,0,CGRectGetWidth(a.bounds),CGRectGetHeight(a.bounds));
        var res = UIView();
        var b = var1!.pp()!;
        b.frame.origin.x=a.frame.width;
        c.frame=CGRectMake(a.frame.width+b.frame.width,0,CGRectGetWidth(c.bounds),CGRectGetHeight(c.bounds));
        a.frame.origin.y=b.frame.height/2-a.frame.height/2;
        c.frame.origin.y=b.frame.height/2-c.frame.height/2;
        res.addSubview(a);
        res.addSubview(b);
        res.addSubview(c);
        res.sizeToFit();
        res.frame=CGRectMake(0,0,a.frame.width+b.frame.width+c.frame.width,b.frame.height);
        return res;
    }
}
class BinaryFunction:Function{
    override init(a:Function?,b:Function?){
        super.init(a:a,b:b);
    }
//    override func p(){
//        print(var1!.p());
//        print(type);
//        print(var2!.p());
//    }
    override func equ(v: Double) -> Double {
        return self.v()!(var1!.equ(v),var2!.equ(v));
    }
}
class TriangleFunction:UniaryFunction{
    override init(a:Function?){
        super.init(a:a);
    }
}
class EXP:UniaryFunction{
    override init(a:Function?) {
        super.init(a:a);
        self.type="exp";
    }
    override func v()->(Double->Double)?{
        return basic_EXP;
    }
    override func d()->Function?{
        return EXP(a:var1)*var1!.d();
    }
}
class LN:UniaryFunction{
    override init(a:Function?){
        super.init(a:a);
        self.type="ln";
    }
    override func v()->(Double->Double)?{
        return basic_LN;
    }
    override func d()->Function?{
        return var1!.d()/var1;
    }
}
//==================================
class Cons:Function{
    override init(a:Double){
        super.init(a:a);
        self.type="c";
    }
    override func d() -> Function?{
        return Cons(a:0);
    }
//    override func p(){
//        print(cons);
//    }
    override func equ(v:Double)->Double{
        return self.cons;
    }
    override func pp()->UIView?{
        var res = UILabel();
        res.text = String(format:"%.5f",cons);
        res.font = UIFont(name:"Courier",size:fontSize);
        res.sizeToFit();
        res.frame=CGRectMake(0,0,CGRectGetWidth(res.bounds),CGRectGetHeight(res.bounds));
        return res;
    }
}
class X:Function{
    override init(){
        super.init();
        self.type="x";
    }
    override func d()->Function?{
        return Cons(a:1);
    }
//    override func p(){
//        print("x");
//    }
    override func equ(v:Double)->Double{
        return v;
    }
    override func pp()->UIView?{
        var res = UILabel();
        res.text="x";
        res.font = UIFont(name:"Courier",size:fontSize);
        res.sizeToFit();
        res.frame=CGRectMake(0,0,CGRectGetWidth(res.bounds),CGRectGetHeight(res.bounds));
        return res;
    }
}




