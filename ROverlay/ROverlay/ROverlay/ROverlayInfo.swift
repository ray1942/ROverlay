//
//  ROverlay.swift
//  Widgets
//
//  Created by ray on 2017/8/3.
//  Copyright © 2017年 ray. All rights reserved.
//

import UIKit

//MARK: 改变图片颜色
extension UIImage{
    /// 更改图片颜色
    public func maskImageWithColor(color : UIColor) -> UIImage{
        UIGraphicsBeginImageContext(self.size)
        color.setFill()
        let bounds = CGRect.init(x: 0, y: 0, width: self.size.width, height: self.size.height)
        UIRectFill(bounds)
        self.draw(in: bounds, blendMode: CGBlendMode.destinationIn, alpha: 1.0)
        let tintedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return tintedImage!
    }
}


//MARK: 文字 字体
let OVERLAY_LABEL_FONT = UIFont.init(name: "ArialUnicodeMS", size: 12)

//MARK：文字 颜色
var OVERLAY_LABEL_FONT_COLOR = UIColor.lightGray

//MARK: 菊花默认颜色
var OVERLAY_ACTIVITY_DEFAULT_COLOR = UIColor.lightGray
    //UIColor.init(red: 102.0/255.0, green:204.0/255.0, blue:255.0/255.0, alpha: 1.0)

//MARK: 叶子颜色
var OVERLAY_ACTIVITY_LEAF_COLOR = UIColor.lightGray
    //UIColor.init(red:102.0/255.0, green:204.0/255.0, blue:255.0/255.0, alpha:1.0)

//MARK:模糊⭕️颜色
var OVERLAY_ACTIVITY_BLUR_COLOR = UIColor.lightGray
    //UIColor.init(red: 102.0/255.0, green:204.0/255.0, blue:255.0/255.0, alpha:1.0)

//MARK：方块颜色
var OVERLAY_ACTIVITY_SQUARE_COLOR = UIColor.lightGray
    //UIColor.init(red:102.0/255.0, green:204.0/255.0, blue:255.0/255.0, alpha:1.0)

//MARK: 阴影颜色
let OVERLAY_SHADOW_COLOR = UIColor.init(white: 0, alpha: 0.8)

//MARK: 背景色
let OVERLAY_BACKGROUND_COLOR = UIColor.init(white: 1.0, alpha: 1.0)

//MARK：模糊⭕️默认色
let OVERLAY_BLUR_TINT_COLOR = UIColor.init(white: 1.0, alpha: 5.0)

//MARK: 成功图标颜色
let OVERLAY_SUCCESS_COLOR = UIColor.init(red:0.0/255.0, green:255.0/255.0, blue:128.0/255.0, alpha:1.0)

//MARK: 警告图标颜色
let OVERLAY_WARNING_COLOR = UIColor.init(red:255.0/255.0, green:184.0/255.0, blue:0.0/255.0, alpha:1.0)

//MARK: 错误图标颜色
let OVERLAY_ERROR_COLOR = UIColor.init(red:255.0/255.0, green:102.0/255.0, blue:102.0/255.0, alpha:1.0)

//MARK: 提示信息图标颜色
let OVERLAY_INFO_COLOR = UIColor.init(red: 102.0/255.0, green:204.0/255.0, blue:255.0/255.0, alpha:1.0)

//MARK: 进度图标颜色
let OVERLAY_PROGRESS_COLOR = UIColor.init(red: 102.0/255.0, green:204.0/255.0, blue:255.0/255.0, alpha:1.0)

//MARK：图标浓度
let OVERLAY_ICON_THICKNESS:CGFloat = 3

//MARK: 动画时间
let ANIMATION_DURATION = 0.2

//MARK: 拉伸大小
let SCALE_TO:CGFloat = 1.2

//MARK: 默认拉伸程度
let SCALE_UNITY:CGFloat = 1.0

