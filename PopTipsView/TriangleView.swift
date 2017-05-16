//
//  TriangleView.swift
//  PopTipsView
//
//  Created by 飞流 on 2017/5/16.
//  Copyright © 2017年 飞流. All rights reserved.
//

import UIKit

enum Direction {
    case up
    case down
    case left
    case right
}

class TriangleView: UIView {
    var direction: Direction = .up {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var color: UIColor
    
    init(frame: CGRect, color: UIColor) {
        self.color = color
        super.init(frame: frame)
        backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        context.setFillColor(color.cgColor)
        switch direction {
        case .up:
            context.move(to: CGPoint(x: 0, y: rect.height))
            context.addLine(to: CGPoint(x: rect.width, y: rect.height))
            context.addLine(to: CGPoint(x: rect.width * 0.5, y: 0))
        case .down:
            context.move(to: CGPoint(x: 0, y: 0))
            context.addLine(to: CGPoint(x: rect.width, y: 0))
            context.addLine(to: CGPoint(x: rect.width * 0.5, y: rect.height))
        case .left:
            context.move(to: CGPoint(x: rect.width, y: 0))
            context.addLine(to: CGPoint(x: rect.width, y: rect.height))
            context.addLine(to: CGPoint(x: 0, y: rect.height * 0.5))
        case .right:
            context.move(to: CGPoint(x: 0, y: 0))
            context.addLine(to: CGPoint(x: 0, y: rect.height))
            context.addLine(to: CGPoint(x: rect.width, y: rect.height * 0.5))
        }
        context.fillPath()
    }
}
