//
//  ViewController.swift
//  Pie Chart View
//
//  Created by Hamish Knight on 04/03/2016.
//  Copyright © 2016 Redonkulous Apps. All rights reserved.
//

import UIKit

class ViewController : UIViewController {

  let pieChartView = PieChartView()
  let simplePieChartView = SimplePieChartView()

  override func viewDidLoad() {
    super.viewDidLoad()

    let padding: CGFloat = 20
    let height = (view.frame.height - padding * 3) / 2

    pieChartView.frame = CGRect(
      x: 0, y: padding, width: view.frame.size.width, height: height
    )

    pieChartView.segments = [
      LabelledSegment(color: #colorLiteral(red: 1.0, green: 0.121568627, blue: 0.28627451, alpha: 1.0), name: "Red",        value: 57.56),
      LabelledSegment(color: #colorLiteral(red: 1.0, green: 0.541176471, blue: 0.0, alpha: 1.0), name: "Orange",     value: 30),
      LabelledSegment(color: #colorLiteral(red: 0.478431373, green: 0.423529412, blue: 1.0, alpha: 1.0), name: "Purple",     value: 27),
      LabelledSegment(color: #colorLiteral(red: 0.0, green: 0.870588235, blue: 1.0, alpha: 1.0), name: "Light Blue", value: 40),
      LabelledSegment(color: #colorLiteral(red: 0.392156863, green: 0.945098039, blue: 0.717647059, alpha: 1.0), name: "Green",      value: 25),
      LabelledSegment(color: #colorLiteral(red: 0.0, green: 0.392156863, blue: 1.0, alpha: 1.0), name: "Blue",       value: 38)
    ]

    pieChartView.segmentLabelFont = .systemFont(ofSize: 10)
    pieChartView.showSegmentValueInLabel = true

    view.addSubview(pieChartView)

    simplePieChartView.frame = CGRect(
      x: 0, y: height + padding * 2,
      width: view.frame.size.width, height: height
    )

    simplePieChartView.segments = [
      Segment(color: .red,    value: 57),
      Segment(color: .blue,   value: 30),
      Segment(color: .green,  value: 25),
      Segment(color: .yellow, value: 40)
    ]
    view.addSubview(simplePieChartView)
  }
}

