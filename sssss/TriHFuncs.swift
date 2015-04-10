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
    override init(a:Function?){
        super.init(a:a);
        self.type="sinh";
    }
    override func v()->(Double->Double)?{
        return basic_SINH;
    }
    override func d()->Function?{
        return COSH(a:var1)*var1!.d();
    }
}
class COSH:UniaryFunction{
    override init(a:Function?){
        super.init(a:a);
        self.type="cosh";
    }
    override func v()->(Double->Double)?{
        return basic_COSH;
    }
    override func d()->Function?{
        return SINH(a:var1)*var1!.d();
    }
}
class TANH:UniaryFunction{
    override init(a:Function?){
        super.init(a:a);
        self.type="tanh";
    }
    override func v()->(Double->Double)?{
        return basic_TANH;
    }
    override func d()->Function?{
        return SECH(a:var1)*SECH(a:var1)*var1!.d();
    }
}
class COTH:UniaryFunction{
    override init(a:Function?){
        super.init(a:a);
        self.type="coth";
    }
    override func v()->(Double->Double)?{
        return basic_COTH;
    }
    override func d()->Function?{
        return Cons(a:0)-CSCH(a:var1)*CSCH(a:var1)*var1!.d();
    }
}
class SECH:UniaryFunction{
    override init(a:Function?){
        super.init(a:a);
        self.type="sech";
    }
    override func v()->(Double->Double)?{
        return basic_SECH;
    }
    override func d()->Function?{
        return Cons(a:0)-SECH(a:var1)*TANH(a:var1)*var1!.d();
    }
}
class CSCH:UniaryFunction{
    override init(a:Function?){
        super.init(a:a);
        self.type="csch";
    }
    override func v()->(Double->Double)?{
        return basic_CSCH;
    }
    override func d()->Function?{
        return Cons(a:0)-COTH(a:var1)*CSCH(a:var1)*var1!.d();
    }
}