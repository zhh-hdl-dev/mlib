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
    override init(a:Function?) {
        super.init(a:a);
        self.type="arcsinh";
    }
    override func v()->(Double->Double)?{
        return basic_ARCSINH;
    }
    override func d()->Function?{
        return var1!.d()/(Cons(a:1)+var1*var1)^Cons(a:0.5);
    }
}
class ARCCOSH:UniaryFunction{
    override init(a:Function?) {
        super.init(a:a);
        self.type="arccosh";
    }
    override func v()->(Double->Double)?{
        return basic_ARCCOSH;
    }
    override func d()->Function?{
        return Cons(a:0)-var1!.d()/(var1*var1-Cons(a:1))^Cons(a:0.5);
    }
}
class ARCTANH:UniaryFunction{
    override init(a:Function?) {
        super.init(a:a);
        self.type="arctanh";
    }
    override func v()->(Double->Double)?{
        return basic_ARCTANH;
    }
    override func d()->Function?{
        return var1!.d()/(Cons(a:1)-var1*var1);
    }
}
class ARCCOTH:UniaryFunction{
    override init(a:Function?) {
        super.init(a:a);
        self.type="arccoth";
    }
    override func v()->(Double->Double)?{
        return basic_ARCCOTH;
    }
    override func d()->Function?{
        return var1!.d()/(Cons(a:1)-var1*var1);
    }
}
class ARCSECH:UniaryFunction{
    override init(a:Function?) {
        super.init(a:a);
        self.type="arcsech";
    }
    override func v()->(Double->Double)?{
        return basic_ARCSECH;
    }
    override func d()->Function?{
        return var1!.d()/(var1*(var1*var1+Cons(a:1))^(Cons(a:0.5)));
    }
}
class ARCCSCH:UniaryFunction{
    override init(a:Function?) {
        super.init(a:a);
        self.type="arccsch";
    }
    override func v()->(Double->Double)?{
        return basic_ARCCSCH;
    }
    override func d()->Function?{
        return var1!.d()/(var1*(Cons(a:1)+var1*var1)^Cons(a:0.5));
    }
}