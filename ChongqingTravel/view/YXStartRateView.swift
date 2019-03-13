//
//  YXStartRateView.swift
//  ChongqingTravel
//
//  Created by yangxue_pc on 2019/3/8.
//  Copyright © 2019年 yangxue_pc. All rights reserved.
//

import UIKit

public typealias CountCompleteBackBlock = (_ currentCount:Float)->(Void)

public class YXStarRateView: UIView {
    
    public var numberOfStar:UInt = 5
    
    public var selectNumberOfStar:Float = 0{
        didSet{
            //不重复刷新
            if oldValue == selectNumberOfStar {
                return
            }
            //越界处理
            if selectNumberOfStar < 0 {
                selectNumberOfStar = 0
            }else if selectNumberOfStar > Float(numberOfStar){
                selectNumberOfStar = Float(numberOfStar)
            }
            
            if let currentStarBack = callback {
                currentStarBack(selectNumberOfStar)
            }
            layoutSubviews()
        }
    }
    public var isAnimation:Bool = true
    
    //回调函数
    public var callback: CountCompleteBackBlock?
    fileprivate var backgroundView:UIView!
    fileprivate var foreView:UIView!
    //星星的宽度
    fileprivate var starWidth:CGFloat!
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public convenience init(frame: CGRect,starCount:UInt?,currentStar:Float?,isAnimation:Bool? = true,complete:@escaping CountCompleteBackBlock) {
        self.init(frame: frame)
        callback = complete
        numberOfStar = starCount ?? 5
        selectNumberOfStar = currentStar ?? 0
        self.isAnimation = isAnimation!
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        setupUI()
        let animationTimeInterval = isAnimation ? 0.2 : 0
        UIView.animate(withDuration: animationTimeInterval) {
            self.foreView.frame = CGRect(x: 0, y: 0, width: self.starWidth * CGFloat(self.selectNumberOfStar), height: self.bounds.size.height)
        }
    }
}

extension YXStarRateView {
    public func update() {
        setupUI()
    }
    
    fileprivate func setupUI(){
        clearAll()
        //星星宽度
        starWidth =  self.bounds.size.width/CGFloat(numberOfStar)
        //背景view
        self.backgroundView = self.creatStarView(image: #imageLiteral(resourceName: "star_bg"))
        //选择view
        self.foreView = self.creatStarView(image: #imageLiteral(resourceName: "star_fore"))
        
        self.foreView.frame = CGRect(x: 0, y: 0, width: starWidth * CGFloat(selectNumberOfStar), height: self.bounds.size.height)
        self.addSubview(self.backgroundView)
        self.addSubview(self.foreView)
    }
    
    //创建StarView
    fileprivate func creatStarView(image:UIImage) -> UIView {
        
        let view =  UIView(frame:self.bounds)
        view.clipsToBounds = true
        view.backgroundColor = UIColor.clear
        
        for i in 0...numberOfStar {
            let imageView = UIImageView(image: image)
            imageView.frame = CGRect(x:CGFloat(i) * starWidth, y: 0, width: starWidth, height: self.bounds.size.height)
            imageView.contentMode = .scaleAspectFit
            view.addSubview(imageView)
        }
        
        return view
    }
    
    //清除所有视图和手势
    func clearAll(){
        
        for view in self.subviews{
            view.removeFromSuperview()
        }
        
        if let taps = self.gestureRecognizers {
            for tap in taps{
                self.removeGestureRecognizer(tap)
            }
        }
        
    }
}

extension YXStarRateView{
    
    @objc func tapStar(sender:UITapGestureRecognizer){
        let  tapPoint = sender.location(in: self)
        let  offset   = tapPoint.x
        let  selctCount = offset/starWidth
        selectNumberOfStar = Float(selctCount)
        
    }
}
