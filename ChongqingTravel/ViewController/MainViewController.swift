//
//  MainViewController.swift
//  ChongqingTravel
//
//  Created by yangxue_pc on 2019/1/30.
//  Copyright © 2019年 yangxue_pc. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import HandyJSON
import SwiftyJSON

class MainViewController: BaseViewController, HttpHandler {
    
    public static let SEGUE = "main_segue"
    var location: String?
    private let HomePageHeaderViewID = "HomePageHeaderView"
    private let HomePageHeaderCellID = "HomePageHeaderCell"
    private let HOME_PAGE_ACTION = "homepage";
    
    // MARK - 数据模型
    var fmhomeRecommendModel:FMHomeRecommendModel?
    var homeRecommendList:[HomeRecommendModel]?
    var recommendList : [RecommendListModel]?
    var focus:FocusModel?
    var squareList: [SquareModel]?
    
    var tabBar: UITabBar!
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        let collection = UICollectionView.init(frame:.zero, collectionViewLayout: layout)
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = UIColor.white
        collection.register(HomePageHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: HomePageHeaderCellID)
        collection.register(HomeHeaderCell.self, forCellWithReuseIdentifier: HomePageHeaderCellID)
        return collection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "首页"
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { (make) in
            make.width.height.equalToSuperview()
            make.center.equalToSuperview()
        }
        self.view.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { (make) in
            make.width.height.equalToSuperview()
            make.center.equalToSuperview()
        }
        let delay = DispatchTime.now() + .milliseconds(100);
        DispatchQueue.main.asyncAfter(deadline: delay) {
          self.loadData()
        };
    }

    func loadData() {
        let reqeust = User()
        reqeust.username = "echo"
        updataBlock = { [unowned self] in
            self.collectionView.reloadData()
        }
        HttpUtil.send(url: getAction(name: HOME_PAGE_ACTION), object: reqeust, handler: self, block: true)
    }

    func onSuccess(json: String) {
        //Json字符串转化为data
        if let data = json.data(using: String.Encoding.utf8, allowLossyConversion: false) {
            let jsonStr = JSON(data)
            if let mappedObject = JSONDeserializer<FMHomeRecommendModel>.deserializeFrom(json: json.description) { // 从字符串转换为对象实例
                self.fmhomeRecommendModel = mappedObject
                self.homeRecommendList = mappedObject.list
                if let recommendList = JSONDeserializer<RecommendListModel>.deserializeModelArrayFrom(json: jsonStr["list"].description) {
                    self.recommendList = recommendList as? [RecommendListModel]
                }
                if let focus = JSONDeserializer<FocusModel>.deserializeFrom(json: jsonStr["list"][0]["list"].description) {
                    self.focus = focus
                }
                if let square = JSONDeserializer<SquareModel>.deserializeModelArrayFrom(json: jsonStr["list"][1]["list"]["data"].description) {
                    self.squareList = square as? [SquareModel]
                }
            }
            self.updataBlock?()
        }
        
    }
    
    func onFail(error: String, code: Int) {
        showDialog(title: nil, message: Util.getStringByName("get_homepage_error"))
    }
    
}

extension MainViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return (self.homeRecommendList?.count) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let moduleType = self.homeRecommendList?[indexPath.section].moduleType
        let cell:HomeHeaderCell = collectionView.dequeueReusableCell(withReuseIdentifier: HomePageHeaderCellID, for: indexPath) as! HomeHeaderCell
        cell.focusModel = self.focus
        cell.squareList = self.squareList
        cell.delegate = self
        return cell
    }
    
    //每个分区的内边距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 0, 0, 0)
    }
    
    //最小 item 间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    //最小行间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    //item 的尺寸
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let moduleType = self.homeRecommendList?[indexPath.section].moduleType
        if moduleType == "focus" {
            return CGSize.init(width:YYScreenWidth,height:360)
        }else {
            return .zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let moduleType = self.homeRecommendList?[section].moduleType
        if moduleType == "focus" || moduleType == "square" || moduleType == "topBuzz" || moduleType == "ad" || section == 18 {
            return CGSize.zero
        }else {
            return CGSize.init(width: YYScreenHeigth, height:40)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        let moduleType = self.homeRecommendList?[section].moduleType
        if moduleType == "focus" || moduleType == "square" {
            return CGSize.zero
        }else {
            return CGSize.init(width: YYScreenWidth, height: 10.0)
        }
    }
}

extension MainViewController: HomeHeaderCellDelegate {
    
    func homeHeaderBannerClick() {
        print("哎呀呀!咋没反应呢???")
    }
    
    func homeHeaderBtnClick(keyWord: String, title: String) {
        if keyWord != "" {
            let vc = SubMenuController(keyWord: keyWord)
            vc.title = title
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

}

