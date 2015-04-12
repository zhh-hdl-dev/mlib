//
//  BinaryOperators.swift
//  sssss
//
//  Created by Hanghang Zhang on 3/20/15.
//  Copyright (c) 2015 Hanghang Zhang. All rights reserved.
//

import Foundation
import UIKit
class Add:BinaryFunction {
    override init(a:Function,b:Function){
        super.init(a:a,b:b);
        self.type="+";
    }
    override func v()->((Double,Double)->Double){return Addition;}
    override func d()->Function{return var1!.d()+var2!.d();}
    override func pp()->UIView{
        var v1:Function=var1!;
        var v2:Function=var2!;
        var a:UIView = v1.pp();
        var b:UIView = v2.pp();
        var h:CGFloat = max(a.frame.height,b.frame.height);
        var s:UILabel = UILabel();
        s.text="+";
        s.font = UIFont(name:"Courier",size:fontSize);
        s.sizeToFit();
        s.frame=CGRectMake(a.frame.width,0,CGRectGetWidth(s.bounds),CGRectGetHeight(s.bounds));
        b.frame.origin.x=a.frame.width+s.frame.width;
        a.frame.origin.y=h/2-a.frame.height/2;
        b.frame.origin.y=h/2-b.frame.height/2;
        s.frame.origin.y=h/2-s.frame.height/2;
        var res:UIView = UIView(frame:CGRectMake(0,0,a.frame.width+b.frame.width+s.frame.width,h));
        res.addSubview(a);
        res.addSubview(s);
        res.addSubview(b);
        return res;
    }
    override func sameAs(b:Function)->Bool{
        return super.sameAs(b)||((b.type==type)&&var1!.sameAs(b.var2!)&&var2!.sameAs(b.var1!));
    }
}
class Sub:BinaryFunction {
    override init(a:Function,b:Function){
        super.init(a:a,b:b);
        self.type="-";
    }
    override func v()->((Double,Double)->Double){return Subtraction;}
    override func d()->Function{return var1!.d()-var2!.d();}
    override func pp()->UIView{
        var a:UIView = var1!.pp();
        var b:UIView = var2!.pp();
        var h:CGFloat = max(a.frame.height,b.frame.height);
        a.frame.origin.y=h/2-a.frame.height/2;
        var s:UILabel = UILabel();
        s.font = UIFont(name:"Courier",size:fontSize);
        if(arrHas(arrOfUniary+["^","*","x"],var2!.type)){
            s.text="-";
            s.sizeToFit();
            s.frame=CGRectMake(a.frame.width,h/2-CGRectGetHeight(s.bounds)/2,CGRectGetWidth(s.bounds),CGRectGetHeight(s.bounds));
            b.frame.origin.x=s.frame.width+s.frame.origin.x;
            b.frame.origin.y=h/2-b.frame.height/2;
            var res:UIView = UIView(frame:CGRectMake(0,0,a.frame.width+b.frame.width+s.frame.width,h));
            res.addSubview(a);
            res.addSubview(s);
            res.addSubview(b);
            return res;
        }else{
            s.text="-(";
            s.sizeToFit();
            s.frame=CGRectMake(a.frame.width,h/2-CGRectGetHeight(s.bounds)/2,CGRectGetWidth(s.bounds),CGRectGetHeight(s.bounds));
            var rq:UILabel=UILabel();
            rq.font=UIFont(name:"Courier",size:fontSize);
            rq.text = ")";
            rq.sizeToFit();
            rq.frame=CGRectMake(a.frame.width+s.frame.width+b.frame.width,h/2-CGRectGetHeight(rq.bounds)/2,CGRectGetWidth(rq.bounds),CGRectGetHeight(rq.bounds));
            b.frame.origin.x=a.frame.width+s.frame.width;
            b.frame.origin.y=h/2-b.frame.height/2;
            var res:UIView = UIView(frame:CGRectMake(0,0,a.frame.width+s.frame.width+b.frame.width+rq.frame.width,h));
            res.addSubview(a);
            res.addSubview(s);
            res.addSubview(b);
            res.addSubview(rq);
            return res;
        }
    }
}
class Mul:BinaryFunction{
    override init(a:Function,b:Function){
        super.init(a:a,b:b);
        self.type="*";
        normalize();
    }
    override func v()->((Double,Double)->Double){return Multiplication;}
    override func d()->Function{
        var v1:Function = var1!;
        var v2:Function = var2!;
        return v1.d()*v2+v2.d()*v1;
    }
    override func pp()->UIView{
        var v1:Function = var1!;
        var v2:Function = var2!;
        if(v1.sameAs(CONSN1) || v2.sameAs(CONSN1)){
            var a:UIView;
            if(v1.sameAs(CONSN1)){a=v2.pp();}else{a=v1.pp();}
            var s:UILabel = UILabel();
            s.font=UIFont(name:"Courier",size:fontSize);
            s.text="-";
            s.sizeToFit();
            s.frame=CGRectMake(0,a.frame.height/2-CGRectGetHeight(s.bounds)/2,CGRectGetWidth(s.bounds),CGRectGetHeight(s.bounds));
            a.frame.origin.x=s.frame.width;
            var res:UIView=UIView(frame:CGRectMake(0,0,a.frame.origin.x+a.frame.width,a.frame.height));
            res.addSubview(s);
            res.addSubview(a);
            return res;
        }
        var a:UIView = v1.pp();
        var b:UIView = v2.pp();
        var s:UILabel = UILabel();
        s.font = UIFont(name:"Courier",size:fontSize);
        var res:UIView = UIView();
        var h:CGFloat=max(a.frame.height,b.frame.height);
        a.frame.origin.y=h/2-a.frame.height/2;
        b.frame.origin.y=h/2-b.frame.height/2;
        s.text="";
        if(arrHas(["+","-"],v1.type)){
            var lq:UILabel=UILabel();
            lq.font = UIFont(name:"Courier",size:fontSize);
            lq.text="(";
            lq.sizeToFit();
            lq.frame=CGRectMake(0,h/2-CGRectGetHeight(lq.bounds)/2,CGRectGetWidth(lq.bounds),CGRectGetHeight(lq.bounds));
            a.frame.origin.x=lq.frame.width;
            var rq:UILabel=UILabel();
            rq.font = UIFont(name:"Courier",size:fontSize);
            rq.text=")";
            rq.sizeToFit();
            rq.frame=CGRectMake(a.frame.width+a.frame.origin.x,h/2-CGRectGetHeight(rq.bounds)/2,CGRectGetWidth(rq.bounds),CGRectGetHeight(rq.bounds));
            s.sizeToFit();
            s.frame=CGRectMake(rq.frame.width+rq.frame.origin.x,h/2-CGRectGetHeight(s.bounds)/2,CGRectGetWidth(s.bounds),CGRectGetHeight(s.bounds));
            res.addSubview(lq);
            res.addSubview(a);
            res.addSubview(rq);
            res.addSubview(s);
        }else{
            res.addSubview(a);
            s.sizeToFit();
            s.frame=CGRectMake(a.frame.width,h/2-CGRectGetHeight(s.bounds)/2,CGRectGetWidth(s.bounds),CGRectGetHeight(s.bounds));
            res.addSubview(s);
        }
        if(arrHas(["+","-"],v2.type)){
            var lq:UILabel=UILabel();
            lq.font = UIFont(name:"Courier",size:fontSize);
            lq.text="(";
            lq.sizeToFit();
            lq.frame=CGRectMake(s.frame.width+s.frame.origin.x,h/2-CGRectGetHeight(lq.bounds)/2,CGRectGetWidth(lq.bounds),CGRectGetHeight(lq.bounds));
            b.frame.origin.x=lq.frame.width+lq.frame.origin.x;
            var rq:UILabel=UILabel();
            rq.font = UIFont(name:"Courier",size:fontSize);
            rq.text=")";
            rq.sizeToFit();
            rq.frame=CGRectMake(b.frame.width+b.frame.origin.x,h/2-CGRectGetHeight(rq.bounds)/2,CGRectGetWidth(rq.bounds),CGRectGetHeight(rq.bounds));
            res.addSubview(lq);
            res.addSubview(b);
            res.addSubview(rq);
            res.frame=CGRectMake(0,0,rq.frame.width+rq.frame.origin.x,h);
        }else{
            b.frame.origin.x=s.frame.width+s.frame.origin.x;
            res.addSubview(b);
            res.frame=CGRectMake(0,0,b.frame.width+b.frame.origin.x,h);
        }
        return res;
    }
    override func sameAs(b:Function)->Bool{
        return super.sameAs(b)||((b.type==type)&&var1!.sameAs(b.var2!)&&var2!.sameAs(b.var1!));
    }
    override func normalize(){
        
        var v1:Function = var1!;
        var v2:Function = var2!;
        if(v2.type=="c")||(v2.type=="x" && v1.type != "c"){
            var tem:Function=v1;
            v1 = v2;
            v2 = tem;
        }
    }
}
class Div:BinaryFunction{
    override init(a:Function,b:Function){
        super.init(a:a,b:b);
        self.type="/";
    }
    override func v()->((Double,Double)->Double){return Division;}
    override func d()->Function{
        var v1:Function = var1!;
        var v2:Function = var2!;
        return (v2*v1.d()-v2.d()*v1)/(v2*v2);
    }
    override func spp()->UIView{
        var a:UIView=var1!.spp();
        var b:UIView=var2!.spp();
        var w:CGFloat=max(a.frame.width,b.frame.width);
        a.frame.origin.x=w/2-a.frame.width/2;
        b.frame.origin.x=w/2-b.frame.width/2;
        var slash:UIView=UIView(frame:CGRectMake(0,a.frame.height,w,5/fontSize));
        var res:UIView=UIView(frame:CGRectMake(0,0,w,a.frame.height+b.frame.height+slash.frame.height));
        slash.backgroundColor=UIColor.blackColor();
        b.frame.origin.y=a.frame.height+slash.frame.height;
        res.addSubview(a);
        res.addSubview(slash);
        res.addSubview(b);
        return res;
    }
    override func pp()->UIView{
        var a:UIView=var1!.pp();
        var b:UIView=var2!.pp();
        var w:CGFloat=max(a.frame.width,b.frame.width);
        a.frame.origin.x=w/2-a.frame.width/2;
        b.frame.origin.x=w/2-b.frame.width/2;
        var slash:UIView=UIView(frame:CGRectMake(0,a.frame.height,w,10/fontSize));
        var res:UIView=UIView(frame:CGRectMake(0,0,w,a.frame.height+b.frame.height+slash.frame.height));
        slash.backgroundColor=UIColor.blackColor();
        b.frame.origin.y=a.frame.height+slash.frame.height;
        res.addSubview(a);
        res.addSubview(slash);
        res.addSubview(b);
        return res;
    }
}
class Pow:BinaryFunction{
    override init(a:Function,b:Function){
        super.init(a:a,b:b);
        self.type="^";
    }
    override func v()->((Double,Double)->Double){return Power;}
    override func d()->Function{
        var v1:Function = var1!;
        var v2:Function = var2!;
        return (v2*v1.d()+v1*LN(a:v1)*v2.d())*v1^(v2-Cons(a:1));
    }
    override func pp()->UIView{
        var a:UIView = var1!.pp();
        var b:UIView = var2!.spp();
        a.frame.origin.y=b.frame.height;
        b.frame.origin.x=a.frame.width;
        var res:UIView = UIView(frame:CGRectMake(0,0,a.frame.width+b.frame.width,a.frame.height+b.frame.height));
        res.addSubview(a);
        res.addSubview(b);
        return res;
    }
}