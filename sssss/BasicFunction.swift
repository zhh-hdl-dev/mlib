//
//  BasicFunction.swift
//  mlib
//
//  Created by Hanghang Zhang on 2/21/15.
//  Copyright (c) 2015 Hanghang Zhang. All rights reserved.
//

import Foundation
func series(f:((UInt64,Double)->Double),acc:UInt64)->(Double->Double){
    
    func res(x:Double)->Double{
        var sum:Double=0;
        for(var i:UInt64=0;i<acc;i++){sum+=f(i,x);}
        return sum;
    }
    return res;
}
func series(f:((UInt64,Double)->Double))->(Double->Double){return series(f,20);}
func basic_POW(base:Double,index:UInt64)->Double{
    switch index{
    case 0:return 1;
    case 1:return base;
    case 2:return base*base;
    case 3:return base*base*base;
    case 4:return base*base*base*base;
    default:
        if index>0{return basic_POW(base*base*base*base,index/4)*basic_POW(base,index%4);}else{return 1;}
    }
}
func basic_PPOW(base:Double,index:Double)->Double{return 0;}//TODO
func basic_factorial(inp:UInt64)->UInt64{
    if(inp>1){return inp*basic_factorial(inp-1);}else{return 1;}
}

func pi(acc:UInt64)->Double{
    func ttt(a:UInt64,b:Double)->Double{return Double(Ind(Int(a)))/Double(2*a+1);}
    return 4.0*series(ttt,acc)(0);
}
let Pi:Double=pi(20000);
let E:Double=basic_EXP(1);
func basic_EXP(base:Double)->Double{
    func ttt(inp:UInt64,x:Double)->Double{return (basic_POW(x,inp))/(Double(basic_factorial(inp)));}
    return series(ttt)(base);
}
func basic_LN(inp:Double)->Double{return integral(Cons(a:1)/X(),1,inp);}
func basic_SIN(inp:Double)->Double{
    func ttt(a:UInt64,b:Double)->Double{return Double(Ind(a)*(basic_POW(b,1+2*a)))/Double(basic_factorial(1+2*a));
    }
    return series(ttt,9)(inp);
}
func basic_COS(inp:Double)->Double{
    func ttt(a:UInt64,b:Double)->Double{return Double(Ind(a)*(basic_POW(b,2*a)))/Double(basic_factorial(2*a));}
    return series(ttt,10)(inp);
}
func basic_TAN(inp:Double)->Double{return basic_SIN(inp)/basic_COS(inp);}
func basic_COT(inp:Double)->Double{return basic_COS(inp)/basic_SIN(inp);}
func basic_SEC(inp:Double)->Double{return Double(1)/basic_COS(inp);}
func basic_CSC(inp:Double)->Double{return Double(1/basic_SIN(inp));}

func basic_SINH(inp:Double)->Double{
    func ttt(a:UInt64,b:Double)->Double{return (basic_POW(b,1+2*a))/Double(basic_factorial(1+2*a));}
    return series(ttt,9)(inp);
}
func basic_COSH(inp:Double)->Double{
    func ttt(a:UInt64,b:Double)->Double{return basic_POW(b,2*a)/Double(basic_factorial(2*a));}
    return series(ttt,10)(inp);
}
func basic_TANH(inp:Double)->Double{return basic_SINH(inp)/basic_COSH(inp);}
func basic_COTH(inp:Double)->Double{return basic_COSH(inp)/basic_SINH(inp);}
func basic_SECH(inp:Double)->Double{return 1.0/basic_COSH(inp);}
func basic_CSCH(inp:Double)->Double{return 1.0/basic_SINH(inp);}

func basic_ARCCOS(inp:Double)->Double{return integral(Cons(a:1)/(Cons(a:1)-X()*X())^(Cons(a:0.5)),inp,1);}
func basic_ARCSIN(inp:Double)->Double{return integral(Cons(a:1)/(Cons(a:1)-X()*X())^(Cons(a:0.5)),0,inp);}
func basic_ARCTAN(inp:Double)->Double{
    func ttt(a:UInt64,b:Double)->Double{return Double(Ind(a))*basic_POW(b,1+2*a)/Double(1+2*a);}
    return series(ttt,9)(inp);
}
func basic_ARCCOT(inp:Double)->Double{return integral(Cons(a:1)/(Cons(a:1)+X()*X()),inp,nil);}
func basic_ARCSEC(inp:Double)->Double{return basic_ARCCOS(1/inp);}
func basic_ARCCSC(inp:Double)->Double{return basic_ARCSIN(1/inp);}

func basic_ARCSINH(inp:Double)->Double{return basic_LN(inp+basic_PPOW(1+inp*inp,0.5));}
func basic_ARCCOSH(inp:Double)->Double{return basic_LN(inp+basic_PPOW(inp*inp-1,0.5));}//|x|>1}
func basic_ARCTANH(inp:Double)->Double{
    if((inp >= 1)||(inp <= -1)){return 0;}
    func ttt(a:UInt64,b:Double)->Double{return basic_POW(b,2*a+1)/Double(2*a+1);}
    return series(ttt,20)(inp);
}
func basic_ARCCOTH(inp:Double)->Double{return basic_ARCTANH(1/inp);}
func basic_ARCSECH(inp:Double)->Double{return basic_ARCCOSH(1/inp);}
func basic_ARCCSCH(inp:Double)->Double{return basic_ARCSINH(1/inp);}


