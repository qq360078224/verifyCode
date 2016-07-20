//
//  ViewController.swift
//  VerifyCode
//
//  Created by XQ on 16/7/20.
//  Copyright © 2016年 XQ. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var verifyStr = ""
    let verifyText:UITextField = UITextField()
    var verifyView:VerifyView = VerifyView.init(frame: CGRectMake(10, 200, 160, 60))
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.initUI()
    }
    func initUI() {
        // 验证码的View
        self.view.addSubview(verifyView)
        
        // 验证按钮
        let getBtn = UIButton.init(type: .System)
        getBtn.frame = CGRectMake(200, 200, 80, 30)
        getBtn.setTitle("验证", forState: .Normal)
        getBtn.backgroundColor = UIColor.greenColor()
        getBtn.addTarget(self, action: "btnClick:", forControlEvents: .TouchUpInside)
        self.view.addSubview(getBtn)
        // textfield
        verifyText.frame = CGRectMake(10, 280, 120, 40)
        verifyText.backgroundColor = UIColor.greenColor()
        verifyText.placeholder = "请输入验证码"
        self.view.addSubview(verifyText)
        
    }
    func btnClick(sender:UIButton) {
        verifyStr = verifyView.verifyStr!
        var tip = ""
        print("\(self.verifyText.text)======\(self.verifyStr.uppercaseString)")
        if self.verifyText.text?.uppercaseString == self.verifyStr.uppercaseString {
            tip = "正确"
        }else {
            tip = "错误"
        }
        let alert = UIAlertController(title: "提示", message: tip, preferredStyle: .Alert)
        let action = UIAlertAction(title: "确定", style: .Default, handler: nil)
        alert.addAction(action)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    // MARK: - 系统自带
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

