//
//  ArcTriFuncs.swift
//  sssss
//
//  Created by Hanghang Zhang on 3/20/15.
//  Copyright (c) 2015 Hanghang Zhang. All rights reserved.
//

import Foundation
import UIKit
class ARCSIN:UniaryFunction{
    override init(a:Function){
        super.init(a:a);
        self.type="arcsin";
    }
    override func v()->(Double->Double){return basic_ARCSIN;}
    override func d()->Function{
        var v1:Function = var1!;
        return v1.d()/(Cons(a:1)-v1*v1)^Cons(a:0.5);
    }
}
class ARCCOS:UniaryFunction{
    override init(a:Function) {
        super.init(a:a);
        self.type="arccos";
    }
    override func v()->(Double->Double){return basic_ARCCOS;}
    override func d()->Function{
        var v1:Function = var1!;
        return Cons(a:0)-v1.d()/(Cons(a:1)-v1*v1)^Cons(a:0.5);
    }
}
class ARCTAN:UniaryFunction{
    override init(a:Function) {
        super.init(a:a);
        self.type="arctan";
    }
    override func v()->(Double->Double){return basic_ARCTAN;}
    override func d()->Function{
        var v1:Function = var1!;
        return v1.d()/(Cons(a:1)+v1*v1);
    }
}
class ARCCOT:UniaryFunction{
    override init(a:Function) {
        super.init(a:a);
        self.type="arccot";
    }
    override func v()->(Double->Double){return basic_ARCCOT;}
    override func d()->Function{
        var v1:Function = var1!;
        return Cons(a:0)-v1.d()/(Cons(a:1)+v1*v1);
    }
}
class ARCSEC:UniaryFunction{
    override init(a:Function) {
        super.init(a:a);
        self.type="arcsec";
    }
    override func v()->(Double->Double){return basic_ARCSEC;}
    override func d()->Function{
        var v1:Function = var1!;
        return v1.d()/(v1*v1*(Cons(a:1)-v1^Cons(a:-2))^Cons(a:0.5));
    }
}
class ARCCSC:UniaryFunction{
    override init(a:Function) {
        super.init(a:a);
        self.type="arccsc";
    }
    override func v()->(Double->Double){return basic_ARCCSC;}
    override func d()->Function{
        var v1:Function = var1!;
        return Cons(a:0)-v1.d()/(v1*v1*(Cons(a:1)-v1^Cons(a:-2))^Cons(a:0.5));
    }
}