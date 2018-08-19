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

  override func viewDidLoad() {
    super.viewDidLoad()

    pieChartView.frame = CGRect(
      x: 0, y: 40, width: view.frame.size.width, height: 400
    )

    pieChartView.segments = [
      Segment(color: #colorLiteral(red: 1.0, green: 0.121568627, blue: 0.28627451, alpha: 1.0), name: "Red",        value: 57.56),
      Segment(color: #colorLiteral(red: 1.0, green: 0.541176471, blue: 0.0, alpha: 1.0), name: "Orange",     value: 30),
      Segment(color: #colorLiteral(red: 0.478431373, green: 0.423529412, blue: 1.0, alpha: 1.0), name: "Purple",     value: 27),
      Segment(color: #colorLiteral(red: 0.0, green: 0.870588235, blue: 1.0, alpha: 1.0), name: "Light Blue", value: 40),
      Segment(color: #colorLiteral(red: 0.392156863, green: 0.945098039, blue: 0.717647059, alpha: 1.0), name: "Green",      value: 25),
      Segment(color: #colorLiteral(red: 0.0, green: 0.392156863, blue: 1.0, alpha: 1.0), name: "Blue",       value: 38)
    ]

    pieChartView.segmentLabelFont = .systemFont(ofSize: 18)
    pieChartView.showSegmentValueInLabel = true

    view.addSubview(pieChartView)

    // For simplified version (in SimplePieChartView.swift).
    /*
    pieChartView.frame = CGRect(
      x: 0, y: 0, width: view.frame.size.width, height: 400
    )
    pieChartView.segments = [
      Segment(color: .red,    value: 57),
      Segment(color: .blue,   value: 30),
      Segment(color: .green,  value: 25),
      Segment(color: .yellow, value: 40)
    ]
    view.addSubview(pieChartView)*/
  }
}

