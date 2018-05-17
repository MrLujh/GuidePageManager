//
//  TLGuidePageManager.m
//  GuidePageExample
//
//  Created by lujh on 2018/5/16.
//  Copyright © 2018年 TaiKang. All rights reserved.
//  qq:287929070
//当前版本
#define  App_Version  [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

#import "GuidePageManager.h"
#import "GuidePageViewController.h"
#import "Aspect.h"

@interface GuidePageManager () {
    id<GuidePageDelegate> _delegate;
    NSMutableArray *_picStrArr;
    UIWindow *_window;
    CGRect _startBtnFrame;
}

@end
@implementation GuidePageManager

+ (void)shareManagerWithDelegate:(id<GuidePageDelegate>)delegate imageArray:(NSArray *)imageArray startBtnFrame:(CGRect)startBtnFrame {
    static GuidePageManager *instance = nil;
    static dispatch_once_t oneToken;
    dispatch_once(&oneToken,^{
        instance = [[GuidePageManager alloc] init];
        [instance getDelegate:delegate picStrArr:imageArray startBtnFrame:startBtnFrame];
        [instance setupNewFeature];
    });
}

- (void)getDelegate:(id<GuidePageDelegate>)delegate picStrArr:(NSArray *)picStrArr startBtnFrame:(CGRect)startBtnFrame{
    _delegate = delegate;
    _picStrArr = [NSMutableArray arrayWithArray:picStrArr];
    _startBtnFrame = startBtnFrame;
}

- (void)setupNewFeature {
    if ([[NSUserDefaults standardUserDefaults]boolForKey:[NSString stringWithFormat:@"ISNEWFEATURE%@",App_Version]]) return;
    
    UIWindow *window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    for (int i = 0; i < _picStrArr.count; i++) {
        if ([[_picStrArr objectAtIndex:i] isEqualToString:@""]) {
            [_picStrArr removeObjectAtIndex:i];
        }
    }
    if (_picStrArr.count == 0) return;
    GuidePageViewController *fearure = [[GuidePageViewController alloc] initWithImageArray:_picStrArr startBtnFrame:_startBtnFrame];
    fearure.view.backgroundColor = [UIColor clearColor];
    
    // 捕获ZJNewFeatureCell的start方法
    Class class = NSClassFromString(@"GuidePageCell");
    SEL selector = NSSelectorFromString(@"btnClick");
    [class aspect_hookSelector:selector withOptions:AspectPositionAfter usingBlock: ^( id<AspectInfo> aspects ) {
        // 记录是否已经走过新特性
        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:[NSString stringWithFormat:@"ISNEWFEATURE%@",App_Version]];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        // 新特性Window移除
        [UIView transitionWithView:window duration:0.0 options:UIViewAnimationOptionTransitionNone animations:^{
            window.alpha = 0;
        } completion:^(BOOL finished) {
            [self remove];
        }];
    }  error:NULL];
    
    window.rootViewController = fearure;
    window.windowLevel = UIWindowLevelAlert + 1;
    window.alpha = 1;
    window.hidden = NO;
    _window = window;
}

- (void)remove {
    _window.hidden = YES;
    _window.rootViewController = nil;
    _window = nil;
    
    if (_delegate && [_delegate respondsToSelector:@selector(newFeatureDidLoadFinished)]) {
        [_delegate newFeatureDidLoadFinished];
    }
}

@end
