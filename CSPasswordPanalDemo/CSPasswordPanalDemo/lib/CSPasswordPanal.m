//
//  CSPasswordPanal.m
//  CSPasswordPanal
//
//  Created by Joslyn Wu on 20/03/2017.
//  Copyright © 2017 joslyn. All rights reserved.
//

#import "CSPasswordPanal.h"

static const NSInteger pwdNumCountDefault = 6;
static const CGFloat pwdTextField_w = 238;
static const CGFloat pwdTextField_h = 44;
static const CGFloat passwordPanalMaxY = 391;

@interface CSPasswordPanal ()

@property (nonatomic, strong) UITextField *pwdTextField;
@property (nonatomic, strong) NSMutableArray *pwdViews;
@property (nonatomic, strong) NSString *pwdString;
@property (nonatomic, strong) UIButton *confirmBtn;
@property (nonatomic, strong) UIView *panalView;

@property (nonatomic, copy) void(^confirmBlock)(NSString *pwd);
@property (nonatomic, copy) void(^forgetPwdBlock)();

@end

@implementation CSPasswordPanal

#pragma mark  -  public
+ (void)showPwdPanalWithEntry:(UIViewController *)entyVc config:(void(^)(CSPasswordPanal *panal))panalBlock confirmComplete:(void(^)(NSString *pwd))confirmBlock forgetPwdBlock:(void(^)())forgetPwdBlock {
    CSPasswordPanal *panal = [CSPasswordPanal new];
    panal.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    
    panal.confirmBlock = confirmBlock;
    panal.forgetPwdBlock = forgetPwdBlock;
    if(panalBlock){ panalBlock(panal); }
    
    [entyVc presentViewController:panal animated:NO completion:nil];
}

#pragma mark  -  lifecycle
-(void)dealloc{
    self.pwdTextField.delegate = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNotification];
    [self defaultConfig];
    [self initUI];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyBoard)];
    tap.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap];
}

- (void)defaultConfig {
    self.pwdNumCount = (self.pwdNumCount ? self.pwdNumCount : pwdNumCountDefault);
    self.pwdString = @"";
    self.panalTitle = (self.panalTitle.length > 0 ? self.panalTitle : @"密码验证");
}

