//
//  TLGuidePageManager.h
//  GuidePageExample
//
//  Created by lujh on 2018/5/16.
//  Copyright © 2018年 TaiKang. All rights reserved.
//  qq:287929070

#import <Foundation/Foundation.h>
@protocol GuidePageDelegate <NSObject>

- (void)newFeatureDidLoadFinished;

@end

@interface GuidePageManager : NSObject

+ (void)shareManagerWithDelegate:(id<GuidePageDelegate>)delegate imageArray:(NSArray *)imageArray startBtnFrame:(CGRect)startBtnFrame;
@end