//MARK: x轴默认值
let LABEL_PADDING_X:CGFloat = 12.0

//MARK：y轴默认值
let LABEL_PADDING_Y:CGFloat = 66.0

//MARK: 检查是否推出
func optionPresent(options: [ROverlayOptions], value: ROverlayOptions...)->Bool{
    for option in options {
        for val in value {
            if option == val {
                return true
            }
        }
    }
    return false
}

//MARK: 获取偏移后的点
func pointWith(originPoint: CGPoint,offsetPoint: CGPoint)->CGPoint{
    return CGPoint.init(x: originPoint.x+offsetPoint.x, y: originPoint.y+offsetPoint.y)
}

//MARK: 叶子图标数组
let OVERLAY_ACTIVITY_LEAF_ARRAY = [
    UIImage.init(named: "ROverlay.bundle/Contents/Resources/ACTIVITY_leaf/1.png")?.maskImageWithColor(color: OVERLAY_ACTIVITY_LEAF_COLOR),
    UIImage.init(named: "ROverlay.bundle/Contents/Resources/ACTIVITY_leaf/2")?.maskImageWithColor(color: OVERLAY_ACTIVITY_LEAF_COLOR),
    UIImage.init(named: "ROverlay.bundle/Contents/Resources/ACTIVITY_leaf/3")?.maskImageWithColor(color: OVERLAY_ACTIVITY_LEAF_COLOR),
    UIImage.init(named: "ROverlay.bundle/Contents/Resources/ACTIVITY_leaf/4")?.maskImageWithColor(color: OVERLAY_ACTIVITY_LEAF_COLOR),
    UIImage.init(named: "ROverlay.bundle/Contents/Resources/ACTIVITY_leaf/5")?.maskImageWithColor(color: OVERLAY_ACTIVITY_LEAF_COLOR),
    UIImage.init(named: "ROverlay.bundle/Contents/Resources/ACTIVITY_leaf/6")?.maskImageWithColor(color: OVERLAY_ACTIVITY_LEAF_COLOR),
    UIImage.init(named: "ROverlay.bundle/Contents/Resources/ACTIVITY_leaf/7")?.maskImageWithColor(color: OVERLAY_ACTIVITY_LEAF_COLOR),
    UIImage.init(named: "ROverlay.bundle/Contents/Resources/ACTIVITY_leaf/8")?.maskImageWithColor(color: OVERLAY_ACTIVITY_LEAF_COLOR),
    UIImage.init(named: "ROverlay.bundle/Contents/Resources/ACTIVITY_leaf/9")?.maskImageWithColor(color: OVERLAY_ACTIVITY_LEAF_COLOR),
    UIImage.init(named: "ROverlay.bundle/Contents/Resources/ACTIVITY_leaf/10")?.maskImageWithColor(color: OVERLAY_ACTIVITY_LEAF_COLOR),
    UIImage.init(named: "ROverlay.bundle/Contents/Resources/ACTIVITY_leaf/11")?.maskImageWithColor(color: OVERLAY_ACTIVITY_LEAF_COLOR),
    UIImage.init(named: "ROverlay.bundle/Contents/Resources/ACTIVITY_leaf/12")?.maskImageWithColor(color: OVERLAY_ACTIVITY_LEAF_COLOR),
    UIImage.init(named: "ROverlay.bundle/Contents/Resources/ACTIVITY_leaf/13")?.maskImageWithColor(color: OVERLAY_ACTIVITY_LEAF_COLOR),
    UIImage.init(named: "ROverlay.bundle/Contents/Resources/ACTIVITY_leaf/14")?.maskImageWithColor(color: OVERLAY_ACTIVITY_LEAF_COLOR),
    UIImage.init(named: "ROverlay.bundle/Contents/Resources/ACTIVITY_leaf/15")?.maskImageWithColor(color: OVERLAY_ACTIVITY_LEAF_COLOR),
    UIImage.init(named: "ROverlay.bundle/Contents/Resources/ACTIVITY_leaf/16")?.maskImageWithColor(color: OVERLAY_ACTIVITY_LEAF_COLOR),
    UIImage.init(named: "ROverlay.bundle/Contents/Resources/ACTIVITY_leaf/17")?.maskImageWithColor(color: OVERLAY_ACTIVITY_LEAF_COLOR),
    UIImage.init(named: "ROverlay.bundle/Contents/Resources/ACTIVITY_leaf/18")?.maskImageWithColor(color: OVERLAY_ACTIVITY_LEAF_COLOR)
]


