//
//  libD.swift
//  sssss
//
//  Created by Hanghang Zhang on 4/10/15.
//  Copyright (c) 2015 Hanghang Zhang. All rights reserved.
//

import Foundation


func additionSimplify(f:Function)->Function{
    var v1:Function = simplify(f.var1!);
    var v2:Function = simplify(f.var2!);
    if(v1.type == "c" && v2.type == "c"){return Cons(a:(f.v())(v1.cons,v2.cons));}
    if(v1.sameAs(CONS0)){return simplify(v2);}                       // 0+x = x
    else if(v2.sameAs(CONS0)){return simplify(v1);}                  // x+0 = x
    else if(v1.sameAs(v2)){return CONS2*simplify(v1);}           // x+x = 2x
    else if(v1.type=="*" && v1.var1!.sameAs(v2) && v1.var2!.type=="c"){return simplify((v1.var2!+CONS1)*v2);}//xy+x = x(y+1)
    else if(v1.type=="*" && v1.var2!.sameAs(v2) && v1.var1!.type=="c"){return simplify((v1.var1!+CONS1)*v2);}
    else if(v2.type=="*" && v2.var1!.sameAs(v1) && v2.var2!.type=="c"){return simplify((v2.var2!+CONS1)*v1);}
    else if(v2.type=="*" && v2.var2!.sameAs(v1) && v2.var1!.type=="c"){return simplify((v2.var1!+CONS1)*v1);}
    else if(v1.type=="ln" && v2.type=="ln"){return LN(a:simplify(v1.var1!*v2.var1!))}// ln(x)+ln(y) = ln(x*y)
    else if(v1.sameAs(CONSN1*v2)){return CONS0;}                     // -x+x = 0
    else if(v2.sameAs(CONSN1*v1)){return CONS0;}                     // x+ -x = 0
    else if(v2.type=="*" && v2.var1!.sameAs(CONSN1)){return simplify(v1-v2.var2!);}
    else if(v2.type=="*" && v2.var2!.sameAs(CONSN1)){return simplify(v1-v2.var1!);}
    else if(v1.type=="*" && v1.var1!.sameAs(CONSN1)){return simplify(v2-v1.var2!);}
    else if(v1.type=="*" && v1.var2!.sameAs(CONSN1)){return simplify(v2-v1.var1!);}
    return simplify(v1)+simplify(v2);
}

func multiplicationSimplify(f:Function)->Function{
    var v1:Function = simplify(f.var1!);
    var v2:Function = simplify(f.var2!);
    if(v1.type == "c" && v2.type == "c"){return Cons(a:(f.v())(v1.cons,v2.cons));}
    if(v1.sameAs(v2)){return simplify(v1)^CONS2;}                          // x*x = x^2
    else if(v1.sameAs(CONS0)){return CONS0;}                                   // 0*x = 0
    else if(v2.sameAs(CONS0)){return CONS0;}                                   // x*0 = 0
    else if(v1.sameAs(CONS1)){return simplify(v2);}                            // 1*x = x
    else if(v2.sameAs(CONS1)){return simplify(v1);}                            // x*1 = x
    else if(v1.type=="exp" && v2.type=="exp"){return EXP(a: simplify(v1.var1!+v2.var1!));}// e^x*e^y=e^(x+y)
    else if(v1.type=="sin" && v2.type=="cot" && v1.var1!.sameAs(v2.var1!)){return COS(a:simplify(v1.var1!));}    // sin(x)*cot(x)=cos(x)
    else if(v1.type=="cos" && v2.type=="tan" && v1.var1!.sameAs(v2.var1!)){return SIN(a:simplify(v1.var1!));}
    else if(v1.type=="tan" && v2.type=="cot" && v1.var1!.sameAs(v2.var1!)){return CONS1;}
    else if(v1.type=="c" && v2.type=="*"){
        if(v2.var1!.type=="c"){return Cons(a:v1.cons*v2.var1!.cons)*simplify(v2.var2!);}// a*(b*x) = ab*x
        else if(v2.var2!.type=="c"){return Cons(a:v1.cons*v2.var2!.cons)*simplify(v2.var1!);}// a*(x*b) = ab*x
    }else if(v1.type=="*" && v2.type=="c"){
        if(v1.var1!.type=="c"){return Cons(a:v2.cons*v1.var1!.cons)*simplify(v1.var2!);}
        else if(v1.var2!.type=="c"){return Cons(a:v2.cons*v1.var2!.cons)*simplify(v1.var1!);}
    }
//    else if(v1.sameAs(CONSN1*v2)){return CONSN1 * simplify(v1)^Cons(a:2);}// x*(-x) = -x^2
//    else if(v2.sameAs(CONSN1*v1)){return CONSN1 * simplify(v2)*Cons(a:2);} // (-x)*x = -x^2
    return simplify(v1)*simplify(v2);

}
func subtractionSimplify(f:Function)->Function{
    var v1:Function = simplify(f.var1!);
    var v2:Function = simplify(f.var2!);
    if(v1.type == "c" && v2.type == "c"){return Cons(a:(f.v())(v1.cons,v2.cons));}
    if(v1.sameAs(v2)){return CONS0;}                          // x-x = 0
    else if(v2.sameAs(CONS0)){return simplify(v1);}           // x-0 = x
    else if(v1.type=="ln" && v2.type=="ln"){return LN(a:simplify((v1.var1!)/(v2.var1!)));}// ln(x)-ln(y) = ln(x/y)
    else if(v1.sameAs(CONS0)){return CONSN1*simplify(v2);}    // 0-x = -1*x
    else if(v2.type=="*" && v2.var1!.sameAs(CONSN1)){return simplify(v1+v2.var2!);}
    else if(v2.type=="*" && v2.var2!.sameAs(CONSN1)){return simplify(v1+v2.var1!);}
    return simplify(v1)-simplify(v2);
}

