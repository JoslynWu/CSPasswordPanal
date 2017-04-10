# CSPasswordPanal-OC
一个优美而方便的密码验证面板。有忘记密码功能。可配置密码位数，已经做好屏幕适配。
本版本为[Objective-C版](https://github.com/JoslynWu/CSPasswordPanal.git)。

## Swift版入口：[CSPasswordPanal-Swift](https://github.com/JoslynWu/CSPasswordPanal-Swift.git)

## 效果图
![](/Screenshot/CSPasswordPanal.png)

## 怎么接入
直接将下面文件（在CSPasswordPanal文件夹中）添加（拖入）项目中

```
CSPwdPanalViewController.h
CSPwdPanalViewController.m
```

## 怎么用
调用一个类方法即可

```
+ (void)showPwdPanalWithEntry:(UIViewController *)entyVc config:(void(^)(CSPwdPanalViewController *panal))panal confirmComplete:(void(^)(NSString *pwd))confirmBlock forgetPwdBlock:(void(^)())forgetPwdBlock;
```

**Example:**

```
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
```


## 哪些属性可配置

```
@property (nonatomic, strong) NSString *panalTitle;     // 面板title。默认文字“密码验证”
@property (nonatomic, assign) NSInteger pwdNumCount;    // 密码总位数。默认为6。
@property (nonatomic, strong) UIColor *activeColor;     // 提交按钮激活时的颜色。默认#909090
@property (nonatomic, strong) UIColor *normolColor;     // 提交按钮未激活时的颜色。默认#12c286
```




