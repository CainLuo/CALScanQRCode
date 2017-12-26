//
//  CLScanQRCodeCameraView.m
//  CLScanQRCode
//
//  Created by Cain on 5/2/16.
//  Copyright © 2016 Cain. All rights reserved.
//

#import "CLScanQRCodeCameraView.h"

#define CALScreenWidth          (CGRectGetWidth([[UIScreen mainScreen] bounds]))
#define CALScreenHeight         (CGRectGetHeight([[UIScreen mainScreen] bounds]))

#define CALStatusBarHeight      (20.0f)
#define CALNavigationBarHeight  (44.0f)
#define CALGetMethodReturnObjc(objc) if (objc) return objc

#define CAL_TOP_VIEW_HEIGHT (self.frame.size.height - self.cl_scanQRCodePickBackgroundImageView.frame.size.height - CALNavigationBarHeight - CALStatusBarHeight) / 2)
#define CAL_BOTTOM_VIEW_HEIGHT self.frame.size.height - CGRectGetMaxY(self.cl_scanQRCodePickBackgroundImageView.frame))

#define MARGIN_VIEWS_COLOR [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4]

@interface CLScanQRCodeCameraView()

@property (nonatomic, strong) UILabel          *tipsLabel;
//@property (nonatomic, strong) UIImageView      *lineImageView;
@property (nonatomic, strong) UIImageView      *cl_scanQRCodePickBackgroundImageView;
@property (nonatomic, strong) CABasicAnimation *lineImageViewAnimation;

@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIView *leftView;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UIView *rightView;

@end

@implementation CLScanQRCodeCameraView

- (instancetype)init {
    
    if (self = [super init]) {
        
        self.frame = CGRectMake(0,
                                CALNavigationBarHeight + CALStatusBarHeight,
                                CALScreenWidth,
                                CALScreenHeight - CALStatusBarHeight - CALNavigationBarHeight);
                
        [self addSubview:self.cl_scanQRCodePickBackgroundImageView];
        [self addSubview:self.tipsLabel];
        [self addSubview:self.topView];
        [self addSubview:self.leftView];
        [self addSubview:self.bottomView];
        [self addSubview:self.rightView];
        
//        [self.cl_scanQRCodePickBackgroundImageView addSubview:self.lineImageView];

        [self cl_startCameraViewAnimation];
    }
    
    return self;
}

#pragma mark - Set ScanQRCode Pick Background Image View
- (UIImageView *)cl_scanQRCodePickBackgroundImageView {
    
    CALGetMethodReturnObjc(_cl_scanQRCodePickBackgroundImageView);
    
    _cl_scanQRCodePickBackgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"CALScanQRCode.bundle/scan_pick_bg"]];
    
    _cl_scanQRCodePickBackgroundImageView.frame = CGRectMake(self.center.x - ((CALScreenWidth - 80) / 2),
                                                             self.center.y / 3.5,
                                                             CALScreenWidth - 80,
                                                             CALScreenWidth - 80);
    
    return _cl_scanQRCodePickBackgroundImageView;
}

#pragma mark - Set ScanQRCode Tips Label Text
- (UILabel *)tipsLabel {
    
    CALGetMethodReturnObjc(_tipsLabel);
    
    _tipsLabel               = [[UILabel alloc] initWithFrame:CGRectMake(0,
                                                                         CGRectGetMinY(self.bottomView.frame) + 30,
                                                                         CALScreenWidth,
                                                                         30)];
    _tipsLabel.text          = @"业务二维码、充值卡条形码";
    _tipsLabel.textAlignment = NSTextAlignmentCenter;
    _tipsLabel.textColor     = [UIColor whiteColor];
    _tipsLabel.font          = [UIFont systemFontOfSize:14];
    
    return _tipsLabel;
}

