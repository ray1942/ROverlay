//
//  ROverlay.swift
//  Widgets
//
//  Created by ray on 2017/8/3.
//  Copyright © 2017年 ray. All rights reserved.
//

import UIKit

class ROverlay: UIView {
    
    //MARK：属性
    //    完成回调
    fileprivate var completionClosure: ((Bool)->Void)?

    //    当前应用的window
    fileprivate var currnetWindow: UIWindow?
    //    背景阴影
    fileprivate var background: UIView?
    //    图层
    fileprivate var  overlay: UIToolbar?
    //    默认动态指示图
    fileprivate var  spinner: UIActivityIndicatorView?
    //    图片展示UIImageView 放置图片或图片数组
    fileprivate var  image: UIImageView?
    //    overlay状态label
    fileprivate var  label: UILabel?
    //    layer图层用于放置警告/错误/信息/成功图标
    fileprivate var  icon: CAShapeLayer?
    //    overlay的字体
    fileprivate var  olFont: UIFont!
    fileprivate var  overlayFont: UIFont?{
        set{
            olFont = newValue
            if newValue != nil {
                if label != nil {
                    label?.font = olFont
                    if self.didSetOverlayLabelFont! {
                        overlayDimensionsWithNotification(nil)
                    }
                }
            }else{
                if label != nil {
                    label?.font = OVERLAY_LABEL_FONT
                    if self.didSetOverlayLabelFont! {
                        self.overlayDimensionsWithNotification(nil)
                    }
                }
            }
        }
        get{
            return olFont
        }
    }
    
    //    overlay的背景色
    fileprivate var   overlaybgColor: UIColor!
    var overlayBackgroundColor: UIColor?{
        set{
            overlaybgColor = newValue
            if newValue != nil  {
                if !showBlurred! {
                    overlay?.barTintColor = overlaybgColor
                }
            }else{
                if !showBlurred! {
                    overlay?.barTintColor = OVERLAY_BACKGROUND_COLOR
                }
            }
        }
        get{
            return self.overlaybgColor
        }
    }

    
    //    overlay阴影颜色
    fileprivate var  olShadowColor: UIColor!
    fileprivate var  overlayShadowColor: UIColor?{
        set{
            olShadowColor = newValue
            if newValue != nil  {
                self.background?.backgroundColor = newValue
            }else{
                self.background?.backgroundColor = OVERLAY_SHADOW_COLOR
            }
        }
        get{
            return olShadowColor
        }
    }

    
    //    overlay字体颜色
    fileprivate var  olFontColor: UIColor!
    fileprivate var  overlayFontColor: UIColor?{
        set{
            olFontColor = newValue
            if newValue != nil {
                label?.textColor = olFontColor
            }else{
                label?.textColor = OVERLAY_LABEL_FONT_COLOR
            }
        }
        get{
            return olFontColor
        }
    }

    
    //    overlay图标颜色
    fileprivate var  olIconColor: UIColor!
    fileprivate var  overlayIconColor: UIColor?{
        set{
            olIconColor = newValue
            if newValue != nil  {
                self.didSetOverlayIconColor = true
                if self.overlayType != TOverlayType.tOverlayTypeProgress {
                    self.icon?.fillColor = olIconColor?.cgColor
                    self.icon?.borderColor = olIconColor?.cgColor
                }
            }else{
                self.didSetOverlayIconColor = false
                if self.overlayType != TOverlayType.tOverlayTypeProgress {
                    if self.overlayType == TOverlayType.tOverlayTypeSucess {
                        olIconColor = OVERLAY_SUCCESS_COLOR
                    }else if self.overlayType == TOverlayType.tOverlayTypeWarning{
                        olIconColor = OVERLAY_WARNING_COLOR
                    }else if self.overlayType == TOverlayType.tOverlayTypeError{
                        olIconColor = OVERLAY_ERROR_COLOR
                    }else if self.overlayType == TOverlayType.tOverlayTypeInfo{
                        olIconColor = OVERLAY_INFO_COLOR
                    }
                    self.icon?.fillColor = olIconColor?.cgColor
                    self.icon?.borderColor = olIconColor?.cgColor
                }
            }
        }
        get{
            return olIconColor
        }
    }
    
    
    //    进度条颜色
    fileprivate var  olProgressColor: UIColor!
    fileprivate var  overlayProgressColor: UIColor?{
        set{
            olProgressColor = newValue
            if self.overlayType == TOverlayType.tOverlayTypeProgress {
                icon?.strokeColor = newValue?.cgColor
            }else{
                icon?.strokeColor = OVERLAY_PROGRESS_COLOR.cgColor
            }
        }
        get{
            return olProgressColor
        }
    }
  
    
    //    图片数组
    fileprivate var  imageArray: Array<UIImage>?
    //    当前label文字
    fileprivate var  olText:String!
    fileprivate var  overlayText: String?{
        set{
            olText = newValue
            self.label?.text = newValue
            if label != nil && self.didSetOverlayLabelFont! {
                self.overlayDimensionsWithNotification(nil)
            }
        }
        get{
            return olText
        }
    }
  
    
    //    当前图标图片
    fileprivate var  iconImage: UIImage?
    //    进度值
    fileprivate var  olProgress: CGFloat!
    fileprivate var  overlayProgress: CGFloat?{
        set{
            if newValue != nil{
                if newValue! >= 0.0 {
                    if newValue! <= 1.0 {
                        olProgress = newValue
                        setProgress(progress: olProgress, isAnimation: true)
                    }
                }else{
                    olProgress = 1.0
                    self.setProgress(progress: olProgress, isAnimation: true)
                }
            }
        }
        get{
            return olProgress
        }
    }
    
    //    当前overlay操作
    fileprivate var  options: [ROverlayOptions]?
    //    当前overlay类型
    fileprivate var  overlayType: TOverlayType?
    //    当前overlay大小
    fileprivate var  overlaySize: TOverlaySize?
    //    是否支持用户交互
    fileprivate var  interaction:Bool?
    //    是否展示阴影背景
    fileprivate var  showBackgroud:Bool?
    //    是否展示⭕️
    fileprivate var  showBlurred: Bool?
    //    是否自动隐藏
    fileprivate var  shoudHide: Bool?
    //     是否会隐藏 用于控制自动隐藏
    fileprivate var  willHide: Bool?
    //    是否是用户单击隐藏
    fileprivate var  userDismissTap: Bool?
    //    是否滑动隐藏
    fileprivate var  userDismissSwipe: Bool?
    //    是否用户自定义图标颜色
    fileprivate var  didSetOverlayIconColor: Bool?
    //    是否设置自定义内容
    fileprivate var  didSetOverlayLabelText: Bool?
    //    是否设置自定义字体
    fileprivate var  didSetOverlayLabelFont: Bool?
    //    自定义动画时间
    fileprivate var  customAnimationDuration: CGFloat?
    //    单击手势
    fileprivate var  tapGesture: UITapGestureRecognizer?
    //    上下滑动手势
    fileprivate var  swipeUpDownGesture: UISwipeGestureRecognizer?
    //    左右滑动手势
    fileprivate var swipeLeftRightGesture: UISwipeGestureRecognizer?
    
