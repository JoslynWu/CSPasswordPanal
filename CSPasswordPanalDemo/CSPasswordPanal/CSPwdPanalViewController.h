//
//  CSPwdPanalViewController.h
//  CSPasswordPanal
//
//  Created by Joslyn Wu on 20/03/2017.
//  Copyright © 2017 joslyn. All rights reserved.
//

#import "ViewController.h"

@interface CSPwdPanalViewController : ViewController

+ (void)showPasswordPanalWithEntry:(UIViewController *)entyVc confirmComplete:(void(^)(UIButton *confirmBtn, NSString *pwd))confirmBlock forgetPwdBlock:(void(^)())forgetPwdBlock;


@end

