//
//  Extension.swift
//  PopTipsView
//
//  Created by 飞流 on 2017/5/16.
//  Copyright © 2017年 飞流. All rights reserved.
//

import UIKit

extension String {
    
    func width(with font: UIFont) -> CGFloat {
        return self.boundingRect(with: CGSize.greatestFiniteMagnitude, options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil).width
    }
    
    func height(with font: UIFont, maxWidth: CGFloat) -> CGFloat {
        return self.boundingRect(with: CGSize(width: maxWidth, height: CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil).width
    }
}

extension CGSize {
    static var greatestFiniteMagnitude: CGSize {
        return CGSize(width: Double.greatestFiniteMagnitude, height: Double.greatestFiniteMagnitude)
    }
}