- (void)initUI {
    self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    
    CGFloat screen_w = [UIScreen mainScreen].bounds.size.width;
    
    CGFloat panalView_w = 270;
    CGFloat panalView_h = 220;
    CGFloat panalView_x = (screen_w - panalView_w) * 0.5;
    CGFloat panalView_y = passwordPanalMaxY - panalView_h;
    UIView *panalView = [[UIView alloc] initWithFrame:CGRectMake(panalView_x, panalView_y, panalView_w, panalView_h)];
    panalView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.9];
    panalView.layer.cornerRadius = 13;
    panalView.clipsToBounds = YES;
    self.panalView = panalView;
    [self.view addSubview:panalView];
    
    CGFloat titleLabel_w = 120;
    CGFloat titleLabel_h = 24;
    CGFloat titleLabel_x = (panalView_w - titleLabel_w) * 0.5;
    CGFloat titleLabel_y = 17.5;
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(titleLabel_x, titleLabel_y, titleLabel_w, titleLabel_h)];
    titleLabel.text = self.panalTitle;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont boldSystemFontOfSize:17];
    titleLabel.textColor = [UIColor colorWithRed:(70)/255.0f green:(70)/255.0f blue:(70)/255.0f alpha:1];
    [panalView addSubview:titleLabel];
    
    CGFloat cancelBtn_w_h = 24;
    CGFloat cancelBtn_right = 19.5;
    CGFloat cancelBtn_x = panalView_w - cancelBtn_right - cancelBtn_w_h;
    CGFloat cancelBtn_y = titleLabel.center.y - cancelBtn_w_h * 0.5;
    UIButton *cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(cancelBtn_x, cancelBtn_y, cancelBtn_w_h, cancelBtn_w_h)];
    [cancelBtn setImage:[self defaultCancelImage] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(close:) forControlEvents:UIControlEventTouchUpInside];
    [panalView addSubview:cancelBtn];
    
    CGFloat pwdTextField_y = 63;
    CGFloat pwdTextField_x = (panalView_w - pwdTextField_w) * 0.5;
    UITextField *pwdTextField = [[UITextField alloc] initWithFrame:CGRectMake(pwdTextField_x, pwdTextField_y, pwdTextField_w, pwdTextField_h)];
    self.pwdTextField = pwdTextField;
    pwdTextField.backgroundColor = [UIColor whiteColor];
    pwdTextField.layer.borderWidth = 1.f;
    pwdTextField.layer.borderColor = [self colorWithHexString:@"e6e6e6"].CGColor;
    pwdTextField.layer.cornerRadius = 4;
    pwdTextField.clipsToBounds = YES;
    pwdTextField.keyboardType = UIKeyboardTypeNumberPad;
    pwdTextField.tintColor = [UIColor whiteColor];
    [panalView addSubview:pwdTextField];
    [pwdTextField becomeFirstResponder];
    
    CGFloat forgetBtn_w = 56;
    CGFloat forgetBtn_h = 18.5;
    CGFloat forgetBtn_x = panalView_w - pwdTextField_x - forgetBtn_w;
    CGFloat forgetBtn_y = CGRectGetMaxY(pwdTextField.frame) + 10;
    UIButton *forgetBtn = [[UIButton alloc] initWithFrame:CGRectMake(forgetBtn_x, forgetBtn_y, forgetBtn_w, forgetBtn_h)];
    [forgetBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    forgetBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [forgetBtn addTarget:self action:@selector(forgetPwdBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [forgetBtn setTitleColor:[self colorWithHexString:@"909090"] forState:UIControlStateNormal];
    [panalView addSubview:forgetBtn];
    
    CGFloat confirmBtn_w = pwdTextField_w;
    CGFloat confirmBtn_h = pwdTextField_h;
    CGFloat confirmBtn_x = pwdTextField_x;
    CGFloat confirmBtn_y = panalView_h - 20 - confirmBtn_h;
    UIButton *confirmBtn = [[UIButton alloc] initWithFrame:CGRectMake(confirmBtn_x, confirmBtn_y, confirmBtn_w, confirmBtn_h)];
    self.confirmBtn = confirmBtn;
    confirmBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [confirmBtn setTitle:@"确认" forState:UIControlStateNormal];
    [confirmBtn addTarget:self action:@selector(confirmBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    confirmBtn.layer.cornerRadius = 4;
    confirmBtn.clipsToBounds = YES;
    [self setConfirmBtnEnabled:NO];
    [panalView addSubview:self.confirmBtn];
    
    CGFloat gridWidth = pwdTextField_w / self.pwdNumCount;
    for (NSInteger i = 1; i < self.pwdNumCount; i++) {
        CGFloat gridTop = 9;
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(i * gridWidth, gridTop, 1.f, pwdTextField_h - gridTop * 2)];
        lineView.backgroundColor = [self colorWithHexString:@"e6e6e6"];
        [self.pwdTextField addSubview:lineView];
    }
    
}

#pragma mark  -  action
- (void)addNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardChange:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardChange:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldChanged:) name:UITextFieldTextDidChangeNotification object:nil];
}

- (void)addOnePwd {
    CGFloat viewW = 6.f;
    NSInteger count = self.pwdViews.count;
    CGFloat everyWidth = pwdTextField_w / self.pwdNumCount;
    CGFloat left = (everyWidth - viewW) / 2 + count * everyWidth;
    
    UIView *pwdView = [[UIView alloc] initWithFrame:CGRectMake(left, (pwdTextField_h - viewW) * 0.5, viewW, viewW)];
    [self.pwdTextField addSubview:pwdView];
    pwdView.backgroundColor = [self colorWithHexString:@"464646"];
    pwdView.layer.cornerRadius = viewW / 2;
    pwdView.layer.masksToBounds = YES;
    
    [self.pwdViews addObject:pwdView];
    
    NSString *noSpaceText = [self.pwdTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    self.pwdString = [NSString stringWithFormat:@"%@%@", self.pwdString, noSpaceText];
}

- (void)setConfirmBtnEnabled:(BOOL)enabled {
    self.normolColor = (self.normolColor ? self.normolColor : [self colorWithHexString:@"909090"]);
    self.activeColor = (self.activeColor ? self.activeColor : [self colorWithHexString:@"12c286"]);
    self.confirmBtn.backgroundColor = (enabled ? self.activeColor : self.normolColor);
    self.confirmBtn.enabled = enabled;
}

- (UIImage *)defaultCancelImage {
    CGFloat w_h = 12;
    static UIImage *cancelImg = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(w_h, w_h), NO, 0);
        [[UIColor lightGrayColor] setStroke];
        UIBezierPath *bzrPath = [UIBezierPath bezierPath];
        bzrPath.lineWidth = 1;
        [bzrPath moveToPoint:CGPointZero];
        [bzrPath addLineToPoint:CGPointMake(w_h, w_h)];
        [bzrPath moveToPoint:CGPointMake(0, w_h)];
        [bzrPath addLineToPoint:CGPointMake(w_h, 0)];
        [bzrPath stroke];
        cancelImg = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    });
    return cancelImg;
}

