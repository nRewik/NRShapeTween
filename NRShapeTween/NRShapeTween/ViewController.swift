//
//  ViewController.swift
//  NRShapeTween
//
//  Created by DW78 on 7/24/2558 BE.
//  Copyright (c) 2558 Nutchaphon Rewik. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var shapeTweenView: NRShapeTweenView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func sliderValueChanged(sender: UISlider) {
        shapeTweenView.side = sender.value
    }
    @IBAction func buttonClick() {
//        shapeTweenView.setSide(6.0)
        shapeTweenView.animateToSide(6.0, duration: 3.0)
    }

}