    static let shared:ROverlay = {
        let instance = ROverlay.init()
        return instance
    }()

    
    
//    MARK:    隐藏/显示方法
  /**
    显示菊花
     @param status: 显示文字
     */
    static public func showOverlay(){
        ROverlay.showOverlay(status: "",fontColor: OVERLAY_LABEL_FONT_COLOR ,iconColor: OVERLAY_ACTIVITY_DEFAULT_COLOR)
    }
    static public func showOverlay(status: String){
        ROverlay.showOverlay(status: status,fontColor: OVERLAY_LABEL_FONT_COLOR ,iconColor: OVERLAY_ACTIVITY_DEFAULT_COLOR)
    }
    static public func showOverlay(iconColor: UIColor){
        ROverlay.showOverlay(status: "",fontColor: OVERLAY_LABEL_FONT_COLOR ,iconColor: iconColor)
    }
    static public func showOverlay(status: String,fontColor: UIColor, iconColor: UIColor){
        OVERLAY_ACTIVITY_DEFAULT_COLOR = iconColor
        OVERLAY_LABEL_FONT_COLOR = fontColor
        let options = [ROverlayOptions.ROverlayOptionOpaqueBackground,ROverlayOptions.ROverlayOptionOverlaySizeRoundedRect,ROverlayOptions.ROverlayOptionOverlayTypeActivityDefault]
        shared.didSetOverlayLabelFont = false
        shared.didSetOverlayLabelText = false
        shared.overlayText = status
        shared.analyzeOptions(options: options, hasImage: false, hasImageArray: false)
    }
    
    
    static public func showLeafOverlay(){
        ROverlay.showLeafOverlay(status: "", fontColor: OVERLAY_LABEL_FONT_COLOR, iconColor: OVERLAY_ACTIVITY_LEAF_COLOR)
    }
    static public func showLeafOverlay(status: String){
        ROverlay.showLeafOverlay(status: status, fontColor: OVERLAY_LABEL_FONT_COLOR, iconColor: OVERLAY_ACTIVITY_LEAF_COLOR)
    }
    static public func showLeafOverlay(fontColor: UIColor, iconColor: UIColor){
        ROverlay.showLeafOverlay(status: "", fontColor: fontColor, iconColor: iconColor)
    }
    static public func showLeafOverlay(status: String,fontColor: UIColor, iconColor: UIColor){
        OVERLAY_ACTIVITY_LEAF_COLOR = iconColor
        OVERLAY_LABEL_FONT_COLOR = fontColor
        let options = [ROverlayOptions.ROverlayOptionOpaqueBackground,ROverlayOptions.ROverlayOptionOverlaySizeRoundedRect,ROverlayOptions.ROverlayOptionOverlayTypeActivityLeaf]
        shared.didSetOverlayLabelFont = false
        shared.didSetOverlayLabelText = false
        shared.overlayText = status
        shared.analyzeOptions(options: options, hasImage: false, hasImageArray: false)
    }
    
    
    static public func showBlurOverlay(){
        ROverlay.showBlurOverlay(status: "", fontColor: OVERLAY_LABEL_FONT_COLOR, iconColor: OVERLAY_ACTIVITY_BLUR_COLOR)
    }
    static public func showBlurOverlay(status: String){
        ROverlay.showBlurOverlay(status: status, fontColor: OVERLAY_LABEL_FONT_COLOR, iconColor: OVERLAY_ACTIVITY_BLUR_COLOR)
    }
    static public func showBlurOverlay(fontColor: UIColor, iconColor: UIColor){
        ROverlay.showBlurOverlay(status: "", fontColor: fontColor, iconColor: iconColor)
    }
    static public func showBlurOverlay(status: String,fontColor: UIColor, iconColor: UIColor){
        OVERLAY_ACTIVITY_BLUR_COLOR = iconColor
        OVERLAY_LABEL_FONT_COLOR = fontColor
        let options = [ROverlayOptions.ROverlayOptionOpaqueBackground,ROverlayOptions.ROverlayOptionOverlaySizeRoundedRect,ROverlayOptions.ROverlayOptionOverlayTypeActivityBlur]
        shared.didSetOverlayLabelFont = false
        shared.didSetOverlayLabelText = false
        shared.overlayText = status
        shared.analyzeOptions(options: options, hasImage: false, hasImageArray: false)
    }
    
    static public func showErrorOverlay(){
        let options = [ROverlayOptions.ROverlayOptionOpaqueBackground,ROverlayOptions.ROverlayOptionOverlaySizeRoundedRect,ROverlayOptions.ROverlayOptionOverlayTypeError]
        shared.didSetOverlayLabelFont = false
        shared.didSetOverlayLabelText = false
        shared.overlayText = ""
        shared.analyzeOptions(options: options, hasImage: false, hasImageArray: false)
    }
    static public func showErrorOverlay(status: String){
        let options = [ROverlayOptions.ROverlayOptionOpaqueBackground,ROverlayOptions.ROverlayOptionOverlaySizeRoundedRect,ROverlayOptions.ROverlayOptionOverlayTypeError]
        shared.didSetOverlayLabelFont = false
        shared.didSetOverlayLabelText = false
        shared.overlayText = status
        shared.analyzeOptions(options: options, hasImage: false, hasImageArray: false)
    }
    
    static public func showInfoOverlay(){
        let options = [ROverlayOptions.ROverlayOptionOpaqueBackground,ROverlayOptions.ROverlayOptionOverlaySizeRoundedRect,ROverlayOptions.ROverlayOptionOverlayTypeInfo]
        shared.didSetOverlayLabelFont = false
        shared.didSetOverlayLabelText = false
        shared.overlayText = ""
        shared.analyzeOptions(options: options, hasImage: false, hasImageArray: false)
    }
    static public func showInfoOverlay(status: String){
        let options = [ROverlayOptions.ROverlayOptionOpaqueBackground,ROverlayOptions.ROverlayOptionOverlaySizeRoundedRect,ROverlayOptions.ROverlayOptionOverlayTypeInfo]
        shared.didSetOverlayLabelFont = false
        shared.didSetOverlayLabelText = false
        shared.overlayText = status
        shared.analyzeOptions(options: options, hasImage: false, hasImageArray: false)
    }
    
    static public func showSuccessOverlay(){
        let options = [ROverlayOptions.ROverlayOptionOpaqueBackground,ROverlayOptions.ROverlayOptionOverlaySizeRoundedRect,ROverlayOptions.ROverlayOptionOverlayTypeSuccess]
        shared.didSetOverlayLabelFont = false
        shared.didSetOverlayLabelText = false
        shared.overlayText = ""
        shared.analyzeOptions(options: options, hasImage: false, hasImageArray: false)
    }
    static public func showSuccessOverlay(status: String){
        let options = [ROverlayOptions.ROverlayOptionOpaqueBackground,ROverlayOptions.ROverlayOptionOverlaySizeRoundedRect,ROverlayOptions.ROverlayOptionOverlayTypeSuccess]
        shared.didSetOverlayLabelFont = false
        shared.didSetOverlayLabelText = false
        shared.overlayText = status
        shared.analyzeOptions(options: options, hasImage: false, hasImageArray: false)
    }
    
