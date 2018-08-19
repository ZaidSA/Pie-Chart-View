//
//  PieChartView.swift
//  Pie Chart View
//
//  Created by Hamish Knight on 04/03/2016.
//  Copyright © 2016 Redonkulous Apps. All rights reserved.
//

import UIKit

#if !swift(>=4.2)
extension NSAttributedString {
  typealias Key = NSAttributedStringKey
}
#endif

/// Defines a segment of the pie chart.
struct LabelledSegment {

  /// The color of the segment.
  var color: UIColor

  /// The name of the segment.
  var name: String

  /// The value of the segment.
  var value: CGFloat
}

extension Collection where Element : Numeric {
  func sum() -> Element {
    return reduce(0, +)
  }
}

extension NumberFormatter {
  static let toOneDecimalPlace: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.minimumFractionDigits = 0
    formatter.maximumFractionDigits = 1
    return formatter
  }()
}

extension CGRect {
  init(centeredOn center: CGPoint, size: CGSize) {
    self.init(
      origin: CGPoint(
        x: center.x - size.width * 0.5, y: center.y - size.height * 0.5
      ),
      size: size
    )
  }

  var center: CGPoint {
    return CGPoint(
      x: origin.x + size.width * 0.5, y: origin.y + size.height * 0.5
    )
  }
}

extension CGPoint {
  func projected(by value: CGFloat, angle: CGFloat) -> CGPoint {
    return CGPoint(
      x: x + value * cos(angle), y: y + value * sin(angle)
    )
  }
}

extension UIColor {
  struct RGBAComponents {
    var red: CGFloat
    var green: CGFloat
    var blue: CGFloat
    var alpha: CGFloat
  }

  var rgbaComponents: RGBAComponents {
    var components = RGBAComponents(red: 0, green: 0, blue: 0, alpha: 0)
    getRed(&components.red, green: &components.green, blue: &components.blue,
           alpha: &components.alpha)
    return components
  }

  var brightness: CGFloat {
    return rgbaComponents.brightness
  }
}

extension UIColor.RGBAComponents {
  var brightness: CGFloat {
    return (red + green + blue) / 3
  }
}

struct SegmentLabelFormatter {
  private let _getLabel: (LabelledSegment) -> String
  init(_ getLabel: @escaping (LabelledSegment) -> String) {
    self._getLabel = getLabel
  }
  func getLabel(for segment: LabelledSegment) -> String {
    return _getLabel(segment)
  }
}

extension SegmentLabelFormatter {
  /// Display the segment's name along with its value in parentheses.
  static let nameWithValue = SegmentLabelFormatter { segment in
    let formattedValue = NumberFormatter.toOneDecimalPlace
      .string(from: segment.value as NSNumber) ?? "\(segment.value)"
    return "\(segment.name) (\(formattedValue))"
  }

  /// Only display the segment's name.
  static let nameOnly = SegmentLabelFormatter { $0.name }
}

class PieChartView : UIView {

  /// An array of structs representing the segments of the pie chart.
  var segments = [LabelledSegment]() {
    // Re-draw view when the values get set.
    didSet { setNeedsDisplay() }
  }

  /// Defines whether the segment labels should be shown when drawing the pie
  /// chart.
  var showSegmentLabels = true {
    didSet { setNeedsDisplay() }
  }

  /// The font to be used on the segment labels
  var segmentLabelFont = UIFont.systemFont(ofSize: 20) {
    didSet {
      textAttributes[.font] = segmentLabelFont
      setNeedsDisplay()
    }
  }

  /// A formatter describing how to map a segment to its displayed label.
  var segmentLabelFormatter = SegmentLabelFormatter.nameWithValue {
    didSet { setNeedsDisplay() }
  }

  // The ratio of how far away from the center of the pie chart the text
  // will appear.
  var textPositionOffset: CGFloat = 0.67 {
    didSet { setNeedsDisplay() }
  }

  private let paragraphStyle: NSParagraphStyle = {
    var p = NSMutableParagraphStyle()
    p.alignment = .center
    return p.copy() as! NSParagraphStyle
  }()

  private lazy var textAttributes: [NSAttributedString.Key: Any] = [
    .paragraphStyle: self.paragraphStyle, .font: self.segmentLabelFont
  ]

  override init(frame: CGRect) {
    super.init(frame: frame)
    // When overriding drawRect, you must specify this to maintain transparency.
    isOpaque = false
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("Not supported.")
  }

  override func draw(_ rect: CGRect) {

    // Get current context.
    guard let ctx = UIGraphicsGetCurrentContext() else { return }

    // Radius is the half the frame's width or height (whichever is smallest).
    let radius = min(frame.width, frame.height) * 0.5

    // Center of the view.
    let viewCenter = bounds.center

    // Enumerate the total value of the segments by using reduce to sum them.
    let valueCount = segments.lazy.map { $0.value }.sum()

    // The starting angle is -90 degrees (top of the circle, as the context is
    // flipped). By default, 0 is the right hand side of the circle, with the
    // positive angle being in an anti-clockwise direction (same as a unit
    // circle in maths).
    var startAngle: CGFloat = -.pi * 0.5

    // Loop through the values array.
    for segment in segments {

      // Get the end angle of this segment.
      let endAngle = startAngle + .pi * 2 * (segment.value / valueCount)
      defer {
        // Update starting angle of the next segment to the ending angle of this
        // segment.
        startAngle = endAngle
      }

      // Set fill color to the segment color.
      ctx.setFillColor(segment.color.cgColor)

      // Move to the center of the pie chart.
      ctx.move(to: viewCenter)

      // Add arc from the center for each segment (anticlockwise is specified
      // for the arc, but as the view flips the context, it will produce a
      // clockwise arc)
      ctx.addArc(center: viewCenter, radius: radius, startAngle: startAngle,
                 endAngle: endAngle, clockwise: false)

      // Fill segment.
      ctx.fillPath()

      if showSegmentLabels { // Do text rendering.

        // Get the angle midpoint.
        let halfAngle = startAngle + (endAngle - startAngle) * 0.5;

        // Get the 'center' of the segment. It's slightly biased to the outer
        // edge, as it's wider.
        let segmentCenter = viewCenter
          .projected(by: radius * textPositionOffset, angle: halfAngle)

        // Text to render – the segment value is formatted to 1dp if needed to
        // be displayed.
        let textToRender = segmentLabelFormatter
          .getLabel(for: segment) as NSString

        // If too light, use black. If too dark, use white.
        textAttributes[.foregroundColor] =
          segment.color.brightness > 0.4 ? UIColor.black : UIColor.white

        let textRenderSize = textToRender.size(withAttributes: textAttributes)

        // The bounds that the text will occupy.
        let renderRect = CGRect(
          centeredOn: segmentCenter, size: textRenderSize
        )

        // Draw text in the rect, with the given attributes.
        textToRender.draw(in: renderRect, withAttributes: textAttributes)
      }
    }
  }
}
