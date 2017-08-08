# ROverlay
一个iOS弹窗控件 ————————— ROverlay

代码大体翻译 TaimurAyaz — https://github.com/TaimurAyaz/TAOverlay
图标使用的是原作者的图标，我在认真学习原作者代码之后，完成了swift版本的编写，再次感谢🙏 TaimurAyaz thx a lot

相比OC版本我加了一些可以默认的样式，尽量的暴露一些简单的接口给用户使用。

###使用姿势
*默认显示效果：

![RAOverlay](https://github.com/ray1942/ROverlay/blob/master/screenshot1.png)

```
            ROverlay.showOverlay()

```
*一个⭕️圈圈 模糊—>清晰->模糊
![RAOverlay](https://github.com/ray1942/ROverlay/blob/master/screenshot2.png)

```
            ROverlay.showBlurOverlay()

```
*旋转的正方形
![RAOverlay](https://github.com/ray1942/ROverlay/blob/master/screenshot3.png)

```
            ROverlay.showSquareOverlay()

```
*旋转的叶子
![RAOverlay](https://github.com/ray1942/ROverlay/blob/master/screenshot4.png)

```
            ROverlay.showLeafOverlay()

```
*信息提示
![RAOverlay](https://github.com/ray1942/ROverlay/blob/master/screenshot5.png)

```
            ROverlay.showInfoOverlay()

```
*错误提示❌
![RAOverlay](https://github.com/ray1942/ROverlay/blob/master/screenshot6.png)

```
            ROverlay.showErrorOverlay()

```
*警告⚠️
![RAOverlay](https://github.com/ray1942/ROverlay/blob/master/screenshot7.png)

```
            ROverlay.showWarningOverlay()

```
*成功提示
![RAOverlay](https://github.com/ray1942/ROverlay/blob/master/screenshot8.png)

```
            ROverlay.showSuccessOverlay()

```
*文字提示提示
![RAOverlay](https://github.com/ray1942/ROverlay/blob/master/screenshot8.png)

```
            ROverlay.showTextOverlay(status: "获取数据失败，请检查您的网络")

```
*显示菊花效果，自定义标题，标题颜色和图标颜色
![RAOverlay](https://github.com/ray1942/ROverlay/blob/master/screenshot9.png)

```
            ROverlay.showOverlay(status: String, fontColor: UIColor, iconColor: UIColor)

```

*让菊花们隐藏的方法

```
//默认方式
	     ROverlay.hideOverlay()

//如果你想菊花消失的时候办点事情
           ROverlay.hideOverlay { (Bool) -> (Void) in
                    code
           }

```

代码里还有更多自定义效果的方法，请查看代码，多多指教😊。

