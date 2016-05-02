//
//  CALScanQRCodeCameraView.m
//  CALScanQRCode
//
//  Created by Cain on 5/2/16.
//  Copyright © 2016 Cain. All rights reserved.
//

#import "CALScanQRCodeCameraView.h"

#define CALScreenWidth          (CGRectGetWidth([[UIScreen mainScreen] bounds]))
#define CALScreenHeight         (CGRectGetHeight([[UIScreen mainScreen] bounds]))

#define CALStatusBarHeight      (20.0f)
#define CALNavigationBarHeight  (44.0f)
#define CALGetMethodReturnObjc(objc) if (objc) return objc

@interface CALScanQRCodeCameraView()

@property (nonatomic, strong) UILabel          *tipsLabel;
@property (nonatomic, strong) UIImageView      *lineImageView;
@property (nonatomic, strong) UIImageView      *scanQRCodePickBackgroundImageView;
@property (nonatomic, strong) CABasicAnimation *lineImageViewAnimation;

@end

@implementation CALScanQRCodeCameraView

- (instancetype)init {
    
    if (self = [super init]) {
        
        self.frame = CGRectMake(0, CALNavigationBarHeight + CALStatusBarHeight, CALScreenWidth, CALScreenHeight - CALStatusBarHeight - CALNavigationBarHeight);
        
        self.backgroundColor = [UIColor blackColor];
        
        [self addSubview:self.scanQRCodePickBackgroundImageView];
        [self addSubview:self.tipsLabel];
        [self addSubview:self.lineImageView];
        
        [self startAnimation];
    }
    
    return self;
}

#pragma mark - Set ScanQRCode Pick Background Image View
- (UIImageView *)scanQRCodePickBackgroundImageView {
    
    CALGetMethodReturnObjc(_scanQRCodePickBackgroundImageView);
    
    _scanQRCodePickBackgroundImageView       = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"CALScanQRCode.bundle/scan_pick_bg"]];
    _scanQRCodePickBackgroundImageView.frame = CGRectMake(self.center.x / 4, self.center.y * 3.5, CALScreenWidth - 80, CALScreenWidth - 80);
    
    return _scanQRCodePickBackgroundImageView;
}

#pragma mark - Set ScanQRCode Tips Label Text
- (UILabel *)tipsLabel {
    
    CALGetMethodReturnObjc(_tipsLabel);
    
    _tipsLabel               = [[UILabel alloc] initWithFrame:CGRectMake(0, self.center.y * 3.5 + self.scanQRCodePickBackgroundImageView.frame.size.height + 30, CALScreenWidth, 30)];
    _tipsLabel.text          = @"业务二维码、充值卡条形码";
    _tipsLabel.textAlignment = NSTextAlignmentCenter;
    _tipsLabel.textColor     = [UIColor whiteColor];
    _tipsLabel.font          = [UIFont systemFontOfSize:14];
    
    return _tipsLabel;
}

#pragma mark - Set ScanQRCode Line Image View
- (UIImageView *)lineImageView {
    
    CALGetMethodReturnObjc(_lineImageView);
    
    _lineImageView       = [[UIImageView alloc] initWithFrame:CGRectMake(50, self.center.y * 3.5, CALScreenWidth - 100, 4)];
    _lineImageView.image = [UIImage imageNamed:@"CALScanQRCode.bundle/scan_line"];
    
    [self.scanQRCodePickBackgroundImageView addSubview:_lineImageView];
    
    return _lineImageView;
}

#pragma mark - Set Tips Label Text
- (void)setTipsLabelText:(NSString *)tipsLabelText {
    
    self.tipsLabel.text = tipsLabelText;
}

#pragma mark - Set ScanQRCode Line Image
- (void)setScanQRCodeLineImage:(UIImage *)scanQRCodeLineImage {
    
    self.lineImageView.image = scanQRCodeLineImage;
}

#pragma mark - Set ScanQRCode ScanQRCode Pick Background Image
- (void)setScanQRCodePickBackgroundImage:(UIImage *)scanQRCodePickBackgroundImage {
    
    self.scanQRCodePickBackgroundImageView.image = scanQRCodePickBackgroundImage;
}


#pragma mark - Set ScanQRCode Line Animation
- (void)startAnimation {
    
    CABasicAnimation *lineImageViewAnimation = [CABasicAnimation animation];
    
    lineImageViewAnimation.keyPath             = @"position";
    lineImageViewAnimation.duration            = 1.5;
    lineImageViewAnimation.fillMode            = kCAMediaTimingFunctionEaseInEaseOut;
    lineImageViewAnimation.removedOnCompletion = NO;
    lineImageViewAnimation.delegate            = self;
    lineImageViewAnimation.repeatCount         = MAXFLOAT;
    lineImageViewAnimation.toValue             = [NSValue valueWithCGPoint:CGPointMake(_lineImageView.center.x,
                                                                                       _scanQRCodePickBackgroundImageView.frame.origin.y + _scanQRCodePickBackgroundImageView.frame.size.height - 2)];
    
    [self.lineImageView.layer addAnimation:lineImageViewAnimation forKey:@"LineImageViewAnimation"];
}

#pragma mark - Stop Line Animtaion
- (void)stopAnimation {
    
    [self.lineImageView.layer removeAnimationForKey:@"LineImageViewAnimation"];
    self.lineImageView.hidden = true;
}

@end
