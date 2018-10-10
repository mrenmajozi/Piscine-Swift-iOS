//
//  MotionCubeData.swift
//  MotionCube
//
//  Created by Njabulo MAJOZI on 2018/10/10.
//  Copyright © 2018 mrenmajozi. All rights reserved.
//

import Foundation

class MotionCubeData {
    private static var _shapeTypes:[String] = ["Circle" ,"Square"]
    
    static func getRandomShapeType() -> String {
        return MotionCubeData._shapeTypes[Int(arc4random_uniform(UInt32(MotionCubeData._shapeTypes.count)))]
    }
}
