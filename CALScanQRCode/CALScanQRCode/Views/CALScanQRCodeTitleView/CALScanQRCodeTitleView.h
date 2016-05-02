//
//  CALScanQRCodeTitleView.h
//  CALScanQRCode
//
//  Created by Cain on 5/2/16.
//  Copyright © 2016 Cain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CALScanQRCodeTitleView : UIView

@property (nonatomic, strong) NSString *scanQRCodeTitle;
@property (nonatomic, strong) UIColor  *scanQRCodeTitleColor;
@property (nonatomic, strong) UIColor  *titleViewBackgroundColor;
@property (nonatomic, strong) UIImage  *backButtonImage;

@property (nonatomic, copy) void(^CALScanQRCodeTitleViewBackButtonBlock)(UIButton *backButton);

@end