//MARK: 模糊⭕️图标数组
let OVERLAY_ACTIVITY_BLUR_ARRAY = [
    UIImage.init(named: "ROverlay.bundle/Contents/Resources/ACTIVITY_blur/1")?.maskImageWithColor(color: OVERLAY_ACTIVITY_BLUR_COLOR),
    UIImage.init(named: "ROverlay.bundle/Contents/Resources/ACTIVITY_blur/2")?.maskImageWithColor(color: OVERLAY_ACTIVITY_BLUR_COLOR),
    UIImage.init(named: "ROverlay.bundle/Contents/Resources/ACTIVITY_blur/3")?.maskImageWithColor(color: OVERLAY_ACTIVITY_BLUR_COLOR),
    UIImage.init(named: "ROverlay.bundle/Contents/Resources/ACTIVITY_blur/4")?.maskImageWithColor(color: OVERLAY_ACTIVITY_BLUR_COLOR),
    UIImage.init(named: "ROverlay.bundle/Contents/Resources/ACTIVITY_blur/5")?.maskImageWithColor(color: OVERLAY_ACTIVITY_BLUR_COLOR),
    UIImage.init(named: "ROverlay.bundle/Contents/Resources/ACTIVITY_blur/6")?.maskImageWithColor(color: OVERLAY_ACTIVITY_BLUR_COLOR),
    UIImage.init(named: "ROverlay.bundle/Contents/Resources/ACTIVITY_blur/7")?.maskImageWithColor(color: OVERLAY_ACTIVITY_BLUR_COLOR),
    UIImage.init(named: "ROverlay.bundle/Contents/Resources/ACTIVITY_blur/8")?.maskImageWithColor(color: OVERLAY_ACTIVITY_BLUR_COLOR),
    UIImage.init(named: "ROverlay.bundle/Contents/Resources/ACTIVITY_blur/9")?.maskImageWithColor(color: OVERLAY_ACTIVITY_BLUR_COLOR),
    UIImage.init(named: "ROverlay.bundle/Contents/Resources/ACTIVITY_blur/10")?.maskImageWithColor(color: OVERLAY_ACTIVITY_BLUR_COLOR),
    UIImage.init(named: "ROverlay.bundle/Contents/Resources/ACTIVITY_blur/11")?.maskImageWithColor(color: OVERLAY_ACTIVITY_BLUR_COLOR),
    UIImage.init(named: "ROverlay.bundle/Contents/Resources/ACTIVITY_blur/12")?.maskImageWithColor(color: OVERLAY_ACTIVITY_BLUR_COLOR),
    UIImage.init(named: "ROverlay.bundle/Contents/Resources/ACTIVITY_blur/13")?.maskImageWithColor(color: OVERLAY_ACTIVITY_BLUR_COLOR),
    UIImage.init(named: "ROverlay.bundle/Contents/Resources/ACTIVITY_blur/14")?.maskImageWithColor(color: OVERLAY_ACTIVITY_BLUR_COLOR),
    UIImage.init(named: "ROverlay.bundle/Contents/Resources/ACTIVITY_blur/15")?.maskImageWithColor(color: OVERLAY_ACTIVITY_BLUR_COLOR),
    UIImage.init(named: "ROverlay.bundle/Contents/Resources/ACTIVITY_blur/16")?.maskImageWithColor(color: OVERLAY_ACTIVITY_BLUR_COLOR),
    UIImage.init(named: "ROverlay.bundle/Contents/Resources/ACTIVITY_blur/17")?.maskImageWithColor(color: OVERLAY_ACTIVITY_BLUR_COLOR),
    UIImage.init(named: "ROverlay.bundle/Contents/Resources/ACTIVITY_blur/18")?.maskImageWithColor(color: OVERLAY_ACTIVITY_BLUR_COLOR)
]

