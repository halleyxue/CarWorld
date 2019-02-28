//
//  BaseViewController.swift
//  ChongqingTravel
//
//  Created by yangxue_pc on 2019/1/31.
//  Copyright © 2019年 yangxue_pc. All rights reserved.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
    }
}

extension UIViewController {
    func getAction(name: String)-> String {
        return name + HttpUtil.suffix;
    }
    
    func showDialog(title: String?, message: String?) {
        showSimpleAlert(view: self, title: title, message: message)
    }
    
    func showSimpleAlert(view: UIViewController, title: String?, message: String?) {
        let alert = UIAlertController(title: title ?? "提示", message: message, preferredStyle: .alert);
        alert.addAction(UIAlertAction(title: Util.getStringByName("confirm_button_title"), style: .default, handler: nil));
        view.present(alert, animated: true, completion: nil);
    }
}
