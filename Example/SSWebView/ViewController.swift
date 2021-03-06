//
//  ViewController.swift
//  SSWebView
//
//  Created by 高光辉 on 11/01/2021.
//  Copyright (c) 2021 高光辉. All rights reserved.
//

import UIKit
import SSWebView
//import WebViewVC

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        createWebView()
        createUVAlertView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createWebView() {
        let url = "https://stellarhelp.sansistellar.com/en/stellar_home/how_to_use_app/add_wifi_bulbs/"
        let vc = WebViewVC()
        vc.url = url
        navigationController?.pushViewController(vc, animated: true)
    }

    func createUVAlertView() {
        let alert = UVAlertView.UVAlertView("Are you sure you want to delete the link?", subTitle: "", rightBtnTitle: "Delete")
        alert.show()
    }
}

