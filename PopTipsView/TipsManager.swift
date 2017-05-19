//
//  TipsManager.swift
//  PopTipsView
//
//  Created by 飞流 on 2017/5/16.
//  Copyright © 2017年 飞流. All rights reserved.
//

import UIKit

class TipsController: NSObject {
    
    static let share = TipsController()
    
    var triangleDiretion = Direction.down
    var point = CGPoint.zero {
        didSet {
            adjustSubviews(with: triangleDiretion)
        }
    }
    var customView = UIView()
    var triangleSize = CGSize(width: 10, height: 5)
    var contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0) {
        didSet {
            adjustContentView(with: triangleDiretion)
        }
    }
    
    var didTapedTipsView: ((Void) -> Void)?
    
    
    var cornerRadius: CGFloat = 5 {
        didSet {
            contentView.layer.cornerRadius = cornerRadius
            contentView.layer.masksToBounds = true
        }
    }
    private lazy var triangleView: TriangleView = {
        let triangleView = TriangleView(frame: CGRect.zero, color: UIColor.black)
        triangleView.alpha = 1.0
        return triangleView
    }()
    
    private lazy var contentView: UIControl = {
        let contentView = UIControl(frame: CGRect.zero)
        contentView.backgroundColor = UIColor.black
        contentView.layer.cornerRadius = self.cornerRadius
        contentView.layer.masksToBounds = true
        contentView.addTarget(self, action: #selector(didTapedContentView), for: .touchUpInside)
        return contentView
    }()
    
    private lazy var overlayView: UIButton = {
        let overlayView = UIButton(frame: self.inView.bounds)
        overlayView.addTarget(self, action: #selector(didClickedOverlayView), for: .touchUpInside)
        return overlayView
    }()
    
    private lazy var inView: UIView = window
    
    func show(message: String, at point: CGPoint, in view: UIView? = nil, masked: Bool = false) {
        let labelWidth = message.width(with: UIFont.systemFont(ofSize: 14))
        let messagelabel = UILabel(frame: CGRect(x: 0, y: 0, width: labelWidth, height: UIFont.systemFont(ofSize: 14).lineHeight))
        messagelabel.text = message
        messagelabel.textColor = UIColor.white
        messagelabel.font = UIFont.systemFont(ofSize: 14)
        show(customView: messagelabel, at: point, in: view)
    }
    
    func show(customView: UIView, at point: CGPoint, in view: UIView? = nil, masked: Bool = false) {
        remove()
        if let view = view {
            inView = view
        }
        if masked {
            inView.addSubview(overlayView)
        }
        inView.addSubview(triangleView)
        inView.addSubview(contentView)
        contentView.addSubview(customView)
        self.point = point
        self.customView = customView
        adjustSubviews(with: triangleDiretion)
    }
    
    func remove() {
        overlayView.removeFromSuperview()
        triangleView.removeFromSuperview()
        contentView.subviews.forEach { $0.removeFromSuperview() }
        contentView.removeFromSuperview()
    }
    
    private func adjustSubviews(with direction: Direction) {
        adjustTriangleView(with: direction)
        adjustContentView(with: direction)
    }
    
    private func adjustTriangleView(with direction: Direction) {
        var triangleX = point.x - triangleSize.width * 0.5
        if triangleX < 0 { triangleX = max(0, triangleX) }
        triangleX = max(0, triangleX)
        triangleX = min(triangleX, inView.frame.size.width - triangleSize.width)
        switch direction {
        case .up:
            triangleView.direction = .up
            triangleView.frame = CGRect(origin: CGPoint(x: triangleX, y: point.y), size: triangleSize)
        case .down:
            triangleView.direction = .down
            triangleView.frame = CGRect(origin: CGPoint(x: triangleX, y: point.y - triangleSize.height), size: triangleSize)
        default:
            break
        }
    }
    
    private func adjustContentView(with direction: Direction) {
        let contentViewWidth = customView.frame.size.width + contentInsets.left + contentInsets.right
        let contentHeight = customView.frame.size.height + contentInsets.top + contentInsets.bottom
        let contentX = triangleView.frame.origin.x / (inView.frame.size.width - triangleSize.width) * (inView.frame.size.width - contentViewWidth)
        switch direction {
        case .up:
            contentView.frame = CGRect(x: contentX, y: triangleView.frame.maxY, width: contentViewWidth, height: contentHeight)
            if contentView.frame.maxY > inView.frame.size.height {
                adjustSubviews(with: .down)
            }
        case .down:
            contentView.frame = CGRect(x: contentX, y: triangleView.frame.midY - contentHeight, width: contentViewWidth, height: contentHeight)
            if contentView.frame.minY < 0 {
                adjustSubviews(with: .up)
            }
        default:
            break
        }
        customView.center = CGPoint(x: contentView.frame.width / 2, y: contentView.frame.height / 2)
    }
    
    @objc private func didClickedOverlayView() {
        remove()
    }
    
    @objc private func didTapedContentView() {
        didTapedTipsView?()
    }

}
