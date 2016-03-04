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
        pieChartView.values = [
            (UIColor(red: 1.0, green: 31.0/255.0, blue: 73.0/255.0, alpha: 1.0), 57),
            (UIColor(red:1.0, green: 138.0/255.0, blue: 0.0, alpha:1.0), 30),
            (UIColor(red: 122.0/255.0, green: 108.0/255.0, blue: 1.0, alpha: 1.0), 25),
            (UIColor(red: 0.0, green: 100.0/255.0, blue: 1.0, alpha: 1.0), 40),
            (UIColor(red: 100.0/255.0, green: 241.0/255.0, blue: 183.0/255.0, alpha: 1.0), 38),
            (UIColor(red: 0.0, green: 222.0/255.0, blue: 1.0, alpha: 1.0), 10)
        ]
        
        pieChartView.values = [
            (UIColor.redColor(), 57),
            (UIColor.blueColor(), 30),
            (UIColor.greenColor(), 25),
            (UIColor.yellowColor(), 40)
        ]
        view.addSubview(pieChartView)
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

