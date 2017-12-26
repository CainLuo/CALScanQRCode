//
//  CLScanQRCodeController.h
//  CLScanQRCode
//
//  Created by Cain on 5/2/16.
//  Copyright © 2016 Cain. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CLScanQRCodeCameraView.h"

@interface CLScanQRCodeController : UIViewController

/**
 * If You Need String Value, You Can Copy Code
 *
 * AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
 * NSString *stringValue = metadataObject.stringValue;
 */
@property (nonatomic, copy) void(^cl_scanQRCodeGetMetadataObjectsBlock)(NSArray *metadataObjects);

@property (nonatomic, copy) void(^cl_scanQRCodeGetMetadataStringValue)(NSString *metadataObject);

@property (nonatomic, strong, readonly) CLScanQRCodeCameraView *cameraView;

- (void)cl_startCaptureSessionRunning;
- (void)cl_stopCaptureSessionRunning;

@end