    static public func showWarningOverlay(){
        let options = [ROverlayOptions.ROverlayOptionOpaqueBackground,ROverlayOptions.ROverlayOptionOverlaySizeRoundedRect,ROverlayOptions.ROverlayOptionOverlayTypeWarning]
        shared.didSetOverlayLabelFont = false
        shared.didSetOverlayLabelText = false
        shared.overlayText = ""
        shared.analyzeOptions(options: options, hasImage: false, hasImageArray: false)
    }
    static public func showWarningOverlay(status: String){
        let options = [ROverlayOptions.ROverlayOptionOpaqueBackground,ROverlayOptions.ROverlayOptionOverlaySizeRoundedRect,ROverlayOptions.ROverlayOptionOverlayTypeWarning]
        shared.didSetOverlayLabelFont = false
        shared.didSetOverlayLabelText = false
        shared.overlayText = status
        shared.analyzeOptions(options: options, hasImage: false, hasImageArray: false)
    }
    static public func showTextOverlay(status: String){
       ROverlay.showTextOverlay(status: status, fontColor: OVERLAY_LABEL_FONT_COLOR)
    }
    static public func showTextOverlay(status: String, duration: Double){
        ROverlay.showTextOverlay(status: status, fontColor: OVERLAY_LABEL_FONT_COLOR,duration : duration)
    }
    static public func showTextOverlay(status: String, fontColor: UIColor){
        ROverlay.showTextOverlay(status: status, fontColor: fontColor, duration: 1.0)
    }
    static public func showTextOverlay(status: String, fontColor: UIColor,duration: Double){
        OVERLAY_LABEL_FONT_COLOR = fontColor
        let options = [ROverlayOptions.ROverlayOptionOpaqueBackground,ROverlayOptions.ROverlayOptionOverlaySizeRoundedRect,ROverlayOptions.ROverlayOptionOverlayTypeText]
        shared.didSetOverlayLabelFont = false
        shared.didSetOverlayLabelText = false
        shared.overlayText = status
        shared.analyzeOptions(options: options, hasImage: false, hasImageArray: false)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + duration) {
            ROverlay.hideOverlay()
        }
    }
    
    static public func showSquareOverlay(){
        ROverlay.showSquareOverlay(status: "", fontColor: OVERLAY_ACTIVITY_SQUARE_COLOR, iconColor: OVERLAY_LABEL_FONT_COLOR)
    }
    static public func showSquareOverlay(status: String){
        ROverlay.showSquareOverlay(status:status, fontColor: OVERLAY_ACTIVITY_SQUARE_COLOR, iconColor: OVERLAY_LABEL_FONT_COLOR)
    }
    static public func showSquareOverlay(fontColor: UIColor, iconColor: UIColor){
        ROverlay.showSquareOverlay(status: "", fontColor: fontColor, iconColor: iconColor)
    }
    static public func showSquareOverlay(status: String,fontColor: UIColor, iconColor: UIColor){
        OVERLAY_ACTIVITY_SQUARE_COLOR = iconColor
        OVERLAY_LABEL_FONT_COLOR = fontColor
        let options = [ROverlayOptions.ROverlayOptionOpaqueBackground,ROverlayOptions.ROverlayOptionOverlaySizeRoundedRect,ROverlayOptions.ROverlayOptionOverlayTypeActivitySquare]
        shared.didSetOverlayLabelFont = false
        shared.didSetOverlayLabelText = false
        shared.overlayText = status
        shared.analyzeOptions(options: options, hasImage: false, hasImageArray: false)
    }
    
 
    
    
    static public func showOverlay(options: [ROverlayOptions]){
        ROverlay.showOverlay(status: "", options: options)
    }
    static public func showOverlay(status: String,fontColor: UIColor, iconColor: UIColor,options: [ROverlayOptions]){
        OVERLAY_ACTIVITY_SQUARE_COLOR = iconColor
        OVERLAY_LABEL_FONT_COLOR = fontColor
        shared.didSetOverlayLabelFont = false
        shared.didSetOverlayLabelText = false
        shared.overlayText = status
        shared.analyzeOptions(options: options, hasImage: false, hasImageArray: false)
    }
    static public func showOverlay(status: String, options: [ROverlayOptions]){
        shared.didSetOverlayLabelFont = false
        shared.didSetOverlayLabelText = false
        shared.overlayText = status
        shared.analyzeOptions(options: options, hasImage: false, hasImageArray: false)
    }
    static public func showOverlay(status: String, image: UIImage, options: [ROverlayOptions]){
        shared.didSetOverlayLabelFont = false
        shared.didSetOverlayLabelText = false
        shared.overlayText = status
        shared.iconImage = image
        shared.analyzeOptions(options: options, hasImage: true, hasImageArray: false)
    }
    static public func showOverlay(status: String, imageArray: Array<UIImage>, duration: CGFloat, options: [ROverlayOptions]) {
        shared.didSetOverlayLabelFont = false
        shared.didSetOverlayLabelText = false
        shared.customAnimationDuration = duration
        shared.overlayText = status
        shared.imageArray = imageArray
        shared.analyzeOptions(options: options, hasImage: false, hasImageArray: true)
    }
    
//    MARK: 隐藏overlay
    static public func hideOverlay() {
        shared.overlayHide(finishedClosure: nil)
    }
//    static public func hideOverlayWithClosure(){
//        if shared.completionClosure != nil {
//            shared.overlayHide(finishedClosure: shared.completionClosure)
//        }else{
//            shared.overlayHide(finishedClosure: nil)
//        }
//    }
    static public func hideOverlay(_ finished: @escaping ((Bool)->(Void))){
        shared.overlayHide(finishedClosure: finished)
    }
