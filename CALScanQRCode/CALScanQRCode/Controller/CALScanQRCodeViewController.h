//
//  CALScanQRCodeViewController.h
//  CALScanQRCode
//
//  Created by Cain on 5/2/16.
//  Copyright © 2016 Cain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CALScanQRCodeViewController : UIViewController

/**
 * If You Need String Value, You Can Copy Code
 *
 * AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
 * NSString *stringValue = metadataObject.stringValue;
 */
@property (nonatomic, copy) void(^CALScanQRCodeGetMetadataObjectsBlock)(NSArray *metadataObjects);

@property (nonatomic, copy) void(^CALScanQRCodeGetMetadataStringValue)(NSString *metadataObject);

@end