#pragma mark - Set ScanQRCode Line Image View
//- (UIImageView *)lineImageView {
//
//    CALGetMethodReturnObjc(_lineImageView);
//
//    _lineImageView       = [[UIImageView alloc] initWithFrame:CGRectMake(0,
//                                                                         0,
//                                                                         CGRectGetWidth(self.cl_scanQRCodePickBackgroundImageView.frame),
//                                                                         4)];
//    _lineImageView.image = [UIImage imageNamed:@"CALScanQRCode.bundle/scan_line"];
//
//    CABasicAnimation *lineImageViewAnimation = [CABasicAnimation animation];
//
//    lineImageViewAnimation.keyPath             = @"position";
//    lineImageViewAnimation.duration            = 1.5;
//    lineImageViewAnimation.fillMode            = kCAMediaTimingFunctionEaseInEaseOut;
//    lineImageViewAnimation.removedOnCompletion = NO;
//    lineImageViewAnimation.repeatCount         = MAXFLOAT;
//    lineImageViewAnimation.toValue             = [NSValue valueWithCGPoint:self.cl_scanQRCodePickBackgroundImageView.center];
//
//    [_lineImageView.layer addAnimation:lineImageViewAnimation
//                                forKey:@"LineImageViewAnimation"];
//
//    return _lineImageView;
//}

#pragma mark - Set Margin Views
- (UIView *)topView {

    CALGetMethodReturnObjc(_topView);
    
    _topView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                        0,
                                                        CALScreenWidth,
                                                        CGRectGetMinY(self.cl_scanQRCodePickBackgroundImageView.frame))];
    _topView.backgroundColor = MARGIN_VIEWS_COLOR;
    
    return _topView;
}

- (UIView *)leftView {
    
    CALGetMethodReturnObjc(_leftView);
    
    _leftView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                         CGRectGetMinY(self.cl_scanQRCodePickBackgroundImageView.frame),
                                                         CGRectGetMinX(self.cl_scanQRCodePickBackgroundImageView.frame),
                                                         CALScreenWidth - 80)];
    
    _leftView.backgroundColor = MARGIN_VIEWS_COLOR;
    
    return _leftView;
}

- (UIView *)bottomView {
    
    CALGetMethodReturnObjc(_bottomView);
    
    _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                           CGRectGetMaxY(self.cl_scanQRCodePickBackgroundImageView.frame),
                                                           CALScreenWidth,
                                                           CAL_BOTTOM_VIEW_HEIGHT];
    _bottomView.backgroundColor = MARGIN_VIEWS_COLOR;
    
    return _bottomView;
}

- (UIView *)rightView {

    CALGetMethodReturnObjc(_rightView);
    
    _rightView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.cl_scanQRCodePickBackgroundImageView.frame),
                                                          CGRectGetMinY(self.cl_scanQRCodePickBackgroundImageView.frame),
                                                          CGRectGetMinX(self.cl_scanQRCodePickBackgroundImageView.frame),
                                                          CALScreenWidth - 80)];
    
    _rightView.backgroundColor = MARGIN_VIEWS_COLOR;

    return _rightView;
}

#pragma mark - Set Tips Label Text
- (void)setTipsLabelText:(NSString *)tipsLabelText {
    
    self.tipsLabel.text = tipsLabelText;
}

#pragma mark - Set ScanQRCode Line Image
- (void)setScanQRCodeLineImage:(UIImage *)scanQRCodeLineImage {
    
//    self.lineImageView.image = scanQRCodeLineImage;
}

#pragma mark - Set ScanQRCode ScanQRCode Pick Background Image
- (void)setScanQRCodePickBackgroundImage:(UIImage *)scanQRCodePickBackgroundImage {
    
    self.cl_scanQRCodePickBackgroundImageView.image = scanQRCodePickBackgroundImage;
}

#pragma mark - Set ScanQRCode Line Animation
- (void)cl_startCameraViewAnimation {
    
//    self.lineImageView.hidden = NO;
}

#pragma mark - Stop Line Animtaion
- (void)cl_stopCameraViewAnimation {
    
//    self.lineImageView.hidden = YES;
}
                                                           
@end
