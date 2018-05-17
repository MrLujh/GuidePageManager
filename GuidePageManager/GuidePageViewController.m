//
//  TLGuidePageViewController.m
//  GuidePageExample
//
//  Created by lujh on 2018/5/16.
//  Copyright © 2018年 TaiKang. All rights reserved.
//

#import "GuidePageViewController.h"
#import "GuidePageCell.h"

@implementation GuidePageViewController

static NSString * const reuseIdentifier = @"Cell";

- (instancetype)initWithImageArray:(NSArray *)imageArray startBtnFrame:(CGRect)startBtnFrame
{
    
    _imageArray = imageArray;
    _startBtnFrame = startBtnFrame;
    return  [self init];
}

- (instancetype)init
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    // 设置cell的尺寸
    layout.itemSize = [UIScreen mainScreen].bounds.size;
    // 清空行距
    layout.minimumLineSpacing = 0;
    
    // 设置滚动的方向
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    return [super initWithCollectionViewLayout:layout];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // 注册cell,默认就会创建这个类型的cell
    [self.collectionView registerClass:[GuidePageCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // 分页
    self.collectionView.pagingEnabled = YES;
    self.collectionView.bounces = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    
    
}

#pragma mark - UICollectionView代理和数据源
// 返回有多少组
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

// 返回第section组有多少个cell
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_imageArray count];
}

// 返回cell长什么样子
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    GuidePageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    NSString *imageName = [_imageArray objectAtIndex:indexPath.row];
    cell.image = [UIImage imageNamed:imageName];
    cell.startBtnFrame = _startBtnFrame;
    [cell setIndexPath:indexPath count:[_imageArray count]];
    
    return cell;    
}

@end
