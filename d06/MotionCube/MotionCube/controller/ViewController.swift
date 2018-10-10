//
//  ViewController.swift
//  MotionCube
//
//  Created by Njabulo MAJOZI on 2018/10/10.
//  Copyright © 2018 mrenmajozi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private var _shapeView:ShapeView?
    private var _shapes:[UIView] = []
    private var _dynamicAnimator:UIDynamicAnimator?
    private var _gravityBehavior:UIGravityBehavior?
    private var _boundries:UICollisionBehavior?
    private var _bounce:UIDynamicItemBehavior?
    private var _pannedShaped:ShapeView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapHandler))
//        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panHandler))
        
        view.addGestureRecognizer(tapGesture)
//        view.addGestureRecognizer(panGesture)
    }
    
    @objc private func tapHandler(gesture: UITapGestureRecognizer){
        switch gesture.state {
        case .began:
            print("Tap Began")
        case .changed:
            print("Tap Changed")
        case .possible:
            print("Tap Possible")
        case .failed:
            print("Tap Failed")
        case .cancelled:
            print("Tap Cancelled")
        default:
            print("Tap End")
            self.displayShape(location: gesture.location(in: view))
        }
    }
    
    private func displayShape(location _location: CGPoint) {
        print("TAPPED AT: X(\(_location.x)) Y(\(_location.y))")
        self._shapeView = ShapeView(shapeType: MotionCubeData.getRandomShapeType(), x: _location.x, y: _location.y)
        view.addSubview(self._shapeView!)
        
        self._shapes.append(self._shapeView!)
        
        self._dynamicAnimator = UIDynamicAnimator(referenceView: self.view)
        
        self._gravityBehavior = UIGravityBehavior(items: self._shapes)
        self._gravityBehavior?.gravityDirection = CGVector(dx: 0.0, dy: 1.0)
        
        self._boundries = UICollisionBehavior(items: self._shapes)
        self._boundries?.translatesReferenceBoundsIntoBoundary = true
        
        self._bounce = UIDynamicItemBehavior(items: self._shapes)
        self._bounce?.elasticity = 0.5
        
        self._dynamicAnimator?.addBehavior(self._gravityBehavior!)
        self._dynamicAnimator?.addBehavior(self._boundries!)
        self._dynamicAnimator?.addBehavior(self._bounce!)
    }
    
//    @objc private func panHandler(gesture: UIPanGestureRecognizer) {
//        switch gesture.state {
//        case .began:
//            print("Pan Began")
//            self._pannedShaped = self.getTouchedShape(location: gesture.location(in: view)) as? ShapeView
//            self._gravityBehavior?.removeItem(self._pannedShaped!)
//        case .changed:
//            print("Pan Changed")
//            gesture.view?.center = (self._pannedShaped?.getCurrentLocation())!
//            self._dynamicAnimator?.updateItem(usingCurrentState: self._pannedShaped!)
//
//            //gesture.view?.center = gesture.location(in: gesture.view?.superview)
//            //_dynamicAnimator?.updateItem(usingCurrentState: gesture.view!)
//        case .possible:
//            print("Pan Possible")
//        case .failed:
//            print("Pan Failed")
//        case .cancelled:
//            print("Pan Cancelled")
//        default:
//            print("Pan End")
//            self._gravityBehavior?.addItem(self._pannedShaped!)
//            self._pannedShaped = nil
//            //self._gravityBehavior?.addItem(gesture.view!)
//        }
//    }
    
//    private func getTouchedShape(location _location: CGPoint) -> UIDynamicItem? {
//        for _shape in self._shapes {
//            let _s = _shape as! ShapeView
//            if _s.didTouch(location: _location) {
//                print(_s)
//                _s.frame = CGRect(x: 50, y: 50, width: 200, height: 200)
//                return _s as UIDynamicItem
//            }
//        }
//        return nil
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
