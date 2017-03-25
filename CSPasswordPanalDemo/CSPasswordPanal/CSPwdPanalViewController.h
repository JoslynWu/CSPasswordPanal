//
//  CSPwdPanalViewController.h
//  CSPasswordPanal
//
//  Created by Joslyn Wu on 20/03/2017.
//  Copyright © 2017 joslyn. All rights reserved.
//

#import "ViewController.h"

@interface CSPwdPanalViewController : ViewController

// 方式一：直接用这个入口即可
+ (void)showPasswordPanalWithEntry:(UIViewController *)entyVc confirmComplete:(void(^)(NSString *pwd))confirmBlock forgetPwdBlock:(void(^)())forgetPwdBlock;


// 方式二：自己创建实例，然后模态。以下为回调支持
@property (nonatomic, copy) void(^confirmBlock)(NSString *);
@property (nonatomic, copy) void(^forgetPwdBlock)();

@end
