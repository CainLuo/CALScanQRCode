//
//  ViewController.m
//  CALScanQRCode
//
//  Created by Cain on 5/2/16.
//  Copyright © 2016 Cain. All rights reserved.
//

#import "CALScanQRCodeExampleViewController.h"

@interface CALScanQRCodeExampleViewController ()

@end

@implementation CALScanQRCodeExampleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setCALScanQRCodeGetMetadataStringValue:^(NSString *stringValue) {
        
        NSLog(@"Scan Straing Value = %@", stringValue);
    }];
    
    [self setCALScanQRCodeGetMetadataObjectsBlock:^(NSArray *array) {
       
        NSLog(@"Scan array = %@", array);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
