//
//  Complex.swift
//  mlib
//
//  Created by Hanghang Zhang on 2/21/15.
//  Copyright (c) 2015 Hanghang Zhang. All rights reserved.
//

import Foundation

class Complex {
    var Re:Double;
    var Im:Double;
    init(Re:Double,Im:Double){
        self.Re=Re;
        self.Im=Im;
    }
    var M:Double{
        get{return self.Im*self.Im+self.Re*self.Re;}
    }
    
}
func+(Right:Complex,Left:Complex)->Complex{
    return Complex(Re: Right.Re+Left.Re,Im: Right.Im+Left.Im);
}
func-(Right:Complex,Left:Complex)->Complex{
    return Complex(Re: Right.Re-Left.Re,Im: Right.Im-Left.Im);
}
func*(Right:Complex,Left:Complex)->Complex{return Complex(Re:0,Im:0);}
func/(Right:Complex,Left:Complex)->Complex{return Complex(Re:0,Im:0);}