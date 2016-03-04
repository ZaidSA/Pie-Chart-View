//
//  ViewController.swift
//  Pie Chart View
//
//  Created by Hamish Knight on 04/03/2016.
//  Copyright © 2016 Redonkulous Apps. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let pieChartView = PieChartView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pieChartView.frame = CGRect(x: 0, y: 40, width: UIScreen.mainScreen().bounds.size.width, height: 400)
        pieChartView.values = [(UIColor.redColor(), 57), (UIColor.blueColor(), 30), (UIColor.greenColor(), 25), (UIColor.yellowColor(), 40)]
        view.addSubview(pieChartView)
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

