//
//  ViewController.swift
//  ParserJSON
//
//  Created by 臧其龙 on 16/1/25.
//  Copyright © 2016年 臧其龙. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet var outputTextView: NSTextView!
    @IBOutlet var inputTextView: NSTextView!
    var resultArray = [String]()
    var resultString = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func parse(value:AnyObject, name:String) {
        if let valueTypeExist = DataValueType(rawValue: String(value.dynamicType))
        {
            if valueTypeExist == DataValueType.ZQLDictionary {
                resultArray.append(parseDictionary(value as! Dictionary<String, AnyObject>, name:name))
            }
            
            if valueTypeExist == DataValueType.ZQLArray {
                
                if let arrayType = value as? Array<AnyObject> {
                    if arrayType.count > 0 {
                        parse(arrayType[0], name: name)
                    }
                }
            }
            
        }
        
        
    }
    
    func parseDictionary(dic:Dictionary<String, AnyObject>, name:String) -> String{
        
        var structResutl = ""
        structResutl = "struct \(name) {\n"
        for(key, value) in dic{
            
            print("key is \(key), value type is \(value.dynamicType)")
            if let valueTypeExist = DataValueType(rawValue: String(value.dynamicType))
            {
                if valueTypeExist == DataValueType.ZQLDictionary {
                    resultArray.append(parseDictionary(value as! Dictionary<String, AnyObject>, name:key))
                }
                
                if valueTypeExist == DataValueType.ZQLArray {
                    
                    if let valueArray = value as? Array<AnyObject> {
                        if valueArray.count > 0 {
                            parse(valueArray[0], name: key)
                        }
                    }
                }
                
                structResutl += "\tvar \(key):\(valueTypeExist.type)?\n"
                //print("\tvar \(key):\(valueTypeExist.type)?")
            }
            
            
        }
        structResutl += "\n"
        structResutl += "\tfunc mapping(map: Map) {\n"
        for(key, value) in dic {
            structResutl += "\t\t\(key) <- map[\"\(key)\"]\n"
        }
        structResutl += "\t}"
        structResutl += "\n"
        structResutl += "}"
        
        return structResutl
    }
    
    @IBAction func convertJSON(sender:AnyObject) {
        
        resultString = ""
        //inputTextView.string = ""
        let data = inputTextView.textStorage?.string.dataUsingEncoding(NSUTF8StringEncoding)
        do {
            let dic = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)
            self.parse(dic, name: "root")
            
            for str in resultArray {
                resultString += "\n\(str)"
            }
            outputTextView.string = resultString

        }catch {
            print("serialization error")
        }
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

