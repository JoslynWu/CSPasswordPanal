//
//  UIColor+Hex.h
//  ZAInsurance
//
//  Created by Joe on 15/6/15.
//  Copyright (c) 2015年 ZhongAn Insurance. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Hex)

+ (UIColor *)colorWithHexString:(NSString *)string;

+ (UIColor *)colorWithHexString:(NSString *)string alpha:(CGFloat)alpha;

+ (UIColor *)colorWithGrayScale:(NSInteger)grayScale;

@end
