//
//  ViewController.swift
//  ROverlay
//
//  Created by apple on 2017/8/8.
//  Copyright © 2017年 ray. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let random = arc4random()%9
        switch random {
        case 0:
            ROverlay.showBlurOverlay(status: "加载中...", fontColor: UIColor.brown, iconColor: UIColor.brown)
        case 1:
            ROverlay.showOverlay()
        case 2:
            let options = [ROverlayOptions.ROverlayOptionOpaqueBackground,ROverlayOptions.ROverlayOptionOverlaySizeRoundedRect,ROverlayOptions.ROverlayOptionOverlayTypeActivityDefault]
            ROverlay.showOverlay(options: options)
        case 3:
            ROverlay.showSquareOverlay(fontColor: UIColor.cyan, iconColor: UIColor.cyan)
        case 4:
            ROverlay.showErrorOverlay(status: "网络错误")
        case 5:
            ROverlay.showWarningOverlay()
        case 6:
            ROverlay.showInfoOverlay(status: "查看详情")
        case 7:
            ROverlay.showTextOverlay(status: "获取数据失败，请检查您的网络")
        case 8:
            ROverlay.showSuccessOverlay()
        default:
            print("123")
        }
        if random != 7 {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.8) {
                ROverlay.hideOverlay()
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

