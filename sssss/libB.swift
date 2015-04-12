//
//  libB.swift
//  sssss
//
//  Created by Hanghang Zhang on 3/20/15.
//  Copyright (c) 2015 Hanghang Zhang. All rights reserved.
//

import Foundation
import UIKit
let CONS0:Function = Cons(a:0);
let CONS1:Function = Cons(a:1);
let CONSN1:Function = Cons(a:-1);
let CONS05:Function = Cons(a:0.5);
let CONS2:Function = Cons(a:2);
var fH:CGFloat = 17;
var fW:CGFloat = 9;
var fontSize:CGFloat=11;
var sfontSize:CGFloat=5.5;
var sfH:CGFloat=9.5;
var sfW:CGFloat=4.5;
let arrOfUniary:Array<String> = [
    "sinh","cosh","tanh","coth","sech","csch",
    "sin","cos","tan","cot","sec","csc",
    "arcsinh","arccosh","arctanh","arccoth","arcsech","arccsch",
    "arcsin","arccos","arctan","arccot","arcsec","arccsc","exp","ln","d"];
let arrOfBinary:Array<String>=["+","-","*","/","^","|"];
let arrOfLBracket:Array<String>=["(","{","["];
let arrOfRBracket:Array<String>=[")","}","]"];
let arrOfElement:Array<String> = arrOfBinary + arrOfUniary + arrOfLBracket + arrOfRBracket + ["x"];
let arrOfNum:Array<String> = ["0","1","2","3","4","5","6","7","8","9","."];
let arrOfOperator:Array<String> = arrOfUniary + arrOfBinary+["integral"];
let arrOfFunc:Array<String> = arrOfUniary+arrOfBinary+arrOfLBracket+arrOfRBracket+["x","integral",","];
let arrConflict1:Array<String>=arrOfUniary+["x"]+arrOfRBracket;
let arrConflict2:Array<String>=arrOfUniary+["x"]+arrOfLBracket;
let arrOfBegins:Array<String>=arrOfLBracket+["^","/","*",","];