func divisionSimplify(f:Function)->Function{
    var v1:Function = simplify(f.var1!);
    var v2:Function = simplify(f.var2!);
    if(v1.type == "c" && v2.type == "c"){return Cons(a:(f.v())(v1.cons,v2.cons));}
    if(v1.sameAs(v2)){return CONS1;}
    else if(v2.type=="c"){return Cons(a:1/v2.cons)*simplify(v1);}
    else if(v1.sameAs(CONS0)){return CONS0;}
    else if(v1.type=="exp" && v2.type=="exp"){return EXP(a:simplify(v1.var1!/v2.var1!));}
    return simplify(v1)/simplify(v2);
}
func powerSimplify(f:Function)->Function{
    var v1:Function = simplify(f.var1!);
    var v2:Function = simplify(f.var2!);
    if(v1.type == "c" && v2.type == "c"){return Cons(a:(f.v())(v1.cons,v2.cons));}
    if(v2.sameAs(CONS0)){return CONS1;}
    else if(v2.sameAs(CONS1)){return simplify(v1);}
    else if(v1.sameAs(CONS0)){return CONS0;}
    else if(v1.sameAs(CONS1)){return CONS1;}
    return simplify(v1)^simplify(v2);
}




func simplify(f:Function)->Function{
    if(arrHas(arrOfBinary,f.type)){
        var v1:Function = simplify(f.var1!);
        var v2:Function = simplify(f.var2!);
        if(v1.type == "c" && v2.type == "c"){return Cons(a:(f.v())(v1.cons,v2.cons));}
        if(f.type == "+"){return additionSimplify(f);}
        else if(f.type == "-"){return subtractionSimplify(f);}
        else if(f.type == "*"){return multiplicationSimplify(f);}
        else if(f.type == "/"){return divisionSimplify(f);}
        else if(f.type == "^"){return powerSimplify(f);}
    }else if(arrHas(arrOfUniary,f.type)){
        var v1:Function = simplify(f.var1!);
        if(v1.type=="c"){return Cons(a:f.v()(v1.cons));}
        if(f.type=="exp"){
            if(v1.type=="ln"){return simplify(v1.var1!);}
            return EXP(a:simplify(v1));
        }else if(f.type=="ln"){
            if(v1.type=="exp"){return simplify(v1.var1!);}
            return LN(a:simplify(v1));
        }else if(f.type=="sin"){
            if(v1.type=="arcsin"){return simplify(v1.var1!);}
            else if(v1.type=="arccos"){
                return simplify((CONS1-v1.var1!*v1.var1!)^CONS05);
            }else if(v1.type=="arctan"){
                return simplify(v1.var1!/((CONS1+v1.var1!*v1.var1!)^(CONS05)));
            }else if(v1.type=="*"){
                if(v1.var1!.sameAs(CONSN1)){return CONSN1*SIN(a:simplify(v1.var2!));}
                else if(v1.var2!.sameAs(CONSN1)){return CONSN1*SIN(a:simplify(v1.var1!));}
            }
            return SIN(a:simplify(v1));
        }else if(f.type=="cos"){
            if(v1.type=="arccos"){return simplify(v1.var1!);}
            else if(v1.type=="*"){
                if(v1.var1!.sameAs(CONSN1)){return COS(a:simplify(v1.var2!));}      //cos(-1*x)=cos(x)
                else if(v1.var2!.sameAs(CONSN1)){return COS(a:simplify(v1.var1!))}  //cos(x*-1)=cos(x)
            }
            return COS(a:simplify(v1));
        }else if(f.type=="tan"){
            if(v1.type=="arctan"){return simplify(v1.var1!);}
            return TAN(a:simplify(v1));
        }else if(f.type=="cot"){
            if(v1.type=="arccot"){return simplify(v1.var1!);}
            return COT(a:simplify(v1));
        }else if(f.type=="arctan"){
            if(v1.type=="tan"){return simplify(v1.var1!)}
            return ARCTAN(a:simplify(v1));
        }
    }
    if(f.var1 != nil){f.var1!=simplify(f.var1!);}
    if(f.var2 != nil){f.var2!=simplify(f.var2!);}
    
    return f;
}