//    MARK: 初始化方法
    
    init() {
        
        super.init(frame: UIScreen.main.bounds)
        currnetWindow = (UIApplication.shared.delegate?.window)!
        background = nil
        overlay = nil
        icon = nil
        spinner = nil
        image = nil
        label = nil
        tapGesture = nil
        swipeUpDownGesture = nil
        swipeLeftRightGesture = nil
        self.alpha  = 0

    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    
    private func analyzeOptions(options:[ROverlayOptions],hasImage:Bool,hasImageArray:Bool) {
        self.options = options
        if !hasImageArray && !hasImage {
            if optionPresent(options: options, value: .ROverlayOptionOverlayTypeSuccess){
                self.overlayType = TOverlayType.tOverlayTypeSucess
            }else if optionPresent(options: options, value: .ROverlayOptionOverlayTypeActivityDefault){
                self.overlayType = TOverlayType.tOverlayTypeActivityDefault
            }else if optionPresent(options: options, value: .ROverlayOptionOverlayTypeActivityLeaf){
                self.overlayType = TOverlayType.tOverlayTypeActivityLeaf
            }else if optionPresent(options: options, value: .ROverlayOptionOverlayTypeActivityBlur){
                self.overlayType = TOverlayType.tOverlayTypeActivityBlur
            }else if optionPresent(options: options, value: .ROverlayOptionOverlayTypeActivitySquare){
                self.overlayType = TOverlayType.tOverlayTypeActivitySquare
            }else if optionPresent(options: options, value: .ROverlayOptionOverlayTypeWarning){
                self.overlayType = TOverlayType.tOverlayTypeWarning
            }else if optionPresent(options: options, value: .ROverlayOptionOverlayTypeError){
                self.overlayType = TOverlayType.tOverlayTypeError
            }else if optionPresent(options: options, value: .ROverlayOptionOverlayTypeInfo){
                self.overlayType = TOverlayType.tOverlayTypeInfo
            }else if optionPresent(options: options, value: .ROverlayOptionOverlayTypeProgress){
                self.overlayType = TOverlayType.tOverlayTypeProgress
            }else if optionPresent(options: options, value: .ROverlayOptionOverlayTypeText){
                self.overlayType = TOverlayType.tOverlayTypeText
            }else{
                self.overlayType = TOverlayType.tOverlayTypeActivityLeaf
            }
        }else if hasImage && !hasImageArray{
            self.overlayType = TOverlayType.tOverlayTypeImage
        }else if !hasImage && hasImageArray {
            self.overlayType = TOverlayType.tOverlayTypeImageArray
        }
        
        if optionPresent(options: options, value: .ROverlayOptionOverlaySizeFullScreen) {
            self.overlaySize = TOverlaySize.tOverlaySizeFullScreen
        }else if optionPresent(options: options, value: .ROverlayOptionOverlaySizeBar){
            self.overlaySize = TOverlaySize.tOverlaySizeBar
        }else if optionPresent(options: options, value: .ROverlayOptionOverlaySizeRoundedRect){
            self.overlaySize = TOverlaySize.tOverlaySizeRoundedRect
        }else{
            self.overlaySize = TOverlaySize.tOverlaySizeBar
        }
        
        if optionPresent(options: options, value: .ROverlayOptionOpaqueBackground) {
            self.showBlurred = false
        }else{
            self.showBlurred = true
        }
        
        if optionPresent(options: options, value: .ROverlayOptionOverlayShadow) {
            self.showBackgroud = true
        }else{
            self.showBackgroud = false
        }
        
        if optionPresent(options: options, value: .ROverlayOptionAllowUserInteraction) {
            self.interaction = false
            self.userDismissSwipe = false
            self.userDismissTap = false
        }else{
            self.interaction = true
            if optionPresent(options: options, value: .ROverlayOptionOverlayDismissTap) {
                self.userDismissTap = true
            }else{
                self.userDismissTap = false
            }
            if optionPresent(options: options, value: .ROverlayOptionOverlayDismissSwipeUp,.ROverlayOptionOverlayDismissSwipeLeft,.ROverlayOptionOverlayDismissSwipeDown,.ROverlayOptionOverlayDismissSwipeRight) {
                self.userDismissSwipe = true
            }else{
                self.userDismissSwipe = false
            }
        }
        
        if optionPresent(options: options, value: .ROverlayOptionAutoHide) {
            self.shoudHide = true
        }else{
            self.shoudHide = false
        }
//        MARK: 设置属性
        self.setPropreties()
//        MARK：生成overlay
        overlayMake(status: overlayText!)
    }
    
    
//    MARK：设置属性FUNC
    private func setPropreties() {
        if self.overlayFont == nil {
            self.overlayFont = OVERLAY_LABEL_FONT
        }
//        if self.overlayFontColor == nil {
            self.overlayFontColor = OVERLAY_LABEL_FONT_COLOR
//        }
        if self.overlayBackgroundColor == nil {
            self.overlayBackgroundColor = OVERLAY_BACKGROUND_COLOR
        }
        if self.overlayShadowColor == nil {
            self.overlayShadowColor = OVERLAY_SHADOW_COLOR
        }
        if self.overlayIconColor == nil || !didSetOverlayIconColor! {
            if self.overlayType == TOverlayType.tOverlayTypeSucess {
               self.overlayIconColor = OVERLAY_SUCCESS_COLOR
            }else if self.overlayType == TOverlayType.tOverlayTypeWarning {
                self.overlayIconColor = OVERLAY_WARNING_COLOR
            }else if self.overlayType == TOverlayType.tOverlayTypeInfo {
                self.overlayIconColor = OVERLAY_INFO_COLOR
            }else if self.overlayType == TOverlayType.tOverlayTypeError {
                self.overlayIconColor = OVERLAY_ERROR_COLOR
            }
        }
        self.overlayProgress = 0.0
        if self.overlayProgressColor == nil {
            self.overlayProgressColor = OVERLAY_PROGRESS_COLOR
        }
    }
    private func overlayMake(status: String) {
        
        
        overlayCreate()
        switch overlayType! {
        case .tOverlayTypeSucess:
            CATransaction.begin()
            CATransaction.setDisableActions(true)
            icon?.strokeColor = nil
            icon?.lineWidth = 0.0
            icon?.strokeEnd = 0.0
            CATransaction.commit()
            icon?.path = bezierPathOfCheckSymbol(rect: CGRect.init(x: 0, y: 0, width: 40, height: 40), scale: 0.5, thick: OVERLAY_ICON_THICKNESS).cgPath
            icon?.fillColor = overlayIconColor?.cgColor
            icon?.borderColor = overlayIconColor?.cgColor
            image?.removeFromSuperview()
            image = nil
            spinner?.stopAnimating()
            spinner?.removeFromSuperview()
            spinner = nil
            
        case .tOverlayTypeError:
            CATransaction.begin()
            CATransaction.setDisableActions(true)
            icon?.strokeColor = nil
            icon?.lineWidth = 0.0
            CATransaction.commit()
            icon?.path = bezierPathOfCrossSymbol(rect: CGRect.init(x: 0, y: 0, width: 40, height: 40), scale: 0.5, thick: OVERLAY_ICON_THICKNESS).cgPath
            icon?.fillColor = overlayIconColor?.cgColor
            icon?.borderColor = overlayIconColor?.cgColor
            image?.removeFromSuperview()
            image = nil
            spinner?.stopAnimating()
            spinner?.removeFromSuperview()
            spinner = nil
        case .tOverlayTypeWarning:
            CATransaction.begin()
            CATransaction.setDisableActions(true)
            icon?.strokeColor = nil
            icon?.lineWidth = 0.0
            icon?.strokeEnd = 0.0
            CATransaction.commit()
            icon?.path = bezierPathOfExcalmationSymbol(rect: CGRect.init(x: 0, y: 0, width: 40, height: 40), scale: 0.5, thick: OVERLAY_ICON_THICKNESS).cgPath
            icon?.fillColor = overlayIconColor?.cgColor
            icon?.borderColor = overlayIconColor?.cgColor
            image?.removeFromSuperview()
            image = nil
            spinner?.stopAnimating()
            spinner?.removeFromSuperview()
            spinner = nil
        case .tOverlayTypeInfo:
            CATransaction.begin()
            CATransaction.setDisableActions(true)
            icon?.strokeColor = nil
            icon?.lineWidth = 0.0
            icon?.strokeEnd = 0.0
            CATransaction.commit()
            icon?.path = bezierPathOfInfoSymbol(rect: CGRect.init(x: 0, y: 0, width: 40, height: 40), scale: 0.5, thick: OVERLAY_ICON_THICKNESS).cgPath
            icon?.fillColor = overlayIconColor?.cgColor
            icon?.borderColor = overlayIconColor?.cgColor
            image?.removeFromSuperview()
            image = nil
            spinner?.stopAnimating()
            spinner?.removeFromSuperview()
            spinner = nil
        case .tOverlayTypeProgress:
            CATransaction.begin()
            CATransaction.setDisableActions(true)
            icon?.strokeColor = overlayProgressColor?.cgColor
            icon?.lineWidth = OVERLAY_ICON_THICKNESS
            icon?.strokeEnd = 0.0
            icon?.fillColor = UIColor.clear.cgColor
            icon?.borderColor = UIColor.clear.cgColor
            CATransaction.commit()
            icon?.path = UIBezierPath.init(roundedRect: CGRect.init(x: 0, y: 0, width: 40-OVERLAY_ICON_THICKNESS, height: 40-OVERLAY_ICON_THICKNESS), cornerRadius: 40-OVERLAY_ICON_THICKNESS).cgPath
            image?.removeFromSuperview()
            image = nil
            spinner?.stopAnimating()
            spinner?.removeFromSuperview()
            spinner = nil
        case .tOverlayTypeText:
            icon?.removeFromSuperlayer()
            icon = nil
            spinner?.stopAnimating()
            spinner?.removeFromSuperview()
            spinner = nil
            image?.removeFromSuperview()
            image = nil
        case .tOverlayTypeActivityDefault:
            icon?.removeFromSuperlayer()
            icon = nil
            image?.removeFromSuperview()
            image = nil
            spinner?.startAnimating()
        case .tOverlayTypeActivityLeaf:
            icon?.removeFromSuperlayer()
            icon = nil
            spinner?.stopAnimating()
            spinner?.removeFromSuperview()
            spinner = nil
            if image?.image != nil  {
                image?.image = nil
            }
            image?.frame = CGRect.init(x: 0, y: 0, width: 50, height: 50)
            image?.animationImages = OVERLAY_ACTIVITY_LEAF_ARRAY as? [UIImage]
            image?.animationDuration = 1
            if !image!.isAnimating{
                image?.startAnimating()
            }
            imageArray = nil
        case .tOverlayTypeActivityBlur:
            icon?.removeFromSuperlayer()
            icon = nil
            spinner?.stopAnimating()
            spinner?.removeFromSuperview()
            spinner = nil
            if image!.image != nil  {
                image?.image = nil
            }
            image?.frame = CGRect.init(x: 0, y: 0, width: 50, height: 50)
            image?.animationImages = OVERLAY_ACTIVITY_BLUR_ARRAY as? [UIImage]
            image?.animationDuration = 1
            if !image!.isAnimating {
                image?.startAnimating()
            }
            imageArray = nil
        case .tOverlayTypeActivitySquare:
            icon?.removeFromSuperlayer()
            icon = nil
            spinner?.stopAnimating()
            spinner?.removeFromSuperview()
            spinner = nil
            if image!.image != nil  {
                image?.image = nil
            }
            image?.animationImages = OVERLAY_ACTIVITY_SQUARE_ARRAY as? [UIImage]
            image?.animationDuration = 0.35
            if !image!.isAnimating {
                image?.startAnimating()
            }
            imageArray = nil
        case .tOverlayTypeImage:
            icon?.removeFromSuperlayer()
            icon = nil
            spinner?.stopAnimating()
            spinner?.removeFromSuperview()
            spinner = nil
            if image!.isAnimating {
                image?.stopAnimating()
            }
            if imageArray != nil  {
                imageArray = nil
            }
            if image!.image == nil  {
                image?.image = iconImage
            }
            if image!.animationImages != nil  {
                image?.animationImages = nil
            }
            image?.frame = CGRect.init(x: 0, y: 0, width: 50, height: 50)
        case .tOverlayTypeImageArray:
            icon?.removeFromSuperlayer()
            icon = nil
            spinner?.stopAnimating()
            spinner?.removeFromSuperview()
            spinner = nil
            if image!.image != nil {
                image?.image = nil
            }
            image?.frame = CGRect.init(x: 0, y: 0, width: 50, height: 50)
            image?.animationImages = imageArray
            image?.animationDuration = TimeInterval(customAnimationDuration!)
            if !image!.isAnimating {
                image?.startAnimating()
            }
            imageArray = nil
        }
        if status == "" {
            label?.removeFromSuperview()
            label = nil
        }else{
            label?.text = status
        }
        background?.isUserInteractionEnabled = interaction!
        background?.backgroundColor = UIColor.cyan
        if showBackgroud! {
            background?.backgroundColor = overlayShadowColor
        }else{
            background?.backgroundColor = UIColor.clear
        }
        if !showBlurred! {
            overlay?.isTranslucent = true
            overlay?.backgroundColor = UIColor.clear
//            overlay?.barTintColor = UIColor.init(white: 1.0, alpha: 0.5)
//            overlay?.barTintColor = overlayBackgroundColor
        }else{
            overlay?.isTranslucent = true
            overlay?.barTintColor = nil
            overlay?.backgroundColor = OVERLAY_BLUR_TINT_COLOR
        }
        
        if self.userDismissSwipe! {
            if swipeUpDownGesture == nil && optionPresent(options: options!, value: .ROverlayOptionOverlayDismissSwipeUp,.ROverlayOptionOverlayDismissSwipeDown) {
                swipeUpDownGesture = UISwipeGestureRecognizer.init(target: self, action: #selector(handlerSwipe(_:)))
                if optionPresent(options: self.options!, value: .ROverlayOptionOverlayDismissSwipeUp) {
                    swipeUpDownGesture?.direction = UISwipeGestureRecognizerDirection.up
                }
                if optionPresent(options: self.options!, value: .ROverlayOptionOverlayDismissSwipeDown) {
                    swipeUpDownGesture?.direction = UISwipeGestureRecognizerDirection.down
                }
                currnetWindow?.addGestureRecognizer(swipeUpDownGesture!)
            }
            if swipeLeftRightGesture == nil && optionPresent(options: options!, value: .ROverlayOptionOverlayDismissSwipeLeft,.ROverlayOptionOverlayDismissSwipeRight) {
                swipeLeftRightGesture = UISwipeGestureRecognizer.init(target: self, action: #selector(handlerSwipe(_:)))
                if optionPresent(options: self.options!, value: .ROverlayOptionOverlayDismissSwipeLeft) {
                    swipeLeftRightGesture?.direction = UISwipeGestureRecognizerDirection.left
                }
                if optionPresent(options: self.options!, value: .ROverlayOptionOverlayDismissSwipeRight) {
                    swipeLeftRightGesture?.direction = UISwipeGestureRecognizerDirection.right
                }
                currnetWindow?.addGestureRecognizer(swipeLeftRightGesture!)
            }
        }
        if tapGesture == nil && self.userDismissTap! {
            tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(handleTap(_:)))
            currnetWindow?.addGestureRecognizer(tapGesture!)
        }
        self.overlayDimensionsWithNotification(nil)
        self.overlayShow()
        if shoudHide! {
            Thread.detachNewThreadSelector(#selector(autoHide), toTarget: self, with: nil)
        }
    }
    
    

 
//    MARK：创建overlay
    private func overlayCreate(){
        if overlay == nil {
            overlay = UIToolbar.init(frame: CGRect.zero)
            
            overlay?.isTranslucent = true
            overlay?.backgroundColor = UIColor.clear
            overlay?.layer.masksToBounds = true
            self.registerNotifications()
        }
        
        if overlay?.superview == nil {
            if background == nil {
                background = UIView.init(frame: (currnetWindow?.frame)!)
                if showBackgroud! {
                    background?.backgroundColor = overlayShadowColor
                }else{
                    background?.backgroundColor = UIColor.clear
                }
                background?.alpha = 0.0
                currnetWindow?.addSubview(background!)
                background?.addSubview(overlay!)
            }else{
                currnetWindow?.addSubview(overlay!)
            }
        }
        if spinner == nil  {
            spinner = UIActivityIndicatorView.init(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
            spinner?.color = OVERLAY_ACTIVITY_DEFAULT_COLOR
            spinner?.hidesWhenStopped = true
        }
        if spinner?.superview == nil {
            overlay?.addSubview(spinner!)
        }
        if icon == nil {
            let layerFrame = CGRect.init(x: 0, y: 0, width: 40, height: 40)
            icon = CAShapeLayer()
            icon?.frame = layerFrame
            icon?.borderWidth = OVERLAY_ICON_THICKNESS
            icon?.cornerRadius = 20
            icon?.opacity = 1.0
            icon?.strokeColor = UIColor.clear.cgColor
            icon?.lineWidth = 0.0
            icon?.strokeEnd = 0.0
        }
        if icon?.superlayer == nil {
            overlay?.layer.addSublayer(icon!)
        }
        if image == nil {
            image = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: 40, height: 40))
        }
        if image?.superview == nil {
            overlay?.addSubview(image!)
        }
        if label == nil {
            label = UILabel.init(frame: CGRect.zero)
            label?.textColor = overlayFontColor
            label?.backgroundColor = UIColor.clear
            label?.textAlignment = NSTextAlignment.center
            label?.baselineAdjustment = UIBaselineAdjustment.alignCenters
            label?.numberOfLines = 0
        }
        if label?.superview == nil {
            overlay?.addSubview(label!)
        }
    }

    
//    MARK: 注册监听
     private func registerNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(overlayDimensionsWithNotification(_:)), name: NSNotification.Name.UIApplicationDidChangeStatusBarOrientation, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(overlayDimensionsWithNotification(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(overlayDimensionsWithNotification(_:)), name: NSNotification.Name.UIKeyboardDidHide, object: nil)
         NotificationCenter.default.addObserver(self, selector: #selector(overlayDimensionsWithNotification(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
         NotificationCenter.default.addObserver(self, selector: #selector(overlayDimensionsWithNotification(_:)), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
    }
    //    MARK： 销毁overlay
     private func overlayDestroy() {
        NotificationCenter.default.removeObserver(self)
        if (self.tapGesture != nil) {
            currnetWindow?.removeGestureRecognizer(tapGesture!)
            tapGesture = nil
        }
        if self.swipeUpDownGesture != nil {
            currnetWindow?.removeGestureRecognizer(swipeUpDownGesture!)
            swipeUpDownGesture = nil
        }
        if self.swipeLeftRightGesture != nil  {
            currnetWindow?.removeGestureRecognizer(swipeLeftRightGesture!)
        }
        label?.removeFromSuperview()
        label = nil
        image?.removeFromSuperview()
        image = nil
        spinner?.removeFromSuperview()
        spinner = nil
        overlay?.removeFromSuperview()
        overlay = nil
        icon?.removeFromSuperlayer()
        icon = nil
        background?.removeFromSuperview()
        background = nil
    }
    
//    MARK: 监听方法
     @objc private func overlayDimensionsWithNotification(_ notification: NSNotification?) {
        var  heightKeyboard:CGFloat = 0
        var duration: TimeInterval = 0
        var labelRect: CGRect = CGRect.zero
        var overlayWidth, overlayHeight, imagex, imagey: CGFloat
        if background != nil {
            background?.frame = (currnetWindow?.frame)!
        }
        switch overlaySize! {
        case .tOverlaySizeBar:
            overlay?.layer.cornerRadius = 0
            overlayWidth = UIScreen.main.bounds.size.width
            overlayHeight = 100
            if label?.text != nil {
                labelRect = (label?.text?.boundingRect(with: CGSize.init(width: overlayWidth - 2.0 * LABEL_PADDING_X, height: ifIsThenValue(ifValue: 667.0, isValue: 300.0, thenValue: UIScreen.main.bounds.size.height)), options:  [NSStringDrawingOptions.usesFontLeading, .usesLineFragmentOrigin, .truncatesLastVisibleLine], attributes: [NSFontAttributeName: label!.font], context: nil))!;
                overlayHeight = (labelRect.size.height + 80) > (UIScreen.main.bounds.size.height - 2.0 * LABEL_PADDING_X) ? (UIScreen.main.bounds.size.height - 2.0 * LABEL_PADDING_X) : (labelRect.size.height + 80)
                labelRect.origin.x = overlayWidth/2.0 - labelRect.size.width/2.0
                if self.overlayType == TOverlayType.tOverlayTypeText {
                    labelRect = CGRect.init(x: labelRect.origin.x, y: labelRect.origin.x, width: labelRect.size.width, height: overlayHeight - 2.0 * labelRect.origin.x)
                }else{
                    labelRect.origin.y = LABEL_PADDING_Y
                }
            }
            
            if optionPresent(options: options!, value: ROverlayOptions.ROverlayOptionOverlayAnimateTransistions) {
                if CGRect.zero.equalTo((overlay?.frame)!){
                    overlay?.bounds = CGRect.init(x: 0, y: 0, width: overlayWidth, height: overlayHeight)
                    label?.frame = labelRect
                }else{
                    UIView.animate(withDuration: ANIMATION_DURATION, animations: {
                        self.overlay?.bounds = CGRect.init(x: 0, y: 0, width: overlayWidth, height: overlayHeight)
                        self.label?.frame = labelRect
                    })
                }
            }else{
                overlay?.bounds = CGRect.init(x: 0, y: 0, width: overlayWidth, height: overlayHeight)
                label?.frame = labelRect
            }
            imagex = overlayWidth/2
            imagey = (label?.text == nil ) ? overlayHeight/2.0 : 36.0
            CATransaction.begin()
            CATransaction.setDisableActions(true)
            image?.center = CGPoint.init(x: imagex, y: imagey)
            spinner?.center = CGPoint.init(x: imagex, y: imagey)
            icon?.position = CGPoint.init(x: imagex, y: imagey)
            CATransaction.commit()
        case .tOverlaySizeFullScreen:
            overlay?.layer.cornerRadius = 0
            overlayWidth = UIScreen.main.bounds.size.width
            overlayHeight = UIScreen.main.bounds.size.height
            if label?.text != nil  {
                labelRect = (label?.text?.boundingRect(with: CGSize.init(width: overlayWidth - 2.0 * LABEL_PADDING_X, height: ifIsThenValue(ifValue: 667.0, isValue: 300.0, thenValue: UIScreen.main.bounds.size.height)), options:  [NSStringDrawingOptions.usesFontLeading, .usesLineFragmentOrigin, .truncatesLastVisibleLine], attributes: [NSFontAttributeName: label!.font], context: nil))!;
                
                labelRect.origin.x = overlayWidth/2.0 - labelRect.size.width/2.0
                
                if self.overlayType == TOverlayType.tOverlayTypeText {
                    labelRect = CGRect.init(x: labelRect.origin.x, y: labelRect.origin.x, width: labelRect.size.width, height: overlayHeight - 2.0 * labelRect.origin.x)
                }else{
                    labelRect.origin.y = (overlayHeight/2.0)+16.0
                }
            }
            if optionPresent(options: options!, value: ROverlayOptions.ROverlayOptionOverlayAnimateTransistions) {
                if CGRect.zero.equalTo((overlay?.frame)!){
                    overlay?.bounds = CGRect.init(x: 0, y: 0, width: overlayWidth, height: overlayHeight)
                    label?.frame = labelRect
                }else{
                    UIView.animate(withDuration: ANIMATION_DURATION, animations: {
                        self.overlay?.bounds = CGRect.init(x: 0, y: 0, width: overlayWidth, height: overlayHeight)
                        self.label?.frame = labelRect
                    })
                }
            }else{
                overlay?.bounds = CGRect.init(x: 0, y: 0, width: overlayWidth, height: overlayHeight)
                label?.frame = labelRect
            }
            imagex = overlayWidth/2
            imagey = (label?.text == nil ) ? overlayHeight/2.0 : (overlayHeight/2.0) - 14.0
            CATransaction.begin()
            CATransaction.setDisableActions(true)
            image?.center = CGPoint.init(x: imagex, y: imagey)
            spinner?.center = CGPoint.init(x: imagex, y: imagey)
            icon?.position = CGPoint.init(x: imagex, y: imagey)
            CATransaction.commit()
        case .tOverlaySizeRoundedRect:
            overlay?.layer.cornerRadius = 10
            overlayHeight = 100
            if (self.icon == nil && self.spinner == nil && self.image == nil  && self.overlayText != "") {
                overlayWidth = UIScreen.main.bounds.width
                if label?.text != nil {
                    labelRect = (label?.text?.boundingRect(with: CGSize.init(width: overlayWidth - 2.0 * LABEL_PADDING_X, height: ifIsThenValue(ifValue: 667.0, isValue: 300.0, thenValue: UIScreen.main.bounds.size.height)), options:  [NSStringDrawingOptions.usesFontLeading, .usesLineFragmentOrigin, .truncatesLastVisibleLine], attributes: [NSFontAttributeName: label!.font], context: nil))!;
                    overlayHeight = (labelRect.size.height + 8) > (UIScreen.main.bounds.size.height - 2.0 * LABEL_PADDING_X) ? (UIScreen.main.bounds.size.height - 2.0 * LABEL_PADDING_X) : (labelRect.size.height + 8)
                    labelRect.origin.x = overlayWidth/2.0 - labelRect.size.width/2.0
                    
                    if self.overlayType == TOverlayType.tOverlayTypeText {
                        labelRect = CGRect.init(x: labelRect.origin.x, y: labelRect.origin.x, width: labelRect.size.width, height: overlayHeight - 2.0 * labelRect.origin.x)
                    }else{
                        labelRect.origin.y = LABEL_PADDING_Y
                    }
                }
            }else{
                overlayWidth = 100
                if label?.text != nil {
                    labelRect = (label?.text?.boundingRect(with: CGSize.init(width: overlayWidth - 2.0 * LABEL_PADDING_X, height: ifIsThenValue(ifValue: 667.0, isValue: 300.0, thenValue: UIScreen.main.bounds.size.height)), options:  [NSStringDrawingOptions.usesFontLeading, .usesLineFragmentOrigin, .truncatesLastVisibleLine], attributes: [NSFontAttributeName: label!.font], context: nil))!;
                    overlayHeight = (labelRect.size.height + 80) > (UIScreen.main.bounds.size.height - 2.0 * LABEL_PADDING_X) ? (UIScreen.main.bounds.size.height - 2.0 * LABEL_PADDING_X) : (labelRect.size.height + 80)
                    labelRect.origin.x = overlayWidth/2.0 - labelRect.size.width/2.0
                    
                    if self.overlayType == TOverlayType.tOverlayTypeText {
                        labelRect = CGRect.init(x: labelRect.origin.x, y: labelRect.origin.x, width: labelRect.size.width, height: overlayHeight - 2.0 * labelRect.origin.x)
                    }else{
                        labelRect.origin.y = LABEL_PADDING_Y
                    }
                }
            }
     
 
            if optionPresent(options: options!, value: ROverlayOptions.ROverlayOptionOverlayAnimateTransistions) {
                if CGRect.zero.equalTo((overlay?.frame)!){
                    overlay?.bounds = CGRect.init(x: 0, y: 0, width: overlayWidth, height: overlayHeight)
                    label?.frame = labelRect
                }else{
                    UIView.animate(withDuration: ANIMATION_DURATION, animations: {
                        self.overlay?.bounds = CGRect.init(x: 0, y: 0, width: overlayWidth, height: overlayHeight)
                        self.label?.frame = labelRect
                    })
                }
            }else{
                if (self.icon == nil && self.spinner == nil && self.image == nil && self.overlayText != "") {
                    overlayWidth = UIScreen.main.bounds.width
                    overlay?.bounds = CGRect.init(x: 0, y: 0, width: labelRect.width+8, height: overlayHeight)
                    label?.frame = labelRect.offsetBy(dx: -(overlayWidth-labelRect.width-8)/2, dy: 0)
                }else{
                    overlayWidth = 100
                    overlay?.bounds = CGRect.init(x: 0, y: 0, width: overlayWidth, height: overlayHeight)
                    label?.frame = labelRect
                }
                
            }
            imagex = overlayWidth/2
            imagey = (label?.text == nil ) ? overlayHeight/2.0 : 36
            CATransaction.begin()
            CATransaction.setDisableActions(true)
            image?.center = CGPoint.init(x: imagex, y: imagey)
            spinner?.center = CGPoint.init(x: imagex, y: imagey)
            icon?.position = CGPoint.init(x: imagex, y: imagey)
            CATransaction.commit()
        }
        
        if let notif = notification {
            let info = notif.userInfo
            let keyboard = info?[UIKeyboardFrameEndUserInfoKey] as! CGRect
            duration = info?[UIKeyboardAnimationDurationUserInfoKey] as! Double
            if notif.name == NSNotification.Name.UIKeyboardWillShow || notif.name == NSNotification.Name.UIKeyboardDidShow{
                heightKeyboard = keyboard.size.height
            }
        }else{
            heightKeyboard = self.keyboardHeight()
        }
        let screen = UIScreen.main.bounds
        let center = CGPoint.init(x: screen.size.width/2, y: (screen.size.height-heightKeyboard)/2)
        UIView.animate(withDuration: duration, delay: 0, options: UIViewAnimationOptions.allowUserInteraction, animations: { 
            self.overlay?.center = CGPoint.init(x: center.x , y: center.y)
        }, completion: nil)
    }
    //    MARK:获取键盘高度
     private func keyboardHeight()->CGFloat {
        for tmpWindow in UIApplication.shared.windows {
            if tmpWindow.isEqual(UIWindow.self) {
                for possibleKeyboard in tmpWindow.subviews {
                    if possibleKeyboard.description.hasPrefix("<UIPeripheralHostView>") {
                        return possibleKeyboard.bounds.size.height
                    }else if possibleKeyboard.description.hasPrefix("<UIInputSetContainerView>"){
                        for hostKeyboard in possibleKeyboard.subviews {
                            if hostKeyboard.description.hasPrefix("<UIInputSetHost>") {
                                return hostKeyboard.bounds.size.height
                            }
                        }
                    }
                }
            }
        }
        return 0
    }
    //    MARK: 获取文字信息
     private func getUserInfo()-> Dictionary<String,Any>? {
        return (label?.text != "" ? [ROverlayLabelTextUserInfoKey : (label == nil ? "" : label!.text!)] : nil)
        
    }
    //    MARK: 设置进度条
     private func setProgress(progress: CGFloat, isAnimation: Bool) {
        if self.overlayType == TOverlayType.tOverlayTypeProgress {
            CATransaction.begin()
            CATransaction.setCompletionBlock({
                if progress >= 1.0 {
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: ROverlayProgressCompletedNotification), object: nil, userInfo: self.getUserInfo())
                }
            })
            if isAnimation {
                self.icon?.strokeEnd = progress
            }else{
                CATransaction.begin()
                CATransaction.setDisableActions(true)
                self.icon?.strokeEnd = progress
                CATransaction.commit()
            }
            CATransaction.commit()
        }
    }
    //    MARK: overlay显示
     private func overlayShow() {
        if self.alpha == 0  {
            let userInfo = self.getUserInfo()
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: ROverlayWillAppearNotification), object: nil, userInfo: userInfo)
            self.alpha = 1
            overlay?.alpha = 0
            overlay?.transform = overlay!.transform.scaledBy(x: SCALE_TO, y: SCALE_TO)
            UIView.animate(withDuration: ANIMATION_DURATION, delay: 0, options: [UIViewAnimationOptions.allowAnimatedContent,UIViewAnimationOptions.curveEaseOut], animations: {
                self.overlay?.transform = self.overlay!.transform.scaledBy(x: SCALE_UNITY/SCALE_TO, y: SCALE_UNITY/SCALE_TO)
                self.overlay?.alpha = 1
                self.background?.alpha = 1
            }, completion: { (finished) in
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: ROverlayDidAppearNotification), object: nil, userInfo: userInfo)
                UIAccessibilityPostNotification(UIAccessibilityScreenChangedNotification, nil)
                UIAccessibilityPostNotification(UIAccessibilityAnnouncementNotification, self.label?.text)
            })
        }
    }
    
    //    MARK：overlay隐藏方法 + 闭包
     private func overlayHide(finishedClosure: ((Bool)->(Void))?) {
        if self.alpha == 1 {
            self.willHide = true
            let userInfo = self.getUserInfo()
            NotificationCenter.default.post(name: Notification.Name(rawValue: ROverlayWillDisappearNotification), object: nil, userInfo: userInfo)
            UIView.animate(withDuration: ANIMATION_DURATION, delay: 0, options:  [UIViewAnimationOptions.allowUserInteraction, UIViewAnimationOptions.curveEaseIn], animations: {
                self.overlay?.transform = self.overlay!.transform.scaledBy(x: SCALE_TO, y: SCALE_TO)
                self.overlay?.alpha = 0
            }, completion: { (finished) in
                self.overlayDestroy()
                self.alpha = 0
                self.didSetOverlayIconColor = false
                self.didSetOverlayLabelFont = false
                self.didSetOverlayLabelText = false
                
                OVERLAY_LABEL_FONT_COLOR = UIColor.lightGray
                OVERLAY_ACTIVITY_DEFAULT_COLOR = UIColor.lightGray
                OVERLAY_ACTIVITY_LEAF_COLOR = UIColor.lightGray
                OVERLAY_ACTIVITY_BLUR_COLOR = UIColor.lightGray
                OVERLAY_ACTIVITY_SQUARE_COLOR = UIColor.lightGray
                UIAccessibilityPostNotification(UIAccessibilityScreenChangedNotification, nil)
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: ROverlayDidDisappearNotification), object: nil, userInfo: userInfo)
                if let closure = finishedClosure {
                    closure(finished)
                }
            })
        }
    }
    //MARK: 自动隐藏
     @objc private func autoHide() {
        self.willHide = false
        
        let lenght  = label == nil ? 0.0 : Double((label!.text?.lengthOfBytes(using: String.Encoding.utf8))!)
        let sleep: TimeInterval = lenght * 0.04 + 0.8
        Thread.sleep(forTimeInterval: sleep)
        DispatchQueue.main.async {
            if !self.willHide!{
                self.overlayHide(finishedClosure: self.completionClosure)
            }
        }
    }
    
    
    //    MARK: overlay 手势响应方法
     @objc private func handleTap(_ gesture: UIGestureRecognizer) {
        if userDismissTap! {
            self.overlayHide(finishedClosure: self.completionClosure)
        }
    }
     @objc private func handlerSwipe(_ gesture: UIGestureRecognizer) {
        if userDismissSwipe! {
            self.overlayHide(finishedClosure: self.completionClosure)
        }
    }
    
    
