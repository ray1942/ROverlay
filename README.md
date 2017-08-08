# ROverlay
一个iOS菊花／文字／图片提示 ————————— ROverlay

代码大体翻译 TaimurAyaz — https://github.com/TaimurAyaz/TAOverlay
图标使用的是原作者的图标，我在认真学习原作者代码之后，完成了swift版本的编写，再次感谢🙏 TaimurAyaz thx a lot

相比OC版本我加了一些可以默认的样式，尽量的暴露一些简单的接口给用户使用。

###使用姿势
*默认显示效果：
```
            ROverlay.showOverlay()

```
![RAOverlay](https://github.com/ray1942/ROverlay/blob/master/screenshot1.png)


*一个⭕️圈圈 模糊—>清晰->模糊
```
            ROverlay.showBlurOverlay()

```
![RAOverlay](https://github.com/ray1942/ROverlay/blob/master/screenshot2.png)


*旋转的正方形

```
            ROverlay.showSquareOverlay()

```
![RAOverlay](https://github.com/ray1942/ROverlay/blob/master/screenshot3.png)

*旋转的叶子

```
            ROverlay.showLeafOverlay()

```
![RAOverlay](https://github.com/ray1942/ROverlay/blob/master/screenshot4.png)

*信息提示

```
            ROverlay.showInfoOverlay()

```
![RAOverlay](https://github.com/ray1942/ROverlay/blob/master/screenshot5.png)

*错误提示❌

```
            ROverlay.showErrorOverlay()

```
![RAOverlay](https://github.com/ray1942/ROverlay/blob/master/screenshot6.png)

*警告⚠️

```
            ROverlay.showWarningOverlay()

```
![RAOverlay](https://github.com/ray1942/ROverlay/blob/master/screenshot7.png)

*成功提示

```
            ROverlay.showSuccessOverlay()

```
![RAOverlay](https://github.com/ray1942/ROverlay/blob/master/screenshot8.png)

*文字提示提示

```
            ROverlay.showTextOverlay(status: "获取数据失败，请检查您的网络”)

```
![RAOverlay](https://github.com/ray1942/ROverlay/blob/master/screenshot0.png)

```
	//其他文字提示方法：
 	ROverlay.showTextOverlay(status: String, duration: Double)
        ROverlay.showTextOverlay(status: String, fontColor: UIColor, duration: Double)
        ROverlay.showTextOverlay(status: String, fontColor: UIColor)

```

*显示菊花效果，自定义标题，标题颜色和图标颜色

```
            ROverlay.showOverlay(status: String, fontColor: UIColor, iconColor: UIColor)

```

![RAOverlay](https://github.com/ray1942/ROverlay/blob/master/screenshot9.png)

*让菊花们隐藏的方法

如果是文字提示的话会自动隐藏，默认时间1s

```
//默认方式
	     ROverlay.hideOverlay()

//如果你想菊花消失的时候办点事情
           ROverlay.hideOverlay { (Bool) -> (Void) in
                    code
           }

```

代码里还有更多自定义效果的方法，请查看代码，多多指教😊。
如果有什么问题，请邮件📧联系我：ray_1942@icloud.com

