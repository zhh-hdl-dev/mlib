//
//  TriFuncs.swift
//  sssss
//
//  Created by Hanghang Zhang on 3/20/15.
//  Copyright (c) 2015 Hanghang Zhang. All rights reserved.
//

import Foundation
import UIKit
class SIN:TriangleFunction {
    override init(a:Function) {
        super.init(a:a);
        self.type="sin";
    }
    override func v()->(Double->Double){return basic_SIN;}
    override func d()->Function{
        var v1:Function = var1!;
        return COS(a:v1)*v1.d();
    }
}
class COS:TriangleFunction {
    override init(a:Function){
        super.init(a:a);
        self.type="cos";
    }
    override func v()->(Double->Double){return basic_COS;}
    override func d()->Function{
        var v1:Function = var1!;
        return CONS0-SIN(a:v1)*v1.d();
    }
}
class SEC:TriangleFunction {
    override init(a:Function){
        super.init(a:a);
        self.type="sec";
    }
    override func v()->(Double->Double){return basic_SEC;}
    override func d()->Function{
        var v1:Function = var1!;
        return TAN(a:v1)*SEC(a:v1)*v1.d();
    }
}
class CSC:TriangleFunction {
    override init(a:Function){
        super.init(a:a);
        self.type="csc";
    }
    override func v()->(Double->Double){return basic_CSC;}
    override func d()->Function{
        var v1:Function = var1!;
        return CONS0-CSC(a:v1)*COT(a:v1)*v1.d();
    }
}
class TAN:TriangleFunction {
    override init(a:Function){
        super.init(a:a);
        self.type="tan";
    }
    override func v()->(Double->Double){return basic_TAN;}
    override func d()->Function{
        var v1:Function = var1!;
        return SEC(a:v1)*SEC(a:v1)*v1.d();
    }
}
class COT:TriangleFunction {
    override init(a:Function) {
        super.init(a:a);
        self.type="cot";
    }
    override func v()->(Double->Double){return basic_COT;}
    override func d()->Function{
        var v1:Function = var1!;
        return CONS0-COT(a:v1)*COT(a:v1)-v1.d();
    }
}