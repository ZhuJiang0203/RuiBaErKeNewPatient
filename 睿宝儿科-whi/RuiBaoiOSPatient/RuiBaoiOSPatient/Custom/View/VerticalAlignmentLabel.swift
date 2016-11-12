//
// VerticalAlignmentLabel.swift
//  RuiBaoiOSPatient
//
//  Created by whj on 16/11/1.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//

import UIKit

enum VerAlignment {
    case top
    case center
    case bottom
}

class VerticalAlignmentLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    var verAlignment: VerAlignment? {
        didSet{
            if verAlignment != .center {
                setNeedsDisplay()
            }
        }
    }
    
    override func drawText(in rect: CGRect) {
        let actualRect = textRect(forBounds: rect, limitedToNumberOfLines: numberOfLines)
        super.drawText(in: actualRect)
    }
    
    override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        
        var textRect = super.textRect(forBounds: bounds, limitedToNumberOfLines: numberOfLines)
        
        switch verAlignment! {
        case .top:
            textRect.origin.y = bounds.origin.y;
        case .bottom:
            textRect.origin.y = bounds.origin.y + (bounds.size.height - textRect.size.height) / 2.0;
        default:
            textRect.origin.y = bounds.origin.y + bounds.size.height - textRect.size.height;
        }
        return textRect
    }
}