//MARK: 方块图标数组
let OVERLAY_ACTIVITY_SQUARE_ARRAY = [
    UIImage.init(named: "ROverlay.bundle/Contents/Resources/ACTIVITY_square/1")?.maskImageWithColor(color: OVERLAY_ACTIVITY_SQUARE_COLOR),
    UIImage.init(named: "ROverlay.bundle/Contents/Resources/ACTIVITY_square/2")?.maskImageWithColor(color: OVERLAY_ACTIVITY_SQUARE_COLOR),
    UIImage.init(named: "ROverlay.bundle/Contents/Resources/ACTIVITY_square/3")?.maskImageWithColor(color: OVERLAY_ACTIVITY_SQUARE_COLOR),
    UIImage.init(named: "ROverlay.bundle/Contents/Resources/ACTIVITY_square/4")?.maskImageWithColor(color: OVERLAY_ACTIVITY_SQUARE_COLOR),
    UIImage.init(named: "ROverlay.bundle/Contents/Resources/ACTIVITY_square/5")?.maskImageWithColor(color: OVERLAY_ACTIVITY_SQUARE_COLOR),
    UIImage.init(named: "ROverlay.bundle/Contents/Resources/ACTIVITY_square/6")?.maskImageWithColor(color: OVERLAY_ACTIVITY_SQUARE_COLOR),
    UIImage.init(named: "ROverlay.bundle/Contents/Resources/ACTIVITY_square/7")?.maskImageWithColor(color: OVERLAY_ACTIVITY_SQUARE_COLOR),
    UIImage.init(named: "ROverlay.bundle/Contents/Resources/ACTIVITY_square/8")?.maskImageWithColor(color: OVERLAY_ACTIVITY_SQUARE_COLOR),
    UIImage.init(named: "ROverlay.bundle/Contents/Resources/ACTIVITY_square/9")?.maskImageWithColor(color: OVERLAY_ACTIVITY_SQUARE_COLOR),
    UIImage.init(named: "ROverlay.bundle/Contents/Resources/ACTIVITY_square/10")?.maskImageWithColor(color: OVERLAY_ACTIVITY_SQUARE_COLOR),
    UIImage.init(named: "ROverlay.bundle/Contents/Resources/ACTIVITY_square/11")?.maskImageWithColor(color: OVERLAY_ACTIVITY_SQUARE_COLOR),
    UIImage.init(named: "ROverlay.bundle/Contents/Resources/ACTIVITY_square/12")?.maskImageWithColor(color: OVERLAY_ACTIVITY_SQUARE_COLOR),
    UIImage.init(named: "ROverlay.bundle/Contents/Resources/ACTIVITY_square/13")?.maskImageWithColor(color: OVERLAY_ACTIVITY_SQUARE_COLOR),
    UIImage.init(named: "ROverlay.bundle/Contents/Resources/ACTIVITY_square/14")?.maskImageWithColor(color: OVERLAY_ACTIVITY_SQUARE_COLOR),
    UIImage.init(named: "ROverlay.bundle/Contents/Resources/ACTIVITY_square/15")?.maskImageWithColor(color: OVERLAY_ACTIVITY_SQUARE_COLOR),
    UIImage.init(named: "ROverlay.bundle/Contents/Resources/ACTIVITY_square/16")?.maskImageWithColor(color: OVERLAY_ACTIVITY_SQUARE_COLOR),
    UIImage.init(named: "ROverlay.bundle/Contents/Resources/ACTIVITY_square/17")?.maskImageWithColor(color: OVERLAY_ACTIVITY_SQUARE_COLOR),
    UIImage.init(named: "ROverlay.bundle/Contents/Resources/ACTIVITY_square/18")?.maskImageWithColor(color: OVERLAY_ACTIVITY_SQUARE_COLOR)
]

