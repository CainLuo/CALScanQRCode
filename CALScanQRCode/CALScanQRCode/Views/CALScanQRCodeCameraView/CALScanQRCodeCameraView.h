//
//  CALScanQRCodeCameraView.h
//  CALScanQRCode
//
//  Created by Cain on 5/2/16.
//  Copyright © 2016 Cain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CALScanQRCodeCameraView : UIView

@property (nonatomic, strong) UIImage *scanQRCodePickBackgroundImage;
@property (nonatomic, strong) UIImage *scanQRCodeLineImage;

@property (nonatomic, copy) NSString *tipsLabelText;

- (void)stopAnimation;

@end