//    MARK： ！！
     private func ifIsThenValue(ifValue: CGFloat, isValue: CGFloat, thenValue: CGFloat) ->CGFloat {
        return (thenValue * isValue) / ifValue
    }

//    MARK: 绘制贝塞尔曲线  --- 校验符号
     private func bezierPathOfCheckSymbol(rect:CGRect,scale: CGFloat,thick:CGFloat) -> UIBezierPath {
        var height, width: CGFloat
        if rect.height > rect.width {
            height = rect.height * scale
            width = height * 32.0 / 25.0
        }else{
            width = rect.width * scale
            height = width * 25.0 / 32.0
        }
        let topPointOffset = thick / sqrt(2.0)
        let bottomHeight = thick * sqrt(2.0)
        let bottomMarginRight = height - topPointOffset
        let bottomMarginLeft =  width - bottomMarginRight
        
        let offsetPoint = CGPoint.init(x: rect.minX + (rect.width - width)/2.0, y: rect.minY + (rect.height - height)/2.0)
        
        let path = UIBezierPath()
        path.move(to: pointWith(originPoint: CGPoint.init(x: 0.0, y: height-bottomMarginLeft), offsetPoint: offsetPoint))
        path.addLine(to: pointWith(originPoint: CGPoint.init(x: bottomMarginLeft, y: height-bottomMarginLeft-topPointOffset), offsetPoint: offsetPoint))
        path.addLine(to: pointWith(originPoint: CGPoint.init(x: bottomMarginLeft, y: height-bottomHeight), offsetPoint: offsetPoint))
        path.addLine(to: pointWith(originPoint: CGPoint.init(x: width-topPointOffset, y: 0.0), offsetPoint: offsetPoint))
        path.addLine(to: pointWith(originPoint: CGPoint.init(x: width, y: topPointOffset), offsetPoint: offsetPoint))
        path.addLine(to: pointWith(originPoint: CGPoint.init(x: bottomMarginLeft, y: height), offsetPoint: offsetPoint))
        path.close()
        return path
    }
