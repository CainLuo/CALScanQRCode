//
//  CLScanQRCodeController.m
//  CLScanQRCode
//
//  Created by Cain on 5/2/16.
//  Copyright © 2016 Cain. All rights reserved.
//

#import "CLScanQRCodeController.h"

#import <AVFoundation/AVFoundation.h>

#define CLScreenWidth          (CGRectGetWidth([[UIScreen mainScreen]  bounds]))
#define CLScreenHeight         (CGRectGetHeight([[UIScreen mainScreen] bounds]))

#define CLStatusBarHeight     (20.0f)
#define CLNavigationBarHeight (44.0f)
#define CLGetMethodReturnObjc(objc) if (objc) return objc
#define CLWeakSelf(weakSelf) __weak __typeof(&*self)weakSelf = self

@interface CLScanQRCodeController() <AVCaptureMetadataOutputObjectsDelegate>

@property (nonatomic, strong) AVCaptureDevice            *captureDevice;
@property (nonatomic, strong) AVCaptureDeviceInput       *captureDeviceInput;
@property (nonatomic, strong) AVCaptureMetadataOutput    *captureMetadataOutPut;
@property (nonatomic, strong) AVCaptureSession           *captureSession;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *captureVideoPreviewLayer;

@property (nonatomic, strong, readwrite) CLScanQRCodeCameraView *cameraView;

@end

@implementation CLScanQRCodeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.cameraView];
    
#if TARGET_IPHONE_SIMULATOR
    
    self.view.backgroundColor = [UIColor blackColor];
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"模拟器没有摄像头功能"
                                                        message:@"请使用真机测试"
                                                       delegate:nil
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"好的", nil];
    
    [alertView show];
    
#elif TARGET_OS_IPHONE
    
    [self.view.layer insertSublayer:self.captureVideoPreviewLayer
                            atIndex:0];

#endif
}

- (AVCaptureDevice *)captureDevice {
    
    if (!_captureDevice) {
        
        _captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    }
    
    return _captureDevice;
}

- (AVCaptureDeviceInput *)captureDeviceInput {
    
    if (!_captureDeviceInput) {
        
        _captureDeviceInput = [AVCaptureDeviceInput deviceInputWithDevice:self.captureDevice
                                                                    error:nil];
    }
    
    return _captureDeviceInput;
}

- (AVCaptureMetadataOutput *)captureMetadataOutPut {
    
    if (!_captureMetadataOutPut) {
        
        _captureMetadataOutPut                = [[AVCaptureMetadataOutput alloc] init];
        _captureMetadataOutPut.rectOfInterest = CGRectMake(0, 0, CLScreenWidth, CLScreenHeight);
        
        [_captureMetadataOutPut setMetadataObjectsDelegate:self
                                                     queue:dispatch_get_main_queue()];
    }
    
    return _captureMetadataOutPut;
}

- (AVCaptureSession *)captureSession {
    
    if (!_captureSession) {
        
        _captureSession = [[AVCaptureSession alloc] init];
        
        [_captureSession setSessionPreset:AVCaptureSessionPresetHigh];
        
        if ([_captureSession canAddInput:self.captureDeviceInput]) {
            [_captureSession addInput:self.captureDeviceInput];
        }
        
        if ([_captureSession canAddOutput:self.captureMetadataOutPut]) {
            [_captureSession addOutput:self.captureMetadataOutPut];
            
            self.captureMetadataOutPut.metadataObjectTypes = @[AVMetadataObjectTypeUPCECode,
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
                                                               AVMetadataObjectTypeDataMatrixCode];
        }
    }
    
    return _captureSession;
}

- (AVCaptureVideoPreviewLayer *)captureVideoPreviewLayer {
    
    if (!_captureVideoPreviewLayer) {
        
        _captureVideoPreviewLayer              = [AVCaptureVideoPreviewLayer layerWithSession:self.captureSession];
        _captureVideoPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        _captureVideoPreviewLayer.frame        = self.view.frame;
    }
    
    return _captureVideoPreviewLayer;
}

#pragma mark - AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput
didOutputMetadataObjects:(NSArray *)metadataObjects
       fromConnection:(AVCaptureConnection *)connection {
    
    if ([metadataObjects count] > 0) {
        
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        
        NSString *stringValue = metadataObject.stringValue;
       
        if (self.cl_scanQRCodeGetMetadataObjectsBlock) {
            self.cl_scanQRCodeGetMetadataObjectsBlock(metadataObjects);
        }
        
        if (self.cl_scanQRCodeGetMetadataStringValue) {
            self.cl_scanQRCodeGetMetadataStringValue(stringValue);
        }
        
        [self cl_stopCaptureSessionRunning];
    }
}

#pragma mark - Set ScanQRCode Camera View
- (CLScanQRCodeCameraView *)cameraView {
    
    CLGetMethodReturnObjc(_cameraView);
    
    _cameraView = [[CLScanQRCodeCameraView alloc] init];
    
    return _cameraView;
}

#pragma mark - Pop View Controller
- (void)popViewController {
    
    [self.navigationController popViewControllerAnimated:true];
}

#pragma mark - Controller Capture Session
- (void)cl_startCaptureSessionRunning {
    
    [self.captureSession startRunning];
    
    [self.cameraView cl_startCameraViewAnimation];
}

- (void)cl_stopCaptureSessionRunning {
    
    [self.captureSession stopRunning];
    
    [self.cameraView cl_stopCameraViewAnimation];
}

@end
