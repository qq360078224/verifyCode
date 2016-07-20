//
//  VerifyView.swift
//  VerifyCode
//
//  Created by XQ on 16/7/20.
//  Copyright © 2016年 XQ. All rights reserved.
//

import UIKit

class VerifyView: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    //  根据输入的数组获取 0-x 的随机数
    func ranNum(num:Int)->Int {
        let ranNum = arc4random()%UInt32(num)
        return Int(ranNum)
    }
    // 获得随机的颜色
    func randomColor()->UIColor {        
        let ranColor = UIColor(red: CGFloat(ranNum(256))/256.0, green: CGFloat(ranNum(256))/256.0, blue: CGFloat(ranNum(256))/256.0, alpha: 1)
        return ranColor
    }
    // 字符数组
    let charsArr = ["0","1","2","3","4","5","6","7","8","9","A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z","a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"]
    // 验证码的尾数
    let charCount = 4
    // 随机产生的字符串
    var verifyStr:String?
    // MARK: - 重写init方法
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 10.0
        self.layer.masksToBounds = true
        self.backgroundColor = randomColor()
        self.changeVerifyCode()
    }
    func changeVerifyCode() {
        verifyStr = ""
        for _ in 0..<charCount {
            let index = ranNum(charsArr.count)
            verifyStr?.appendContentsOf(charsArr[index])
        }        
        
    }
    // MARK: - 重写点击方法重新获取
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.changeVerifyCode()
        self.setNeedsDisplay()
    }
    // MARK: - 重写drawRect,初始化和setNeedsDisplay时候回调用
    override func drawRect(rect: CGRect) {
        // 随机颜色
        self.backgroundColor = randomColor()
        // 获取每个字符需要的宽度
        let width:Int = Int(self.frame.size.width) / self.charCount
        let height = Int(self.frame.size.height)
        // 绘制每一个字
        for (index,text) in  self.verifyStr!.characters.enumerate(){
            // 随机x位置
            let pX = CGFloat(index * width + self.ranNum(width) / 2)
            // 随机y位置
            let pY = CGFloat(self.ranNum(height)/2)
            // 获取每一个字符
            let textStr = String.init(text)
            // 随机字体大小
            let fontSize = CGFloat(self.ranNum(10) + 15)
            let font = UIFont.systemFontOfSize(fontSize)
            // 绘制
            textStr.drawAtPoint(CGPointMake(pX, pY), withAttributes:[NSFontAttributeName:font])
        }
        
        // 绘制干扰线
        // 获取drawRect的上下文
        let context = UIGraphicsGetCurrentContext()
        // 画线宽度
        CGContextSetLineWidth(context, 1.0)
        for _ in 0..<5 {
            // 随机颜色
            CGContextSetStrokeColorWithColor(context, self.randomColor().CGColor)
            var pX:CGFloat = 0.0
            var pY:CGFloat = 0.0
            // 起点
            pX = CGFloat(self.ranNum(Int(rect.size.width)))
            pY = CGFloat(self.ranNum(Int(rect.size.height)))
            CGContextMoveToPoint(context, pX, pY)
            // 终点
            pX = CGFloat(self.ranNum(Int(rect.size.width)))
            pY = CGFloat(self.ranNum(Int(rect.size.height)))
            CGContextAddLineToPoint(context, pX, pY)
            // 画线
            CGContextStrokePath(context)            
        }
        
    }
    // MARK: - 系统自带
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
