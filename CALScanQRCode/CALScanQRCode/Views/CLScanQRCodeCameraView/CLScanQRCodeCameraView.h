//
//  CLScanQRCodeCameraView.h
//  CLScanQRCode
//
//  Created by Cain on 5/2/16.
//  Copyright © 2016 Cain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CLScanQRCodeCameraView : UIView

@property (nonatomic, strong) UIImage *scanQRCodePickBackgroundImage;
@property (nonatomic, strong) UIImage *scanQRCodeLineImage;

@property (nonatomic, copy) NSString *tipsLabelText;

- (void)cl_stopCameraViewAnimation;
- (void)cl_startCameraViewAnimation;

@end
