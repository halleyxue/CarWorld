//
//  PlaceDetailCell.swift
//  ChongqingTravel
//
//  Created by yangxue_pc on 2019/3/12.
//  Copyright © 2019年 yangxue_pc. All rights reserved.
//

import UIKit
import FSPagerView

class PlaceDetailCell: UITableViewCell {
    private lazy var pagerView : FSPagerView = {
        let pagerView = FSPagerView()
        pagerView.delegate = self
        pagerView.dataSource = self
        pagerView.automaticSlidingInterval =  3
        pagerView.isInfinite = true
        pagerView.itemSize = CGSize(width: YYScreenWidth, height: 140)
        pagerView.interitemSpacing = 0
        pagerView.transformer = FSPagerViewTransformer(type: .crossFading)
        pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        return pagerView
    }()
    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setUpUI()
//    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setUpUI() {
        
    }
}

extension PlaceDetailCell: FSPagerViewDelegate, FSPagerViewDataSource {
    // MARK:- FSPagerView Delegate
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return 0
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
//        cell.imageView?.kf.setImage(with: URL(string:(self.focus?.data?[index].cover)!))
        return cell
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        
    }
}

