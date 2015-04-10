//
//  libB.swift
//  sssss
//
//  Created by Hanghang Zhang on 3/20/15.
//  Copyright (c) 2015 Hanghang Zhang. All rights reserved.
//

import Foundation
import UIKit
var fH:CGFloat = 17;
var fW:CGFloat = 9;
var fontSize:CGFloat=11;
var sfontSize:CGFloat=5.5;
var sfH:CGFloat=9.5;
var sfW:CGFloat=4.5;
let arrOfFunc = [
    "sinh","cosh","tanh","coth","sech","csch",
    "sin","cos","tan","cot","sec","csc",
    "arcsinh","arccosh","arctanh","arccoth","arcsech","arccsch",
    "arcsin","arccos","arctan","arccot","arcsec","exp","arccsc",
    "+","-","*","/","^","(",")","{","}","[","]","x","d","integral",","];
let arrOfUniary = [
    "sinh","cosh","tanh","coth","sech","csch",
    "sin","cos","tan","cot","sec","csc",
    "arcsinh","arccosh","arctanh","arccoth","arcsech","arccsch",
    "arcsin","arccos","arctan","arccot","arcsec","arccsc","exp","ln","d"];
let arrOfBinary=["+","-","*","/","^"];
let arrOfLBracket=["(","{","["];
let arrOfRBracket=[")","}","]"];
let arrOfElement = arrOfBinary + arrOfUniary + arrOfLBracket + arrOfRBracket + ["x"];
let arrOfNum = ["0","1","2","3","4","5","6","7","8","9","."];
let arrOfOperator = arrOfUniary + arrOfBinary+["integral"];
let arrConflict1=arrOfUniary+["x"]+arrOfRBracket;
let arrConflict2=arrOfUniary+["x"]+arrOfLBracket;