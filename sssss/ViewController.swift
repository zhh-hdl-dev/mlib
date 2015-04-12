//
//  ViewController.swift
//  sssss
//
//  Created by Hanghang Zhang on 3/6/15.
//  Copyright (c) 2015 Hanghang Zhang. All rights reserved.
//

import UIKit
let filemgr = NSFileManager.defaultManager();
let currentPath = filemgr.currentDirectoryPath;
class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    private var resDirector:SView?;
    
    @IBOutlet weak var varInfo: UIScrollView!
    
    @IBOutlet weak var SearchBar: UISearchBar!
    
    @IBOutlet weak var TableView: UITableView!
    
    
    @IBOutlet weak var FunctionTextView: UITextView!
    
    var searchActive : Bool = false;
    var datadetail:Array<String> = ["San Francisco","New York","San Jose","Chicago","Los Angeles","Austin","Seattle"];
    var data:Array<String> = ["San Francisco","New York","San Jose","Chicago","Los Angeles","Austin","Seattle"];
    var filtered:Array<String> = [];
    
    override func viewDidLoad(){
        
        
        
        
        
        
        
        
        
        
        
        super.viewDidLoad()
        resDirector=SView(scV:varInfo);
        /* Setup delegates */
        TableView.delegate = self;
        TableView.dataSource = self;
        SearchBar.delegate = self;
        
    }
    
    @IBAction func switchPage(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex{
        case 0:
            general.hidden=false;
            variables.hidden=true;
            setting.hidden=true;
            manual.hidden=true;
        case 1:
            general.hidden=true;
            variables.hidden=false;
            setting.hidden=true;
            manual.hidden=true;
        case 2:
            general.hidden=true;
            variables.hidden=true;
            setting.hidden=false;
            manual.hidden=true;
        case 3:
            general.hidden=true;
            variables.hidden=true;
            setting.hidden=true;
            manual.hidden=false;
        default:
            general.hidden=false;
            variables.hidden=true;
            setting.hidden=true;
            manual.hidden=true;
        }
    }
    //======================================
    @IBOutlet weak var conFirm: UIButton!
    @IBOutlet weak var usrInput: UITextField!
    @IBOutlet weak var resView: UIView!
    //======================================
    @IBOutlet weak var general: UIView!
    @IBOutlet weak var manual: UIView!
    @IBOutlet weak var setting: UIView!
    @IBOutlet weak var variables: UIView!
    //=======================================
    @IBAction func getRes(sender: AnyObject) {
        var slist=resView.subviews;
        for subv in slist{
            subv.removeFromSuperview();
        }
        var rawStr:String = usrInput.text;
        var rawRes:Array<String>? = inputStrProcess(arrOfFunc,arrOfNum,rawStr);
        var surfixRes:Array<String> = infixToSuffix(rawRes!);
        var resFunc:Function=suffixExpAnalysis(surfixRes);
        resView.addSubview(occSimplify(resFunc).pp());
    }
    
    @IBAction func didtaped(sender: UITapGestureRecognizer) {
        general.endEditing(true);
        variables.endEditing(true);
        setting.endEditing(true);
        manual.endEditing(true);
    }
    
    //========================Variables
    @IBOutlet weak var matrixField: UIScrollView!;
    
    @IBOutlet weak var matrixRowCtrl: UIStepper!
    @IBOutlet weak var matrixName: UITextField!
    
    @IBOutlet weak var constField: UITextField!
    
    @IBOutlet weak var constName: UITextField!
    @IBOutlet weak var storeInfoField: UIView!
    @IBOutlet weak var funcName: UITextField!
    @IBOutlet weak var funcExpr: UITextField!
    
    var dicOfMatrix:Dictionary<String,Matrix>=Dictionary<String,Matrix>();
    var dicOfConst:Dictionary<String,Double>=Dictionary<String,Double>();
    var dicOfFun:Dictionary<String,Function>=Dictionary<String,Function>();
    var uiRowOfMatrix:Array<UITextField>=Array<UITextField>();
    var arrOfConst:Array<String>=Array<String>();
    var arrOfMat:Array<String>=Array<String>();
    var arrOfFun:Array<String>=Array<String>();
    var arrOfAllEle:Array<String>{get{return resDirector!.getArrOfMN();}}
    
    @IBAction func constAdd(sender:UIButton) {
        if((!constName.text.isEmpty)&&(!arrHas(arrOfAllEle,constName.text))){
            dicOfConst[constName.text]=(constField.text as NSString).doubleValue;
            resDirector?.addL(constName.text+":C:"+constField.text);
            arrOfConst.append(constName.text);
            constName.text="";
            constField.text="";
        }
    }
    @IBAction func matrixAdd(sender: UIButton){
        if((!matrixName.text.isEmpty)&&(!arrHas(arrOfAllEle,matrixName.text))){
            var res:Array<Double>=Array<Double>();
            var abstract:String="";
            for(var i:Int=0;i<count(uiRowOfMatrix);i++){
                var str:String=uiRowOfMatrix[i].text;
                abstract+=str+",";
                var row = str.componentsSeparatedByString(",");
                for(var j:Int=0;j<count(row);j++){
                    res.append((row[j] as NSString).doubleValue);
                }
            }
            var resM:Matrix=Matrix(r:count(uiRowOfMatrix),c:count(res)/count(uiRowOfMatrix),m:res);
            abstract = String(count(uiRowOfMatrix))+"x"+String(count(res)/count(uiRowOfMatrix))+":"+abstract;
            dicOfMatrix[matrixName.text]=resM;
            resDirector?.addL(matrixName.text+":M:"+abstract);
            arrOfMat.append(matrixName.text);
            for(;matrixRowCtrl.value>0;matrixRowCtrl.value-=1){
                uiRowOfMatrix.removeLast().removeFromSuperview();
            }
            matrixName.text="";
        }
    }
    @IBAction func funcAdd(sender: UIButton) {
        if((!funcName.text.isEmpty)&&(!arrHas(arrOfAllEle,funcName.text))){
            dicOfFun[funcName.text]=suffixExpAnalysis(infixToSuffix(inputStrProcess(arrOfFunc,arrOfNum,funcExpr.text)));
            resDirector?.addL(funcName.text+":F:"+funcExpr.text);
            arrOfFun.append(funcName.text);
            funcName.text="";
            funcExpr.text="";
        }
    }
    
    @IBAction func ctrlNumOfMatrixRows(sender: UIStepper) {
        if (sender.value>Double(count(uiRowOfMatrix))){
            var newT:UITextField=UITextField(frame:CGRectMake(0,24*CGFloat(count(uiRowOfMatrix)),160,24));
            newT.borderStyle = .RoundedRect;
            uiRowOfMatrix.append(newT);
            matrixField.addSubview(newT);
        }else{
            uiRowOfMatrix.removeLast().removeFromSuperview();
        }
    }
    
    //========================Manual
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchActive = true;
    }
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchActive = false;
    }
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchActive = false;
    }
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchActive = false;
    }
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        filtered = data.filter({ (text) -> Bool in
            let tmp: NSString = text
            let range = tmp.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
            return range.location != NSNotFound
        })
        if(filtered.count == 0){
            searchActive = false;
        } else {
            searchActive = true;
        }
        self.TableView.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(searchActive) {
            return filtered.count;
        }
        return data.count;
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell")! as! UITableViewCell
        
        if(searchActive){
            cell.textLabel?.text = filtered[indexPath.row]
        } else {
            cell.textLabel?.text = data[indexPath.row]
        }
        
        return cell;
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("You selected cell #\(indexPath.row)!")
        FunctionTextView.text = datadetail[indexPath.row]
        
    }
    func loadSavingData(director:SView,fileName:String){}
}

