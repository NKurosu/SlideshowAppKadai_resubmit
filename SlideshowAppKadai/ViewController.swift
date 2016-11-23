//
//  ViewController.swift
//  SlideshowAppKadai
//
//  Created by Naomi Cross on 2016/11/12.
//  Copyright © 2016年 n.kanreky. All rights reserved.
//

 import UIKit

    //Tapを認識させるために、UIGestureRecongnizerDelegateを追加する
    class ViewController: UIViewController,
        UIGestureRecognizerDelegate {
        
        
        @IBOutlet weak var previousButton: UIButton!
        @IBOutlet weak var startButton: UIButton!
        @IBOutlet weak var nextButton: UIButton!
        @IBOutlet weak var slideImg: UIImageView!
        @IBOutlet weak var topLavel: UILabel!
        
        
        let images = [
            "Stonehenge1.jpg", "Stonehenge2.jpg", "Stonehenge3.jpg", "Stonehenge4.jpg"
        ]
        
        var imageCount :Int = 0
        var timer :NSTimer?
        
        override func viewDidLoad() {
            print( images[ imageCount ])
            super.viewDidLoad()
            
            slideImg.contentMode = .ScaleAspectFit
            setImages( imageCount )
            // viewがローディングされてから、追加設定を行う　ー　通常はnibから
            
            //1度しか呼ばれないジェスチャー（single tap)を設定
            let tapGesture:UIGestureRecognizer = UITapGestureRecognizer(
                target: self,
                action: #selector(ViewController.tapped(_:)))
            
            //ジェスチャーのDelegate を設定
            tapGesture.delegate = self;
            
            //Viewにジェスチャーのインスタンスを追加
            self.view.addGestureRecognizer(tapGesture)
        }
        
        //タップイベント　Tapされた時に、メソッドが呼び出される
        func tapped( _sender: UITapGestureRecognizer){
            print(_sender)
            
            //ShowDetailViewControllerへ遷移するためにSegueを呼び出す
            performSegueWithIdentifier("result", sender: nil)
        }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        
        @IBAction func nextButton(sender: AnyObject) {
            imageCount += 1
            
            if(imageCount >= images.count){
                imageCount = 0
                setImages(imageCount)
            }
            
            setImages(imageCount)

        }
        
        
        @IBAction func ReturnButton(sender: AnyObject) {
        imageCount += -1
            
            if (imageCount <= -1){
                imageCount = 3
                setImages(imageCount)
            }
            
            setImages(imageCount)
        }
      
        
        @IBAction func startButton(sender: AnyObject) {
            if timer == nil{
                
                timer = NSTimer.scheduledTimerWithTimeInterval(
                    3.0,
                    target: self,
                    selector: #selector(self.nextButton(_:)),
                    userInfo: nil,
                    repeats: true
                )
                
                //ボタンをfalseに初期設定をする
                previousButton.enabled = false;
                nextButton.enabled = false;
                //startをstopに変える
                startButton.setTitle("Stop", forState: UIControlState())
                topLavel.text = "Slideshow"
                
            }else{
                timer!.invalidate()
                timer = nil
                //ボタンをtrueに設定する
                previousButton.enabled = true;
                nextButton.enabled = true;
                //make Stop to Start
                startButton.setTitle("Start", forState: UIControlState())
                topLavel.text = "PhotoView"
            }

        }
       

        
        func setImages(imageCount:Int){
            slideImg.image = UIImage(named: images[imageCount])
        }
        
        //画面遷移でSlideshowに戻ってくるためのボタン
        @IBAction func unwind(segue: UIStoryboardSegue){
            
        }
        //ローテーションを許可しない
        override func shouldAutorotate() -> Bool {
            return false
        }
        
        //画面遷移
        override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
            if(segue.identifier == "result"){
                if(timer != nil){
                    timer!.invalidate()
                }
                let detailShow: ResultViewController = (segue.destinationViewController as? ResultViewController)!
                detailShow.img = slideImg.image
                
            }
        }
}
