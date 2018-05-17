//
//  TLGuidePageViewController.h
//  GuidePageExample
//
//  Created by lujh on 2018/5/16.
//  Copyright © 2018年 TaiKang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GuidePageViewController : UICollectionViewController
/** 引导图片数组 */
@property (nonatomic,strong) NSArray *imageArray;
/** 开始体验按钮frame */
@property (nonatomic,assign) CGRect startBtnFrame;
/** 是否显示体验背景颜色 */
@property (nonatomic,assign) BOOL isShowBtnBackgroundColor;
- (instancetype)initWithImageArray:(NSArray *)imageArray startBtnFrame:(CGRect)startBtnFrame isShowBtnBackgroundColor:(BOOL)isShowBtnBackgroundColor;
@end
