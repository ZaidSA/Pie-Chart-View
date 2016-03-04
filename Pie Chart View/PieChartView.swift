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
    var values = [(color:UIColor, value:CGFloat)]() {
        didSet {
            self.setNeedsDisplay() // re-draw view when the values get set
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        opaque = false
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
        
        // enumerate the total value of the segments (by first generating an array of CGFloat values from the tuple, then using reduce to sum them)
        let valueCount = values.map{$0.value}.reduce(0, combine: +)
        
        // the starting angle is -90 degrees (top of the circle, as the context is flipped). By default, 0 is the right hand side of the circle.
        var startAngle:CGFloat = -CGFloat(M_PI*0.5)
        
        for (color, value) in values { // loop through the values array
            
            // set fill color to the segment color
            CGContextSetFillColorWithColor(ctx, color.CGColor)
            
            // update the end angle of the segment
            let endAngle = startAngle+CGFloat(M_PI*2)*(value/valueCount)
            
            // move to the center of the pie chart
            CGContextMoveToPoint(ctx, viewCenter.x, viewCenter.y)
            
            // add arc from the center for each segment (anticlockwise is specified for the arc, but as the view flips the context, it will produce a clockwise arc)
            CGContextAddArc(ctx, viewCenter.x, viewCenter.y, radius, startAngle, endAngle, 0)
            
            // fill segment
            CGContextFillPath(ctx)
            
            // update starting angle of the next segment to the ending angle of this segment
            startAngle = endAngle
        }
    }
}