//    MARK: 绘制贝塞尔曲线 --- 十字
      private func bezierPathOfCrossSymbol(rect:CGRect, scale: CGFloat, thick: CGFloat) -> UIBezierPath {
        let height = rect.height * scale
        let width = rect.width * scale
        let halfHeight = height / 2.0
        let halfWidth = width / 2.0
        let size = height < width ? height : width
        let offset = thick / sqrt(2.0)
        
        let offsetPoint = CGPoint.init(x: rect.minX+(rect.width-size)/2.0, y: rect.minY+(rect.height-size)/2.0)
        
        let path = UIBezierPath()
        path.move(to: pointWith(originPoint: .init(x: 0.0, y: offset), offsetPoint: offsetPoint))
        path.addLine(to: pointWith(originPoint: CGPoint.init(x: offset, y: 0.0), offsetPoint: offsetPoint))
        path.addLine(to: pointWith(originPoint: CGPoint.init(x: halfWidth, y: halfHeight-offset), offsetPoint: offsetPoint))
        path.addLine(to: pointWith(originPoint: CGPoint.init(x: width-offset, y: 0.0), offsetPoint: offsetPoint))
        path.addLine(to: pointWith(originPoint: CGPoint.init(x: width, y: offset), offsetPoint: offsetPoint))
        path.addLine(to: pointWith(originPoint: CGPoint.init(x: halfWidth+offset, y: halfHeight), offsetPoint: offsetPoint))
        path.addLine(to: pointWith(originPoint: CGPoint.init(x: width, y: height-offset), offsetPoint: offsetPoint))
        path.addLine(to: pointWith(originPoint: CGPoint.init(x: width-offset, y: height), offsetPoint: offsetPoint))
        path.addLine(to: pointWith(originPoint: CGPoint.init(x: halfWidth, y: halfHeight+offset), offsetPoint: offsetPoint))
        path.addLine(to: pointWith(originPoint: CGPoint.init(x: offset, y: height), offsetPoint: offsetPoint))
        path.addLine(to: pointWith(originPoint: CGPoint.init(x: 0.0, y: height-offset), offsetPoint: offsetPoint))
        path.addLine(to: pointWith(originPoint: CGPoint.init(x: halfWidth-offset, y: halfHeight), offsetPoint: offsetPoint))
        return path
    }
