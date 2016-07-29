# <p align="center">iOS学习：使用AVFoundation实现扫码</center>

# 简介

在**`iOS7`**当中, Apple就已经在**`AVFoundation`**当中加入对扫码的支持, 大家从此就可以和**`ZXing`**说拜拜了, 也感谢**`ZXing`**长期以来为我们提供扫码的功能.

---

# 作者

> 如果你有更好的建议或者对这篇文章有不满的地方, 请联系我, 我会参考你们的意见再进行修改, 联系我时, 请备注**`CALScanQCode`**, 
>
> 最后:
>
> 祝大家学习愉快~谢谢~



Cain(罗家辉)

联系方式: zhebushimengfei@qq.com

腾讯QQ: 350116542

---

## AVFoundation框架

首先我们从整体对所需框架做个初步了解。

`AVFoundation`在相关框架栈中的的位置：

![1](https://github.com/CainRun/CALScanQRCode/blob/master/image-file/1.png)
为了捕捉视频,我们需要这样几种类（与其它的子类）。

> * `AVCaptureDevice` 代表了输入设备,例如摄像头与麦克风。
> * `AVCaptureInput` 代表了输入数据源
> * `AVCaptureOutput` 代表了输出数据源
> * `AVCaptureSession` 用于协调输入与输出之间的数据流

并且还有`AVCaptureVideoPreviewLayer`提供摄像头的预览功能

可以用这样一幅图来概述： 

![2](https://github.com/CainRun/CALScanQRCode/blob/master/image-file/2.png)

---
## 例子

> 实际应用`AVFoundation`来捕捉视频流并不复杂。
>
> Talk is Cheap, Show me the Code.
>
> 我们用代码简单地描述用`AVFoundation`捕捉视频的过程,其他捕捉音频,静态图像的过程也是大同小异的。
>
>  创建`AVCaputureSession`, 作为协调输入与输出的中心,我们第一步需要创建一个`Session`

```objective-c
AVCaptureSession *session = [[AVCaptureSession alloc] init];
```
> 创建`AVCaptureDevice`, 创建一个`AVCaptureDevice`代表代表输入设备。在这里我们制定设备用于摄像。

```objective-c
AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
```
> 创建`AVCaptureDeviceInput`, 并添加到`Session`中, 我们需要使用`AVCaptureDeviceInput`来让设备添加到session中, `AVCaptureDeviceInput`负责管理设备端口。我们可以理解它为设备的抽象。一个设备可能可以同时提供视频和音频的捕捉。我们可以分别用`AVCaptureDeviceInput`来代表视频输入和音频输入。

```objective-c
NSError *error;

AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];

[session addInput:input];
```
> 创建`AVCaptureOutput`, 为了从session中取得数据,我们需要创建一个`AVCaptureOutput`

```objective-c
AVCaptureVideoDataOutput *output = [[AVCaptureVideoDataOutput alloc]init];
```
> 设置`output delegate`, 将`output`添加至`session`, 在代理方法中分析视频流, 为了分析视频流,我们需要为`output`设置`delegate`, 并且指定`delegate`方法在哪个线程被调用。需要主要的是, 线程必须是串行的, 确保视频帧按序到达。

```objective-c
videoDataOutputQueue = dispatch_queue_create("VideoDataOutputQueue", DISPATCH_QUEUE_SERIAL);

[videoDataOutput setSampleBufferDelegate:self queue:videoDataOutputQueue];

[session addOutput:videoDataOutput];
```
> 我们可以在`delegate`方法中分析视频流。

```objective-c
captureOutput:didOutputSampleBuffer:fromConnection:
```
> 开始捕捉

```objective-c
[session startRunning];
```
>  通过上面的简单例子,我么可以看出使用`AVFoundation`来捕捉视频流并不是十分复杂。重点是使用的过程需要了解配置的细节,还有性能问题。

---
## Demo

> 学习基础知识过后,让我们用个具体例子来进行阐明。
>
> 在这里我们可以看到和上面创建捕捉视频流的步骤基本是一致的。

> * 创建`session`
> * 创建`device`
> * 创建`input`
> * 创建`output`
> * 这里是与捕捉视频流所不一致的地方。我们捕捉视频流需要的是`AVCaptureVideoDataOutput`, 而在这里我们需要捕捉的是二维码信息。因此我们需要`AVCaptureMetadataOutput`。并且我们需要指定捕捉的`metadataObject`类型。在这里我们指定的是`AVMetadataObjectTypeQRCode`, 我们还可以指定其他类型, 例如`PDF417`条码类型, 完整的可指定列表可以在[这里](https://developer.apple.com/library/ios/documentation/AVFoundation/Reference/AVMetadataMachineReadableCodeObject_Class/index.html#//apple_ref/doc/constant_group/Machine_Readable_Object_Types)找到。
> * 然后我们还要指定处理这些信息的`delegate`与队列。
> * 开始录制

1. 设置`AVFoundation`

```objectivec
- (void)setupAVFoundation {

    //session
    self.session = [[AVCaptureSession alloc] init];
    
    //device
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    NSError *error = nil;
    
    //input
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
    
    if(input) {
    
        [self.session addInput:input];
        
    } else {
    
        NSLog(@"%@", error);
        
        return;
    }
    
    //output
    AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc] init];
    
    [self.session addOutput:output];
    
    [output setMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]];
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];

    //add preview layer
    self.previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
    
    [self.preview.layer addSublayer:self.previewLayer];

    //start
    [self.session startRunning];
}
```
---
> 实现代理方法

```objectivec
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {

    for (AVMetadataMachineReadableCodeObject *metadata in metadataObjects) {
    
        if ([metadata.type isEqualToString:AVMetadataObjectTypeQRCode]) {

            self.borderView.hidden = NO;
            
            if ([metadata.stringValue isURL]) {
            
                [[UIApplication sharedApplication] openURL:[NSString HTTPURLFromString:metadata.stringValue]];
                
                [self insertURLEntityWithURL:metadata.stringValue];
                
                self.stringLabel.text = metadata.stringValue;
                
            } else {
            
                self.stringLabel.text = metadata.stringValue;
            }
        }
    }
}
```

> 我们需要在代理方法里面接收数据, 并根据自己的需求进行处理。在这里我简单地进行了URL的测试, 如果是的话则打开safari进行浏览。

---
# <p align="center">CALScanQCode使用方法</center>

### 继承:


首先我提供的是**`Controller`**, 所以如果需要使用, 直接继承于我这个**`Controller`**就可以了:

```objective-c
#import "CALScanQRCodeViewController.h"

@interface CALScanQRCodeExampleViewController : CALScanQRCodeViewController

@end
```
---

### 获取数据

> 在**`Controller`**当中, 我提供了两个**`Block`**函数, 用来获取纯字符串数据和整个扫码数组的数据, 前提当然是要继承与**`CALScanQRCodeViewController`**才可以这么写:

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

> 支持的条码类型都是使用**`Apple`**系统所提供的, 详情可以去[这里](https://developer.apple.com/library/ios/documentation/AVFoundation/Reference/AVMetadataMachineReadableCodeObject_Class/index.html#//apple_ref/doc/constant_group/Machine_Readable_Object_Types)查找:

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

> 如果你需要更改摄像头的对焦**`Y`**轴, 你可以在项目中找到以下的代码, 把它的**`Y`**轴设置成你要偏移的位置就可以了.

```objective-c
//    _captureMetadataOutPut.rectOfInterest = CGRectMake(0, 0, CALScreenWidth, CALScreenHeight);

    _captureMetadataOutPut.rectOfInterest = CGRectMake(0, -20, CALScreenWidth, CALScreenHeight);
```

---

## 总结

> 在这里仅仅是通过一个二维码的应用来展示`AVFoundation`处理视频流能力。事实上，`AVFoundation`能够做得更多。能够进行剪辑, 处理音轨等功能。如果我们需要对视频与音频相关的事务进行处理, 不妨在着手处理, 寻找第三方解决方案前,看看这个苹果公司为我们带来的强大模块。