#pragma mark  -  listen
- (void)textFieldChanged:(NSNotification *)ntf {
    if ([self.pwdTextField.text isEqualToString:@""]) {
        NSInteger index = self.pwdViews.count - 1;
        if (index >= 0) {
            UIView *pwdView = self.pwdViews[index];
            [pwdView removeFromSuperview];
            [self.pwdViews removeLastObject];
            pwdView = nil;
            
            self.pwdString = [self.pwdString substringToIndex:self.pwdString.length - 1];
        }
    } else {
        if (self.pwdViews.count < self.pwdNumCount) {
            [self addOnePwd];
        }
    }
    
    [self setConfirmBtnEnabled:self.pwdViews.count == self.pwdNumCount];
    self.pwdTextField.text = @" ";
}

- (void)keyboardChange:(NSNotification *)ntf {
    CGFloat centerX = [UIScreen mainScreen].bounds.size.width * 0.5;
    CGFloat centerY = [UIScreen mainScreen].bounds.size.height * 0.5;
    if ([ntf.name isEqualToString:@"UIKeyboardWillHideNotification"]) {
        self.view.layer.position = CGPointMake(centerX, centerY);
        return;
    }
    CGRect kbFrame = [ntf.userInfo[@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
    CGFloat move = kbFrame.origin.y - (passwordPanalMaxY);
    if (move > 0) { return; }
    self.view.layer.position = CGPointMake(centerX, centerY - (-move + 30));
}

- (void)hideKeyBoard {
    [self.view endEditing:YES];
}

- (void)confirmBtnClicked:(UIButton *)sender {
    if (sender.enabled) {
        if (self.confirmBlock) { self.confirmBlock(self.pwdString); }
        [self dismissViewControllerAnimated:NO completion:nil];
    }
}

- (void)forgetPwdBtnClicked:(UIButton *)sender {
    if (self.forgetPwdBlock) {
        self.forgetPwdBlock();
        [self dismissViewControllerAnimated:NO completion:nil];
    }
}

- (void)close:(UIButton *)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
}


#pragma mark  -  UIColor tool
- (NSUInteger)integerValueFromHexString:(NSString *)hex {
    int result = 0;
    sscanf([hex UTF8String], "%x", &result);
    return result;
}

- (UIColor *)colorWithHexString:(NSString *)hex {
    return [self colorWithHexString:hex alpha:1.0];
}

- (UIColor *)colorWithHexString:(NSString *)hex alpha:(CGFloat)alpha {
    hex = [hex stringByReplacingOccurrencesOfString:@"#" withString:@""];
    if ([hex length]!=6 && [hex length]!=3) {
        return nil;
    }
    
    NSUInteger digits = [hex length]/3;
    CGFloat maxValue = (digits==1)?15.0:255.0;
    
    CGFloat red = [self integerValueFromHexString:[hex substringWithRange:NSMakeRange(0, digits)]]/maxValue;
    CGFloat green = [self integerValueFromHexString:[hex substringWithRange:NSMakeRange(digits, digits)]]/maxValue;
    CGFloat blue = [self integerValueFromHexString:[hex substringWithRange:NSMakeRange(2*digits, digits)]]/maxValue;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}


#pragma mark  -  setter / getter
- (NSMutableArray *)pwdViews {
    if (!_pwdViews) {
        _pwdViews = [NSMutableArray array];
    }
    return _pwdViews;
}



@end




