//
//  ViewController.m
//  CSPasswordPanal
//
//  Created by Joslyn Wu on 2017/3/25.
//  Copyright © 2017年 joslyn. All rights reserved.
//

#import "ViewController.h"
#import "CSPwdPanalViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)passwordPanalBtnDidClick:(UIButton *)sender {
    
    [CSPwdPanalViewController showPwdPanalWithEntry:self config:^(CSPwdPanalViewController *panal) {
        // Config this password panal
    } confirmComplete:^(NSString *pwd) {
        NSLog(@"-->%@",pwd);
    } forgetPwdBlock:^{
        NSLog(@"-->Do find back password logic.");
    }];
    
}




@end
