//
//  UIColor+Hex.m
//  ZAInsurance
//
//  Created by Joe on 15/6/15.
//  Copyright (c) 2015年 ZhongAn Insurance. All rights reserved.
//

#import "UIColor+Hex.h"

@implementation UIColor (Hex)

+ (NSUInteger)integerValueFromHexString:(NSString *)hex
{
    int result = 0;
    sscanf([hex UTF8String], "%x", &result);
    return result;
}

+ (UIColor *)colorWithHexString:(NSString *)hex
{
    return [UIColor colorWithHexString:hex alpha:1.0];
}

+ (UIColor *)colorWithHexString:(NSString *)hex alpha:(CGFloat)alpha
{
    hex = [hex stringByReplacingOccurrencesOfString:@"#" withString:@""];
    if ([hex length]!=6 && [hex length]!=3)
    {
        return nil;
    }
    
    NSUInteger digits = [hex length]/3;
    CGFloat maxValue = (digits==1)?15.0:255.0;
    
    CGFloat red = [self integerValueFromHexString:[hex substringWithRange:NSMakeRange(0, digits)]]/maxValue;
    CGFloat green = [self integerValueFromHexString:[hex substringWithRange:NSMakeRange(digits, digits)]]/maxValue;
    CGFloat blue = [self integerValueFromHexString:[hex substringWithRange:NSMakeRange(2*digits, digits)]]/maxValue;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

+ (UIColor *)colorWithGrayScale:(NSInteger)grayScale
{
    return [UIColor colorWithRed:grayScale/255.0f green:grayScale/255.0f blue:grayScale/255.0f alpha:1];
}

@end