//    MARK：绘制贝塞尔曲线 --- 警告
      private func bezierPathOfExcalmationSymbol(rect:CGRect, scale: CGFloat, thick: CGFloat) -> UIBezierPath {
        let height = rect.height * scale
        let width = rect.width * scale
        let twoThirdHeight = height * 2.0 / 3.0
        let halfHeight = height / 2.0 + (twoThirdHeight - height / 2.0) / 2.0
        let halfWidth = width / 2.0
        let size = height < width ? height : width
        let offsetPoint = CGPoint.init(x: rect.minX + (rect.width - size) / 2.0, y: rect.minY + (rect.height-size) / 2.0)
        let path = UIBezierPath()
        path.move(to: pointWith(originPoint: CGPoint.init(x: halfWidth-thick/2.0, y: 0.0), offsetPoint: offsetPoint))
        path.addLine(to: pointWith(originPoint: CGPoint.init(x: halfWidth+thick/2.0, y: 0.0), offsetPoint: offsetPoint))
        path.addLine(to: pointWith(originPoint: CGPoint.init(x: halfWidth+thick/2.0, y: halfHeight), offsetPoint: offsetPoint))
        path.addLine(to: pointWith(originPoint: CGPoint.init(x: halfWidth-thick/2.0, y: halfHeight), offsetPoint: offsetPoint))
        path.addLine(to: pointWith(originPoint: CGPoint.init(x: halfWidth-thick/2.0, y: 0.0), offsetPoint: offsetPoint))
        path.move(to: pointWith(originPoint: CGPoint.init(x: halfWidth, y: twoThirdHeight+thick*3.0/2.0), offsetPoint: offsetPoint))
        path.addArc(withCenter: pointWith(originPoint: CGPoint.init(x: halfWidth, y: twoThirdHeight+thick*3.0/2.0), offsetPoint: offsetPoint), radius: thick, startAngle: 0, endAngle: CGFloat(Double.pi*2), clockwise: true)
        path.close()
        return path
    }
