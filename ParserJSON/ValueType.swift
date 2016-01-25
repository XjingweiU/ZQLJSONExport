//
//  ValueType.swift
//  Parser
//
//  Created by 臧其龙 on 16/1/25.
//  Copyright © 2016年 臧其龙. All rights reserved.
//

import Foundation

enum DataValueType:String {
    
    case ZQLDictionary = "__NSCFDictionary"
    case ZQLArray = "__NSCFArray"
    case ZQLNumber = "__NSCFNumber"
    case ZQLBool = "__NSCFBoolean"
    case ZQLString = "__NSCFString"
    case ZQLNSNull = "NSNull"
    case ZQLTaggedString = "NSTaggedPointerString"

    var type:String {
        switch self
        {
        case .ZQLString:
            return "String"
        case .ZQLTaggedString:
            return "String"
        case .ZQLArray:
            return "Array"
        case .ZQLNumber:
            return "NSNumber"
        case .ZQLBool:
            return "Bool"
        case .ZQLDictionary:
            return "Dictionary"
        case .ZQLNSNull:
            return "UnknownType"
        }
    }
}
