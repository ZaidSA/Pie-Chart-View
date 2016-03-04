//
//  PieChartView.swift
//  Pie Chart View
//
//  Created by Hamish Knight on 04/03/2016.
//  Copyright © 2016 Redonkulous Apps. All rights reserved.
//

import UIKit

class PieChartView: UIView {

    /// An array of tuples representing the colors of the segments, and the values (the ratios will automatically be calculated)
    var values : [(color:UIColor, value:CGFloat)] = [(color:UIColor, value:CGFloat)]() {
        didSet {
            self.setNeedsDisplay() // re-draw view when the values get set
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.whiteColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func drawRect(rect: CGRect) {
        
        // get current context
        let ctx = UIGraphicsGetCurrentContext()
        
        // radius is the half the frame's width or height (whichever is smallest)
        let radius = ((frame.width < frame.height) ? frame.width:frame.height)*0.5
        
        // center of the view
        let viewCenter = CGPoint(x: bounds.size.width*0.5, y: bounds.size.height*0.5)
        
        // enumerate the total value of the segments
        var valueCount:CGFloat = 0
        for (_, value) in values {
            valueCount += value
        }
                
        var cumulativeAngle:CGFloat = -CGFloat(M_PI*0.5) // the starting angle is -90 degrees (top of the circle, as the context is flipped)
        for (color, value) in values { // loop through the values array
            
            // set fill color to the segment color
            CGContextSetFillColorWithColor(ctx, color.CGColor)
            
            // update the end angle of the segment
            let endAngle = cumulativeAngle+CGFloat(M_PI*2)*(value/valueCount)
            
            // move to the center of the pie chart
            CGContextMoveToPoint(ctx, viewCenter.x, viewCenter.y)
            
            // add arc from the center for each segment
            CGContextAddArc(ctx, viewCenter.x, viewCenter.y, radius, cumulativeAngle, endAngle, 0)
            
            // fill segment
            CGContextFillPath(ctx)
            
            cumulativeAngle = endAngle
        }
    }
}