// MARK: 绘制贝塞尔曲线 --- 提示
     private func bezierPathOfInfoSymbol(rect: CGRect, scale: CGFloat, thick: CGFloat) -> UIBezierPath {
        let height = rect.height * scale
        let width = rect.width * scale
        let twoThridHeight = height * 2.0 / 3.0
        let halfHeight = height / 2.0 + (twoThridHeight - height / 2.0) / 2.0
        let halfWidth = width / 2.0
        let size = height < width ? height : width
        let offsetPoint = CGPoint.init(x: rect.minX+(rect.width - size)/2.0, y: rect.minY+(rect.height-size)/2.0)
        let path = UIBezierPath()
        path.move(to: pointWith(originPoint: CGPoint.init(x: halfWidth, y: (height-halfHeight)-thick*2.0), offsetPoint: offsetPoint))
        path.addArc(withCenter: pointWith(originPoint: CGPoint.init(x: halfWidth, y: (height-halfHeight)-thick*2.0), offsetPoint: offsetPoint), radius: thick, startAngle: 0, endAngle: CGFloat(Double.pi*2), clockwise: true)
        path.move(to: pointWith(originPoint: CGPoint.init(x: halfWidth-thick/2.0, y: (height-halfHeight)), offsetPoint: offsetPoint))
        path.addLine(to: pointWith(originPoint: CGPoint.init(x: halfWidth+thick/2.0, y: (height-halfHeight)), offsetPoint: offsetPoint))
        path.addLine(to: pointWith(originPoint: CGPoint.init(x: halfWidth+thick/2.0, y: height), offsetPoint: offsetPoint))
        path.addLine(to: pointWith(originPoint: CGPoint.init(x: halfWidth-thick/2.0, y: height), offsetPoint: offsetPoint))
        path.addLine(to: pointWith(originPoint: CGPoint.init(x: halfWidth-thick/2.0, y: height-halfHeight), offsetPoint: offsetPoint))
        path.close()
        return path
    }
}

