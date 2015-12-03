//
//  XMFileManager.swift
//  
//
//  Created by David McGraw on 12/1/15.
//
//

import XCPlayground
import Foundation

public class XMFileManager: NSObject {
    
    // ?? Can only declare static properties on a type
    private struct Constants {
        static let sharedInstance = XMFileManager()
    }
    
    public class var shared: XMFileManager {
        return Constants.sharedInstance
    }
 
    public func loadStringInputFromResource(fileName: String) -> String {
        var content = ""
        if let path = NSBundle.mainBundle().pathForResource(fileName, ofType: "txt"),
           let data = NSFileManager.defaultManager().contentsAtPath(path),
           let encoded = String(data: data, encoding: NSUTF8StringEncoding) {
            
            content = encoded
        }
        return content
    }
}