func additionChain(f:Function)->Array<Function>{
    if(f.type != "+" && f.type != "-" && f.type != "*"){return [f];}

    var res:Array<Function>=Array<Function>();
    var v1 = f.var1!;
    var v2 = f.var2!;
    if(f.type=="+"){
        res+=additionChain(f.var1!);
        res+=additionChain(f.var2!);
    }else if(f.type=="-"){
        res+=additionChain(f.var1!);
        res+=additionChain(CONSN1*f.var2!)
    }else if(f.type=="*"){
        if(v1.type=="+"){res+=additionChain(v2*v1.var1!+v2*v1.var2!);}
        else if(v1.type=="-"){res+=additionChain(v2*v1.var1!-v2*v1.var2!);}
        else if(v2.type=="+"){res+=additionChain(v1*v2.var1!+v1*v2.var2!);}
        else if(v2.type=="-"){res+=additionChain(v1*v2.var1!-v1*v2.var2!);}
        else{res.append(f);}
    }
    return res;
}
func multiplicationChain(f:Function)->Array<Function>{
    if(f.type != "*" && f.type != "/"){return [f];}
    var res:Array<Function>=Array<Function>();
    var v1:Function=f.var1!;
    var v2:Function=f.var2!
    if(f.type=="*"){
        res+=multiplicationChain(v1);
        res+=multiplicationChain(v2);
    }else if(f.type=="/"){
        res+=multiplicationChain(v1);
        var denominator:Array<Function>=multiplicationChain(v2);
        for(var i:Int=0;i<count(denominator);i++){res.append(CONS1/denominator[i]);}
    }
    return res;
}
func simplifyMulChain(af:Array<Function>)->Function{
    var res:Array<Function>=Array<Function>();
    var sign:Double = 1;
    var multiOfCons:Double = 1;
    for(var i:Int=0;i<count(af);i++){
        if(af[i].sameAs(CONS0)){return CONS0;}
        else if(af[i].sameAs(CONSN1)){sign = -sign;}
        else if(af[i].type=="c"){multiOfCons = multiOfCons*af[i].cons;}
        else if(!af[i].sameAs(CONS1)){res.append(af[i]);}
    }
    if(res.isEmpty){return Cons(a:sign*multiOfCons);}
    var ress:Array<Function>=[res.removeLast()];
    while(!res.isEmpty){
        var last:Function=res.removeLast();
        var tem:Function=ErrorFunction();
        for(var i:Int=0;i<count(ress);i++){
            var sf=multiplicationSimplify(last*ress[i]);
            if(!sf.sameAs(last*ress[i])){
                ress[i]=sf;
                tem.type="error";
                break;
            }else{tem=last;}
        }
        if(tem.type != "error"){ress.append(tem);}
    }
    var multi:Function=ress[0];
    for(var i:Int=1;i<count(ress);i++){multi = multi*ress[i];}
    if(multiOfCons*sign != 1){multi = multi*Cons(a:multiOfCons*sign);}
    return multi;
}
func simplifyAddChain(af:Array<Function>)->Function{
    var afCopy:Array<Function> = Array<Function>();
    for(var i:Int=0;i<count(af);i++){
        var tem:Function=simplifyMulChain(multiplicationChain(af[i]));
        if(!tem.sameAs(CONS0)){afCopy.append(tem);}
    }
    if(afCopy.isEmpty){return CONS0;}
    var res:Array<Function>=Array<Function>();
    res.append(afCopy[0]);
    for(var i:Int=1;i<count(afCopy);i++){
        var last:Function=afCopy[i]
        var tem:Function=ErrorFunction();
        for(var j:Int=0;j<count(res);j++){
            var sf=additionSimplify(last+res[j]);
            if(sf.type != "+" && sf.type != "-"){
                res[j]=sf;
                tem.type="error";
                break;
            }else{tem=last;}
        }
        if(tem.type != "error"){res.append(tem);}
    }

    var sum:Function=res[0];
    for(var i:Int=1;i<count(res);i++){sum=sum+res[i];}
    return sum;
}
func occSimplify(f:Function)->Function{
    var g:Function=simplifyAddChain(additionChain(simplify(f)));
    while(!g.sameAs((simplify(g)))){
        g=simplify(g);
    }
    return g;
}

