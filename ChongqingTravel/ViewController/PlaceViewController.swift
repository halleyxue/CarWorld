//
//  PagerViewController.swift
//  ChongqingTravel
//
//  Created by yangxue_pc on 2019/3/7.
//  Copyright © 2019年 yangxue_pc. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON

class PlaceViewController: BaseViewController {
    
    private var placeType: String = ""
    
    convenience init(placeType: String = "") {
        self.init()
        self.placeType = placeType
    }
    
    private let LOAN_HOT_PLACE_ACTION = "loadPlaces"
    private let PlaceCellID = "PlaceCell"
    private let GET_GOTPLACE_LIST = "getList"
    private var placeResults: [PlaceModel]?
    var keyType: String?
    
    public lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width:YYScreenWidth, height: YYScreenHeigth), style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PlaceCell.self, forCellReuseIdentifier: PlaceCellID)
        tableView.backgroundColor = UIColor.init(red: 240, green: 241, blue: 244, alpha: 1)
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(tableView)
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        if (self.placeType == "热门景点") {
            self.keyType = "hot"
        } else if (self.placeType == "全部") {
            self.keyType = "all"
        }else {
            self.keyType = "near"
        }
        getPlaceData(action_name: self.LOAN_HOT_PLACE_ACTION, module: self.keyType!)
    }
    
    func getPlaceData(action_name: String, module: String) {
        updataBlock = { [unowned self] in
            self.tableView.reloadData()
        }
        let request = CommonRequest()
        request.reqMethod = GET_GOTPLACE_LIST
        request.reserved = nil
        request.module = module
        HttpUtil.send(url: getAction(name: action_name), object: request, handler: LocalHandler(view: self), block: true)
    }
    
    class LocalHandler: HttpHandler{
        var view: PlaceViewController?
        
        init(view: PlaceViewController) {
            self.view = view;
        }
        
        func onSuccess(json: String) {
            if let data = json.data(using: String.Encoding.utf8, allowLossyConversion: false) {
                let jsonStr = JSON(data)
                print(jsonStr)
                if let mappedObject = JSONDeserializer<PlaceModel>.deserializeModelArrayFrom(json: jsonStr["data"]["placeGroups"].description){
                    self.view?.placeResults = mappedObject as? [PlaceModel]
                    self.view?.updataBlock?()
                }
            }
        }
        
        func onFail(error: String, code: Int) {
            print("load fail")
        }
    }
}

extension PlaceViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.placeResults?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PlaceCell = tableView.dequeueReusableCell(withIdentifier: PlaceCellID, for: indexPath) as! PlaceCell
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        cell.placeResults = self.placeResults?[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let placeId = self.placeResults?[indexPath.row].placeId ?? 0
    }
}
