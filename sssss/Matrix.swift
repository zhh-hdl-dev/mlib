//
//  Matrix.swift
//  lib
//
//  Created by Hanghang Zhang on 2/24/15.
//  Copyright (c) 2015 Hanghang Zhang. All rights reserved.
//

import Foundation
class Matrix{
    var nor:Int=0;//number of rows
    var noc:Int=0;//number of columns
    var mat:Array<Double>=Array<Double>();
    init(r:Int,c:Int,m:Array<Double>){
        self.nor=r;
        self.noc=c;
        for(var i=0;i<m.endIndex;i++){
            self.mat.append(m[i]);
        }
    }
    func minor(r:Int,c:Int)->Matrix?{
        var A:Array<Double>=Array<Double>();
        for(var j=1;j <= nor;j++){
            for(var i=1;i<=nor;i++){
                if((i != r)&&(j != c)){
                    A.append(getE(i,c:j));
                }
            }
        }
        return Matrix(r:nor-1,c:nor-1,m:A);
    }
    func getE(r:Int,c:Int)->Double{
        return mat[(r-1)*noc+c-1];
    }//get element at r,c
    func det()->Double?{
        if(nor != noc){
            return nil;
        }else if(nor==1){
            return mat[0];
        }else if(nor==2){
            return getE(1,c:1)*getE(2,c:2)-getE(1,c:2)*getE(2,c:1);
        }
        var sum:Double=0;
        for(var i=1;i<=nor;i++){
            sum+=Ind(i+1)*getE(1,c:i)*minor(1,c:i)!.det()!
        }
        return sum;
    }
    func trace()->Double?{
        if(nor != noc){
            return nil;
        }
        var sum:Double=0;
        for(var i=1;i<=nor;i++){
            sum+=getE(i,c:i);
        }
        return sum;
    }
    func p(){
        for(var i=1;i<=noc;i++){
            for(var j=1;j<=nor;j++){
                print(getE(i,c:j));
                print("\t");
            }
            println();
        }
    }
    func inv()->Matrix?{return nil;}//inverse matrix
}



