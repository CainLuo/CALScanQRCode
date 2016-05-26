# CALScanQCode

在iOS7当中, Apple就已经在AVFoundation当中加入对扫码的支持, 大家从此就可以和ZXing说拜拜了, 也感谢ZXing长期以来为我们提供扫码的功能.

---

# 作者

如果你有更好的建议或者对这篇文章有不满的地方, 请联系我, 我会参考你们的意见再进行修改, 联系我时, 请备注CALScanQCode, 祝大家学习愉快~谢谢~



Cain(罗家辉)

联系方式: zhebushimengfei@qq.com

腾讯QQ: 350116542

---

# 使用方法

### 继承:



首先我提供的是Controller, 所以如果需要使用, 直接继承于我这个Controller就可以了:

```objective-c
#import "CALScanQRCodeViewController.h"

@interface CALScanQRCodeExampleViewController : CALScanQRCodeViewController

@end
```
---

### 获取数据

在Controller当中, 我提供了两个Block函数, 用来获取纯字符串数据和整个扫码数组的数据, 前提当然是要继承与CALScanQRCodeViewController才可以这么写:

```objective-c
[self setCALScanQRCodeGetMetadataStringValue:^(NSString *stringValue) {
```

```objective-c
	NSLog(@"Scan Straing Value = %@", stringValue);
}];
    
[self setCALScanQRCodeGetMetadataObjectsBlock:^(NSArray *array) {
       
	NSLog(@"Scan array = %@", array);
}];
```



---

### 扫码类型

支持的条码类型都是使用Apple系统所提供的, 详情可以去[这里](https://developer.apple.com/library/ios/documentation/AVFoundation/Reference/AVMetadataMachineReadableCodeObject_Class/index.html#//apple_ref/doc/constant_group/Machine_Readable_Object_Types)查找:

```objective-c
AVMetadataObjectTypeUPCECode,
AVMetadataObjectTypeCode39Code,                                                   
AVMetadataObjectTypeCode39Mod43Code,
AVMetadataObjectTypeEAN13Code,
AVMetadataObjectTypeEAN8Code,
AVMetadataObjectTypeCode93Code,
AVMetadataObjectTypeCode128Code,
AVMetadataObjectTypePDF417Code,
AVMetadataObjectTypeQRCode,
AVMetadataObjectTypeAztecCode,
AVMetadataObjectTypeInterleaved2of5Code,
AVMetadataObjectTypeITF14Code,
AVMetadataObjectTypeDataMatrixCode
```

---

### 特别注意:

如果你需要更改摄像头的对焦Y轴, 你可以在项目中找到以下的代码, 把它的Y轴设置成你要偏移的位置就可以了.

```objective-c
//    _captureMetadataOutPut.rectOfInterest = CGRectMake(0, 0, CALScreenWidth, CALScreenHeight);

    _captureMetadataOutPut.rectOfInterest = CGRectMake(0, -20, CALScreenWidth, CALScreenHeight);
```