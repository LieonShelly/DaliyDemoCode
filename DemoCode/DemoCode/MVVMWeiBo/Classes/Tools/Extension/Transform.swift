//
//  Transform.swift
//  DemoCode
//
//  Created by lieon on 16/9/18.
//  Copyright © 2016年 lieon. All rights reserved.
//

import UIKit
import ObjectMapper

class IntStringTransform: TransformType {
    typealias Object = Int
    typealias JSON = String
    
    func transformFromJSON(_ value: Any?) -> Int? {
        if let time = value as? String {
            return Int(time)
        }
        return nil
    }
    
    func transformToJSON(_ value: Int?) -> String? {
        if let date = value {
            return String(date)
        }
        return nil
    }
}

class ArrayOfURLTransform: TransformType {
    typealias Object = [NSURL?]
    typealias JSON = String
    
    func transformFromJSON(_ value: Any?) -> Array<NSURL?>? {
        if let time = value as? [String] {
            return time.map { return NSURL(string: $0)}
        }
        return nil
    }
    
    func transformToJSON(_ value: Array<NSURL?>?) -> String? {
        if let date = value {
            let arry = date.flatMap { return $0?.absoluteString }
            return arry.joined(separator: ",")
        }
        return nil
    }
}

class FloatStringTransform: TransformType {
    typealias Object = Float
    typealias JSON = String
    
    func transformFromJSON(_ value: Any?) -> Float? {
        if let time = value as? String {
            return Float(time)
        }
        return nil
    }
    
    func transformToJSON(_ value: Float?) -> String? {
        if let date = value {
            return String(date)
        }
        return nil
    }
}

class BoolStringTransform: TransformType {
     typealias Object = Bool
     typealias JSON = String
    
     func transformFromJSON(_ value: Any?) -> Bool? {
        if let time = value as? String {
            if time == "1" {
                return true
            } else {
                return false
            }
        }
        return nil
    }
    
     func transformToJSON(_ value: Bool?) -> String? {
        if let date = value {
            if date == true {
                return "1"
            } else {
                return "0"
            }
        }
        return nil
    }
}

class DoubleStringTransform: TransformType {
     typealias Object = Double
     typealias JSON = String
    
     func transformFromJSON(_ value: Any?) -> Double? {
        if let time = value as? String {
            return Double(time)
        }
        return nil
    }
    
     func transformToJSON(_ value: Double?) -> String? {
        if let date = value {
            return String(date)
        }
        return nil
    }
}

class NSDataStringTransform: TransformType {
    typealias Object = NSData
    typealias JSON = String
    
    func transformFromJSON(_ value: Any?) -> NSData? {
        if let time = value as? String {
            return NSData(base64Encoded: time, options: .ignoreUnknownCharacters)
        }
        return nil
    }
    
    func transformToJSON(_ value: NSData?) -> String? {
        if let date = value {
            return date.base64EncodedString(options: .lineLength64Characters)
        }
        return nil
    }
}

class URLStringTransform: TransformType {
    typealias Object = URL
    typealias JSON = String
    
    func transformFromJSON(_ value: Any?) -> URL? {
        if let str = value as? String {
            return URL(string: str)
        }
        return nil
    }
    
    func transformToJSON(_ value: URL?) -> String? {
        if let url = value {
            return url.absoluteString
        }
        return nil
    }
}
