//
//  CSPwdPanalViewController.h
//  CSPasswordPanal
//
//  Created by Joslyn Wu on 20/03/2017.
//  Copyright © 2017 joslyn. All rights reserved.
//

#import "ViewController.h"

@interface CSPwdPanalViewController : ViewController


+ (void)showPwdPanalWithEntry:(UIViewController *)entyVc config:(void(^)(CSPwdPanalViewController *panal))panal confirmComplete:(void(^)(NSString *pwd))confirmBlock forgetPwdBlock:(void(^)())forgetPwdBlock;


//
@property (nonatomic, assign) NSInteger pwdNumCount;    // 密码总位数。默认为6。
@property (nonatomic, strong) UIColor *activeColor;     // 提交按钮激活时的颜色。
@property (nonatomic, strong) UIColor *normolColor;     // 提交按钮未激活时的颜色。

@end

