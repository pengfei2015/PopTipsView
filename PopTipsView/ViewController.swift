//
//  ViewController.swift
//  PopTipsView
//
//  Created by 飞流 on 2017/5/16.
//  Copyright © 2017年 飞流. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let manager = TipsController.share
    
    override func viewDidLoad() {
        super.viewDidLoad()

        manager.show(message: "测试测试", at: CGPoint(x: 123, y: 123))
        manager.contentInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        manager.cornerRadius = 0
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        let point = touches.first?.location(in: view) ?? CGPoint.zero
        manager.show(message: "我是小提示啊，小提示", at: point, in: view)
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let point = touches.first?.location(in: view) ?? CGPoint.zero
        manager.point = point
    }
}

