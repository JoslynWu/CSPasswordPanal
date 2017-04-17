//
//  ViewController.m
//  CSPasswordPanalDemo
//
//  Created by Joslyn Wu on 09/04/2017.
//  Copyright © 2017 joslyn. All rights reserved.
//

#import "ViewController.h"
#import "CSPasswordPanal.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)passwordPanalBtnDidClick:(UIButton *)sender {
    
    [CSPasswordPanal showPwdPanalWithEntry:self config:^(CSPasswordPanal *panal) {
        // Config this password panal
    } confirmComplete:^(NSString *pwd) {
        NSLog(@"-->%@",pwd);
    } forgetPwdBlock:^{
        NSLog(@"-->Do find back password logic.");
    }];
    
}

@end
