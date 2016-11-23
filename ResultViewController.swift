//
//  ResultViewController.swift
//  SlideshowAppKadai
//
//  Created by Naomi Cross on 2016/11/15.
//  Copyright © 2016年 n.kanreky. All rights reserved.
//

import UIKit


class ResultViewController: UIViewController {
    
    
    @IBOutlet weak var fullscreen: UIImageView!
    @IBOutlet weak var back: UIButton!
    var img: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        if img != nil{
            fullscreen.image = img
        }
    }
    
}
    