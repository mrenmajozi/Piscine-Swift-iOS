//
//  ShapeView.swift
//  MotionCube
//
//  Created by Njabulo MAJOZI on 2018/10/10.
//  Copyright © 2018 mrenmajozi. All rights reserved.
//

import UIKit

class ShapeView: UIView {

    private let _colours:[UIColor] =
        [UIColor.black, UIColor.blue, UIColor.brown, UIColor.cyan,
         UIColor.darkGray, UIColor.gray, UIColor.green, UIColor.magenta,
         UIColor.orange, UIColor.red, UIColor.yellow]
    private let _width:CGFloat = 100
    private let _heigth:CGFloat = 100
    
    init(shapeType _shapeType: String, x _x: CGFloat, y _y: CGFloat) {
        let _centerX = _x - (self._width/2)
        let _centerY = _y - (self._heigth/2)
        super.init(frame: CGRect(x: _centerX, y: _centerY, width: self._width, height: self._heigth))
        if _shapeType == "Circle" {
            self.layer.cornerRadius = 0.5 * 100
        }
        self.backgroundColor = self._colours[Int(arc4random_uniform(UInt32(self._colours.count)))]
        print("SHAPE TYPE: \(_shapeType)")
    }
    
//    func didTouch(location _location: CGPoint) -> Bool {
//        if (_location.x >= self.frame.minX), (_location.x <= self.frame.maxX){
//            if (_location.y >= self.frame.minY), (_location.y <= self.frame.maxY) {
//                return true
//            }
//        }
//        return false
//    }
//    
//    func getCurrentLocation() -> CGPoint {
//        return self.frame.origin
//    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
