//
//  CSPwdPanalViewController.h
//  CSPasswordPanal
//
//  Copyright © 2017 joslyn. All rights reserved.
//
//  https://github.com/JoslynWu/CSPasswordPanal.git
//

#import <UIKit/UIKit.h>

@interface CSPwdPanalViewController : UIViewController

/**
 一个优美而方便的密码验证的面板。 调用这一个接口即可。
 
 Example:
 
    使用默认配置：
    [CSPwdPanalViewController showPwdPanalWithEntry:self config:nil confirmComplete:^(NSString *pwd) {
        NSLog(@"-->%@",pwd);
    } forgetPwdBlock:^{
        NSLog(@"-->Do find back password logic.");
    }];
 
    自定义配置：
    [CSPwdPanalViewController showPwdPanalWithEntry:self config:^(CSPwdPanalViewController *panal) {
        // Config this password panal
        panal.pwdNumCount = 5;
    } confirmComplete:^(NSString *pwd) {
        NSLog(@"-->%@",pwd);
    } forgetPwdBlock:^{
        NSLog(@"-->Do find back password logic.");
    }];

 @param entyVc 入口的控制器。 一般传 self
 @param panal password面板的实例，用来配置属性
 @param confirmBlock 确认密码时的回调
 @param forgetPwdBlock 忘记密码的回调
 */
+ (void)showPwdPanalWithEntry:(UIViewController *)entyVc config:(void(^)(CSPwdPanalViewController *panal))panal confirmComplete:(void(^)(NSString *pwd))confirmBlock forgetPwdBlock:(void(^)())forgetPwdBlock;


// config 接口
@property (nonatomic, strong) NSString *panalTitle;     // 面板title。默认文字“密码验证”
@property (nonatomic, assign) NSInteger pwdNumCount;    // 密码总位数。默认为6。
@property (nonatomic, strong) UIColor *activeColor;     // 提交按钮激活时的颜色。默认#12c286
@property (nonatomic, strong) UIColor *normolColor;     // 提交按钮未激活时的颜色。默认#909090

@end

