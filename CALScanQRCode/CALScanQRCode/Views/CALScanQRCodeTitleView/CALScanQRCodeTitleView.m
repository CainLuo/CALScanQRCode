//
//  CALScanQRCodeTitleView.m
//  ScanQRDemo
//
//  Created by Cain on 4/13/16.
//  Copyright © 2016 Cain. All rights reserved.
//

#import "CALScanQRCodeTitleView.h"

#define CALScreenWidth          (CGRectGetWidth([[UIScreen mainScreen] bounds]))
#define CALScreenHeight         (CGRectGetHeight([[UIScreen mainScreen] bounds]))

#define CALStatusBarHeight      (20.0f)
#define CALNavigationBarHeight  (44.0f)
#define CALGetMethodReturnObjc(objc) if (objc) return objc

#define CALWebSrcName(file)          [@"CALScanQRCode.bundle" stringByAppendingPathComponent:file]
#define CALWebFrameworkSrcName(file) [@"Frameworks/CALScanQRCode.framework/CALScanQRCode.bundle" stringByAppendingPathComponent:file]

@interface CALScanQRCodeTitleView()

@property (nonatomic, strong) UILabel  *scanQRCodeTitleLabel;
@property (nonatomic, strong) UIButton *backButton;

@end

@implementation CALScanQRCodeTitleView

- (instancetype)init {
    
    if (self = [super init]) {
        
        self.frame = CGRectMake(0, 0, CALScreenWidth, CALStatusBarHeight + CALNavigationBarHeight);
        self.layer.zPosition = INT_MAX;
        self.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:self.scanQRCodeTitleLabel];
        [self addSubview:self.backButton];
    }
    
    return self;
}

#pragma mark - Set Title String
- (UILabel *)scanQRCodeTitleLabel {
    
    CALGetMethodReturnObjc(_scanQRCodeTitleLabel);
    
    _scanQRCodeTitleLabel                 = [[UILabel alloc] initWithFrame:CGRectMake(self.backButton.frame.size.width, CALStatusBarHeight, CALScreenWidth - (self.backButton.frame.size.width * 2), CALNavigationBarHeight)];
    _scanQRCodeTitleLabel.text            = @"扫一扫";
    _scanQRCodeTitleLabel.textAlignment   = NSTextAlignmentCenter;
    _scanQRCodeTitleLabel.font            = [UIFont systemFontOfSize:18];
    
    return _scanQRCodeTitleLabel;
}

#pragma mark - Set Back Button
- (UIButton *)backButton {
    
    CALGetMethodReturnObjc(_backButton);
    
    _backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, CALStatusBarHeight, 40, CALNavigationBarHeight)];
    
    [_backButton setImage:[UIImage imageNamed:@"CALScanQRCode.bundle/black_Button_Image"] forState:UIControlStateNormal];
    [_backButton addTarget:self action:@selector(backButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    return _backButton;
}

#pragma mark - Set Back Button Action
- (void)backButtonAction:(UIButton *)sender {
    
    self.CALScanQRCodeTitleViewBackButtonBlock(sender);
}

#pragma mark - Set Self BackgroundColor
- (void)setTitleViewBackgroundColor:(UIColor *)titleViewBackgroundColor {
    
    self.backgroundColor = titleViewBackgroundColor;
}

#pragma mark - Set Back Button Image
- (void)setBackButtonImage:(UIImage *)backButtonImage {
    
    [self.backButton setImage:backButtonImage forState:UIControlStateNormal];
}

#pragma mark - Set Scan QRCode Title Label Text Color
- (void)setScanQRCodeTitleColor:(UIColor *)scanQRCodeTitleColor {
    
    self.scanQRCodeTitleLabel.textColor = scanQRCodeTitleColor;
}

#pragma mark - Set Scan QRCode Title
- (void)setScanQRCodeTitle:(NSString *)scanQRCodeTitle {
    
    self.scanQRCodeTitleLabel.text = scanQRCodeTitle;
}

@end
