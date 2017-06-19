//
//  Result.swift
//  FindIt
//
//  Created by Eystein Bye on 19/06/2017.
//  Copyright © 2017 CoreML. All rights reserved.
//

import Foundation
import Vision

struct Result {
    
    public static func objectFromConfidence(confidence: VNConfidence, object: String) -> String {
        if (confidence.isLess(than: 0.1)) { return "I don´t know what this is" }
        if (confidence.isLess(than: 0.3)) { return "Could this be \(object)?" }
        if (confidence.isLess(than: 0.5)) { return "This must be \(object)" }
        return "This is \(object)"
    }
    
}
