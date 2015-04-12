//
//  LibA.swift
//  mlib
//
//  Created by Hanghang Zhang on 2/22/15.
//  Copyright (c) 2015 Hanghang Zhang. All rights reserved.
//

import Foundation
import UIKit
extension String {
    func substringToIndex(index:Int) -> String{
        return self.substringToIndex(advance(self.startIndex, index));
    }
    func substringFromIndex(index:Int) -> String{
        return self.substringFromIndex(advance(self.startIndex, index));
    }
    subscript(index:Int) -> Character{
        return self[advance(self.startIndex, index)];
    }
    
}

protocol Forma{
    func pp()->UIView;
    func spp()->UIView;
    func p();
}

func GCD(a:Int,b:Int)->Int{
    if(b==0){
        return a;
    }
    return GCD(b,a%b);
}
func LCM(a:Int,b:Int)->Int{
    return(a*b)/GCD(a,b);
}
func Ind(a:UInt64)->Double{
    if(a%2==0){
        return 1;
    }else{
        return -1;
    }
}
func Ind(a:Int)->Double{
    if(a%2==0){
        return 1;
    }else{
        return -1;
    }
}
func Addition(a:Double,b:Double)->Double{
    return a+b;
}
func Subtraction(a:Double,b:Double)->Double{
    return a-b;
}
func Multiplication(a:Double,b:Double)->Double{
    return a*b;
}
func Division(a:Double,b:Double)->Double{
    return a/b;
}
func Power(a:Double,b:Double)->Double{return 0;}
func PochhammerF(x:Double,n:Int)->Double{
    var res:Double=x;
    for(var i:Double=x-1;i>=x-Double(n)+1;i--){
        res=res*i;
    }
    return res;
}
func PochhammerR(x:Double,n:Int)->Double{
    var res:Double=x;
    for(var i:Double=x+1;i>=x+Double(n)-1;i++){
        res=res*i;
    }
    return res;
}
func approxFrom(v:Double)->Fraction{
    var a = 1;
    var b = 1;
    for(var i = 0;i<100000;i++){
        if(v>Double(a)/Double(b)){
            a++;
        }
        if(v<Double(a)/Double(b)){
            b++;
        }
        else{
            return Fraction(a:a,b:b);
        }
    }
    return Fraction(a:a,b:b);
}
func arrHas(A:Array<String>,s:String)->Bool{
    for(var i:Int=0;i < count(A);i++){
        if(A[i]==s){
            return true;
        }
    }
    return false;
}
func priority(ope:String)->Int{
    if((ope=="*")||(ope=="/")){
        return 4;
    }else if((ope=="+")||(ope=="-")){
        return 5;
    }else if(arrHas(arrOfLBracket+arrOfRBracket,ope)){
        return 0;
    }else if(arrHas(arrOfUniary,ope)){
        return 1;
    }else if(ope=="^"){
        return 3;
    }else if(ope=="integral"){
        return 1;
    }else if(ope==","){
        return 6;
    }else if((ope=="|")){
        return 2;
    }
    return 0;
}
func infixToSuffix(A:Array<String>)->Array<String>{
    var res:Array<String> = Array<String>();
    var wPool:Array<String> = Array<String>();
    for(var i:Int=0;i<count(A);i++){
        if(A[i]==","){
            continue;
        }
        if(arrHas(arrOfLBracket,A[i])){
            wPool.append(A[i]);
        }else if(arrHas(arrOfRBracket,A[i])){
            while(!arrHas(arrOfLBracket,wPool.last!)){
                res.append(wPool.removeLast());
            }
            wPool.removeLast();
        }else if(arrHas(arrOfOperator,A[i])){
            while((wPool.last != nil)&&(priority(wPool.last!)<=priority(A[i]))&&(!arrHas(arrOfLBracket,wPool.last!))){
                res.append(wPool.removeLast());
            }
            wPool.append(A[i]);
        }else{
            res.append(A[i]);
        }
    }
    while(wPool.last != nil){
        res.append(wPool.removeLast());
    }
    return res;
}
func suffixExpAnalysis(A:Array<String>)->Function{
    println(A);
    var wPool:Array<Function>=Array<Function>();
    for(var i:Int=0;i<count(A);i++){
        switch A[i]{
        case"+":
            var a:Function=wPool.removeLast();
            wPool.append((wPool.removeLast()+a));
        case"-":
            var a:Function=wPool.removeLast();
            wPool.append((wPool.removeLast()-a));
        case"*":
            var a:Function=wPool.removeLast();
            wPool.append((wPool.removeLast()*a));
        case"/":
            var a:Function=wPool.removeLast();
            wPool.append((wPool.removeLast()/a));
        case"^":
            var a:Function=wPool.removeLast();
            wPool.append((wPool.removeLast()^a));
        case"|":
            var a:Function=wPool.removeLast();
            wPool.append(wPool.removeLast()*a);
        case"sin":
            wPool.append(SIN(a:wPool.removeLast()));
        case"cos":
            wPool.append(COS(a:wPool.removeLast()));
        case"tan":
            wPool.append(TAN(a:wPool.removeLast()));
        case"cot":
            wPool.append(COT(a:wPool.removeLast()));
        case"sec":
            wPool.append(SEC(a:wPool.removeLast()));
        case"csc":
            wPool.append(CSC(a:wPool.removeLast()));
            
        case"sinh":
            wPool.append(SINH(a:wPool.removeLast()));
        case"cosh":
            wPool.append(COSH(a:wPool.removeLast()));
        case"tanh":
            wPool.append(TANH(a:wPool.removeLast()));
        case"coth":
            wPool.append(COTH(a:wPool.removeLast()));
        case"sech":
            wPool.append(SECH(a:wPool.removeLast()));
        case"csch":
            wPool.append(CSCH(a:wPool.removeLast()));
            
        case"arcsin":
            wPool.append(ARCSIN(a:wPool.removeLast()));
        case"arccos":
            wPool.append(ARCCOS(a:wPool.removeLast()));
        case"arctan":
            wPool.append(ARCTAN(a:wPool.removeLast()));
        case"arccot":
            wPool.append(ARCCOT(a:wPool.removeLast()));
        case"arcsec":
            wPool.append(ARCSEC(a:wPool.removeLast()));
        case"arccsc":
            wPool.append(ARCCSC(a:wPool.removeLast()));
            
        case"arcsinh":
            wPool.append(ARCSINH(a:wPool.removeLast()));
        case"arccosh":
            wPool.append(ARCCOSH(a:wPool.removeLast()));
        case"arctanh":
            wPool.append(ARCTANH(a:wPool.removeLast()));
        case"arccoth":
            wPool.append(ARCCOTH(a:wPool.removeLast()));
        case"arcsech":
            wPool.append(ARCSECH(a:wPool.removeLast()));
        case"arccsch":
            wPool.append(ARCCSCH(a:wPool.removeLast()));
        
        case"exp":
            wPool.append(EXP(a:wPool.removeLast()));
        case"ln":
            wPool.append(LN(a:wPool.removeLast()));
        case"x":
            wPool.append(X());
        case"d":
            wPool.append(wPool.removeLast().d());
        case"integral":
            var a:Function = wPool.removeLast();
            var b:Function = wPool.removeLast();
            var c:Function = wPool.removeLast();
            wPool.append(Cons(a:integral(c,b.cons,a.cons)));
        default:
            wPool.append(Cons(a:(A[i] as NSString).doubleValue));
        }
    }
    
    return wPool[0];
}


