//
//  TLGuidePageCell.h
//  GuidePageExample
//
//  Created by lujh on 2018/5/16.
//  Copyright © 2018年 TaiKang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GuidePageCell : UICollectionViewCell
// imageview
@property (nonatomic, strong) UIImageView *imageview;
// 开始体验按钮
@property (nonatomic,strong) UIButton *experienceBtn;
/** 引导图片image */
@property (nonatomic, strong) UIImage *image;
/** 体验按钮frame */
@property (nonatomic,assign) CGRect startBtnFrame;
/** 是否显示体验背景颜色 */
@property (nonatomic,assign) BOOL isShowBtnBackgroundColor;
// 判断是否是最后一页
- (void)setIndexPath:(NSIndexPath *)indexPath count:(NSUInteger)count;
@end