//MARK: Overlay所用通知
let ROverlayWillDisappearNotification = "ROverlayWillDisappearNotification"
let ROverlayDidDisappearNotification = "ROverlayDidDisappearNotification"
let ROverlayWillAppearNotification = "ROverlayWillAppearNotification"
let ROverlayDidAppearNotification = "ROverlayDidAppearNotification"
let ROverlayProgressCompletedNotification = "ROverlayProgressCompletedNotification"

//MARK：ROverlay用户信息key 通知的当前状态 否则nil
let ROverlayLabelTextUserInfoKey = "ROverlayLabelTextUserInfoKey"

//MARK：ROverlay显示类型
enum TOverlayType: Int {
    case tOverlayTypeActivityDefault,
    tOverlayTypeActivityLeaf,
    tOverlayTypeActivityBlur,
    tOverlayTypeActivitySquare,
    tOverlayTypeSucess,
    tOverlayTypeError,
    tOverlayTypeWarning,
    tOverlayTypeInfo,
    tOverlayTypeProgress,
    tOverlayTypeText,
    tOverlayTypeImage,
    tOverlayTypeImageArray
}

//MARK：ROverlay大小
enum TOverlaySize: Int {
    case tOverlaySizeFullScreen,
    tOverlaySizeBar,
    tOverlaySizeRoundedRect
}

//MARK：ROverlay 操作显示类型和显示效果
enum ROverlayOptions: Int {
    case ROverlayOptionNone                       = -1,
    ROverlayOptionOpaqueBackground           = 0,     //不透明背景
    ROverlayOptionOverlayShadow              =  1,     // 阴影
    ROverlayOptionAllowUserInteraction       =  2,     // 允许用户与控件后面的对象交互y
    ROverlayOptionAutoHide                   =  3,     // 自动隐藏控件
    
    ROverlayOptionOverlayTypeActivityDefault =  4,     // 默认动态图片
    ROverlayOptionOverlayTypeActivityLeaf    =  5,     // 叶子动图
    ROverlayOptionOverlayTypeActivityBlur    =  6,     // ⭕️动图
    ROverlayOptionOverlayTypeActivitySquare  =  7,     // 方块动图
    ROverlayOptionOverlayTypeSuccess         =  8,     // 显示成功
    ROverlayOptionOverlayTypeWarning         =  9,     // 显示警告
    ROverlayOptionOverlayTypeError           =  10,    // 显示错误
    ROverlayOptionOverlayTypeInfo            =  11,    // 显示信息
    ROverlayOptionOverlayTypeProgress        =  12,    // 显示进度
    ROverlayOptionOverlayTypeText            =  13,    // 显示文字
    
    ROverlayOptionOverlaySizeFullScreen      =  14,    // 显示全屏图层
    ROverlayOptionOverlaySizeBar             =  15,    // 显示横条图层
    ROverlayOptionOverlaySizeRoundedRect     =  16,    // 显示矩形图层
    
    // 如果不允许用户交互 则采用以下操作
    ROverlayOptionOverlayDismissTap          =  17,    // dismiss通过点击手势
    ROverlayOptionOverlayDismissSwipeUp      =  18,    // 上滑消失
    ROverlayOptionOverlayDismissSwipeDown    =  19,    // 下滑
    ROverlayOptionOverlayDismissSwipeLeft    =  20,    // 左滑
    ROverlayOptionOverlayDismissSwipeRight   =  21,    // 右滑
    
    //实验性操作
    ROverlayOptionOverlayAnimateTransistions =  22  // 自动消失
}


