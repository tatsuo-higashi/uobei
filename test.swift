//
//  test.swift
//  uobei
//
//  Created by 東竜生 on 2020/01/30.
//  Copyright © 2020年 東竜生. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation//オーディオがらみ
import AVKit

class test: UISplitViewController, UISplitViewControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let aaa = MasterViewController()
        let bbb = splitViewController2()
        
        let master = UINavigationController(rootViewController: aaa)
        let detail = UINavigationController(rootViewController: bbb)
        
        self.viewControllers = [master, detail]
        //画面を分割する
        self.preferredDisplayMode = .allVisible
    }
}
