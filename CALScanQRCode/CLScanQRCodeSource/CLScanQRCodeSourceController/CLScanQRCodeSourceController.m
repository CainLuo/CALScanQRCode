//
//  CLScanQRCodeSourceController.m
//  CALScanQRCode
//
//  Created by Mac on 2017/12/26.
//  Copyright © 2017年 Cain. All rights reserved.
//

#import "CLScanQRCodeSourceController.h"

@interface CLScanQRCodeSourceController ()

@property (nonatomic, strong) UITextView *cl_sourceTextView;

@property (nonatomic, strong) UIButton *cl_oepnURLButton;

@end

@implementation CLScanQRCodeSourceController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"扫码内容";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.cl_sourceTextView];
    [self.view addSubview:self.cl_oepnURLButton];
    
    self.cl_sourceTextView.text = self.sourceString;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches
           withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
}

- (UITextView *)cl_sourceTextView {
    
    if (!_cl_sourceTextView) {
        
        _cl_sourceTextView = [[UITextView alloc] initWithFrame:CGRectMake(0,
                                                                          0,
                                                                          CGRectGetWidth(self.view.frame),
                                                                          300)];
        _cl_sourceTextView.font      = [UIFont systemFontOfSize:20];
        _cl_sourceTextView.textColor = [UIColor blackColor];
    }
    
    return _cl_sourceTextView;
}

- (UIButton *)cl_oepnURLButton {
    
    if (!_cl_oepnURLButton) {
        
        _cl_oepnURLButton = [[UIButton alloc] initWithFrame:CGRectMake(0,
                                                                       CGRectGetMaxY(self.cl_sourceTextView.frame),
                                                                       CGRectGetWidth(self.view.frame),
                                                                       44)];
        
        [_cl_oepnURLButton setTitle:@"打开链接"
                           forState:UIControlStateNormal];
        [_cl_oepnURLButton setTitleColor:[UIColor whiteColor]
                                forState:UIControlStateNormal];
        [_cl_oepnURLButton setTitleColor:[UIColor grayColor]
                                forState:UIControlStateHighlighted];
        [_cl_oepnURLButton setBackgroundColor:[UIColor blueColor]];
        
        [_cl_oepnURLButton addTarget:self
                              action:@selector(cl_openURLButtonAction:)
                    forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _cl_oepnURLButton;
}

- (void)cl_openURLButtonAction:(UIButton *)sender {
    
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:self.cl_sourceTextView.text]]) {
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.cl_sourceTextView.text]];
        
    } else {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示"
                                                                                 message:@"这不是有效的网站地址"
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"好的"
                                                            style:UIAlertActionStyleDefault
                                                          handler:nil]];
        
        [self presentViewController:alertController
                           animated:YES
                         completion:nil];
    }
}

@end