func inputStrProcess(dict:Array<String>,numarray:Array<String>,str:String)->Array<String>{
    var res:Array<String>=Array<String>();
    var cstr:String = str+" ";
    while(true){
        var flagError:Bool = true;
        if(cstr.isEmpty){
            break;
        }
        if(cstr.hasPrefix(" ")){
            cstr.removeAtIndex(cstr.startIndex);
            flagError=false;
            continue;
        }
        var newstr:String = "";
        for(var i:Int=0;i<count(cstr);i++){
            if(arrHas(numarray,String(cstr[i]))){
                newstr += String(cstr[i]);
            }else if(!newstr.isEmpty){
                res.append(newstr);
                flagError=false;
                cstr.removeRange(cstr.rangeOfString(newstr)!);
                break;
            }else{
                break;
            }
        }
        for(var i:Int=0;i<count(dict);i++){
            if(cstr.hasPrefix(dict[i])){
                res.append(dict[i]);
                flagError=false;
                cstr.removeRange(cstr.rangeOfString(dict[i])!);
                break;
            }
        }
        if(flagError){
            return Array<String>();
        }
    }
    var ress:Array<String> = Array<String>()
    if(res[0]=="-"){
        ress = ress + ["-1","|"];
    }else if(res[0]=="+"){
        ress = ress + ["1","|"];
    }else{
        ress.append(res[0]);
    }
    for(var i:Int=1;i<count(res)-1;i++){
        
        var c1:Bool = arrHas(arrOfNum,String(res[i][0]));
        var c2:Bool = arrHas(arrConflict1,res[i]);
        var c3:Bool = arrHas(arrOfNum,String(res[i+1][0]));
        var c4:Bool = arrHas(arrConflict2,res[i+1]);
        var c5:Bool = !arrHas(arrOfUniary,res[i]);
        var c6:Bool = !arrHas(arrOfLBracket,res[i+1]);
        var c7:Bool = arrHas(arrOfBegins,res[i]);
        
        var c8:Bool = c7 && res[i+1]=="+";
        var c9:Bool = c7 && res[i+1]=="-";
        ress.append(res[i]);
        if((c1||c2)&&(c3||c4)&&(c5||c6)){
            ress.append("*");
        }
        if(c8){
            ress+=["1","|"];
            i++;
        }else if(c9){
            ress+=["-1","|"];
            i++;
        }
        
    }
    ress.append(res.last!);
    return ress;
}










