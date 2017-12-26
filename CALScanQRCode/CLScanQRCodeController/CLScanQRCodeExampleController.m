//
//  CLScanQRCodeExampleController.m
//  CALScanQRCode
//
//  Created by Cain on 5/2/16.
//  Copyright © 2016 Cain. All rights reserved.
//

#import "CLScanQRCodeExampleController.h"
#import "CLScanQRCodeSourceController.h"

#define CLWeakSelf(weakSelf) __weak __typeof(&*self)weakSelf = self

@interface CLScanQRCodeExampleController ()

@end

@implementation CLScanQRCodeExampleController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self cl_startCaptureSessionRunning];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"扫码";
    
    self.cameraView.tipsLabelText = @"开始扫描";
    
    CLWeakSelf(weakSelf);
    
    [self setCl_scanQRCodeGetMetadataStringValue:^(NSString *stringValue) {
        
        if (stringValue.length) {
            
            CLScanQRCodeSourceController *cl_scanQRCodeSourceController = [[CLScanQRCodeSourceController alloc] init];
            
            cl_scanQRCodeSourceController.sourceString = stringValue;
            
            [weakSelf.navigationController pushViewController:cl_scanQRCodeSourceController
                                                 animated:YES];
        }
    }];
}

@end
