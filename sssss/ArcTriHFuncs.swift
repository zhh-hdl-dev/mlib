//
//  ArcTriHFuncs.swift
//  sssss
//
//  Created by Hanghang Zhang on 3/20/15.
//  Copyright (c) 2015 Hanghang Zhang. All rights reserved.
//

import Foundation
import UIKit
class ARCSINH:UniaryFunction{
    override init(a:Function) {
        super.init(a:a);
        self.type="arcsinh";
    }
    override func v()->(Double->Double){return basic_ARCSINH;}
    override func d()->Function{
        var v1:Function = var1!;
        return v1.d()/(CONS1+v1*v1)^CONS05;
    }
}
class ARCCOSH:UniaryFunction{
    override init(a:Function){
        super.init(a:a);
        self.type="arccosh";
    }
    override func v()->(Double->Double){return basic_ARCCOSH;}
    override func d()->Function{
        var v1:Function = var1!;
        return Cons(a:0)-v1.d()/(v1*v1-CONS1)^CONS05;
    }
}
class ARCTANH:UniaryFunction{
    override init(a:Function) {
        super.init(a:a);
        self.type="arctanh";
    }
    override func v()->(Double->Double){return basic_ARCTANH;}
    override func d()->Function{
        var v1:Function = var1!;
        return v1.d()/(CONS1-v1*v1);
    }
}
class ARCCOTH:UniaryFunction{
    override init(a:Function){
        super.init(a:a);
        self.type="arccoth";
    }
    override func v()->(Double->Double){return basic_ARCCOTH;}
    override func d()->Function{
        var v1:Function = var1!;
        return v1.d()/(CONS1-v1*v1);
    }
}
class ARCSECH:UniaryFunction{
    override init(a:Function) {
        super.init(a:a);
        self.type="arcsech";
    }
    override func v()->(Double->Double){return basic_ARCSECH;}
    override func d()->Function{
        var v1:Function = var1!;
        return v1.d()/(v1*(v1*v1+CONS1)^(CONS05));
    }
}
class ARCCSCH:UniaryFunction{
    override init(a:Function) {
        super.init(a:a);
        self.type="arccsch";
    }
    override func v()->(Double->Double){return basic_ARCCSCH;}
    override func d()->Function{
        var v1:Function = var1!;
        return v1.d()/(v1*(CONS1+v1*v1)^CONS05);
    }
}