//
//  TLGuidePageCell.m
//  GuidePageExample
//
//  Created by lujh on 2018/5/16.
//  Copyright © 2018年 TaiKang. All rights reserved.
//

#import "GuidePageCell.h"

@interface GuidePageCell ()

@end

@implementation GuidePageCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        // 初始化SubViews
        [self setupSubViews];
    }
    return self;
}

#pragma mark -初始化SubViews

-(void)setupSubViews{
    
    // imageV
    self.imageview = [[UIImageView alloc] initWithFrame:self.bounds];
    self.imageview.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:self.imageview];
    
    
    self.experienceBtn = [[UIButton alloc] init];
    [self.experienceBtn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.experienceBtn];
}

#pragma mark -image set

- (void)setImage:(UIImage *)image
{
    _image = image;
    
    self.imageview.image = image;
}

#pragma mark -startBtnFrame set

- (void)setStartBtnFrame:(CGRect)startBtnFrame
{
   
    _startBtnFrame = startBtnFrame;
    
    self.experienceBtn.frame = startBtnFrame;
}

#pragma mark -判断当前cell是否是最后一页

- (void)setIndexPath:(NSIndexPath *)indexPath count:(NSUInteger)count
{
    if (indexPath.row == count - 1) {
        
        // 最后一页,显示分享和开始按钮
        self.experienceBtn.hidden = NO;
        
    }else{
        
        // 非最后一页，隐藏分享和开始按钮
        self.experienceBtn.hidden = YES;
    }
}

#pragma mark -立即体验按钮点击事件

- (void)btnClick
{
    
}

@end
