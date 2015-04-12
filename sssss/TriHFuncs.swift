//
//  TriHFuncs.swift
//  sssss
//
//  Created by Hanghang Zhang on 3/20/15.
//  Copyright (c) 2015 Hanghang Zhang. All rights reserved.
//

import Foundation
import UIKit
class SINH:UniaryFunction{
    override init(a:Function){
        super.init(a:a);
        self.type="sinh";
    }
    override func v()->(Double->Double){return basic_SINH;}
    override func d()->Function{
        var v1:Function = var1!;
        return COSH(a:v1)*v1.d();
    }
}
class COSH:UniaryFunction{
    override init(a:Function){
        super.init(a:a);
        self.type="cosh";
    }
    override func v()->(Double->Double){return basic_COSH;}
    override func d()->Function{
        var v1:Function = var1!;
        return SINH(a:v1)*v1.d();
    }
}
class TANH:UniaryFunction{
    override init(a:Function){
        super.init(a:a);
        self.type="tanh";
    }
    override func v()->(Double->Double){return basic_TANH;}
    override func d()->Function{
        var v1:Function = var1!;
        return SECH(a:v1)*SECH(a:v1)*v1.d();
    }
}
class COTH:UniaryFunction{
    override init(a:Function){
        super.init(a:a);
        self.type="coth";
    }
    override func v()->(Double->Double){return basic_COTH;}
    override func d()->Function{
        var v1:Function = var1!;
        return Cons(a:0)-CSCH(a:v1)*CSCH(a:v1)*v1.d();
    }
}
class SECH:UniaryFunction{
    override init(a:Function){
        super.init(a:a);
        self.type="sech";
    }
    override func v()->(Double->Double){return basic_SECH;}
    override func d()->Function{
        var v1:Function = var1!;
        return Cons(a:0)-SECH(a:v1)*TANH(a:v1)*v1.d();
    }
}
class CSCH:UniaryFunction{
    override init(a:Function){
        super.init(a:a);
        self.type="csch";
    }
    override func v()->(Double->Double){return basic_CSCH;}
    override func d()->Function{
        var v1:Function = var1!;
        return Cons(a:0)-COTH(a:v1)*CSCH(a:v1)*v1.d();
    }
}