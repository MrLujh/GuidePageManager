# GuidePageManager

## 支持pod导入

* pod 'GuidePageManager'

* 执行pod search GuidePageManager提示搜索不到，可以执行以下命令更新本地search_index.json文件
  
```objc 
rm ~/Library/Caches/CocoaPods/search_index.json
```
* 如果pod search还是搜索不到，执行pod setup命令更新本地spec缓存（可能需要几分钟），然后再搜索就可以了

## 前言

* 一款App在首次安装后打开时，会有3-5页的介绍界面引导新用户使用或者给用户更新提示。
根据引导页的目的、出发点不同，可以将其分为功能介绍类、使用说明类、推广类、问题解决类，一般引导页不会超过5页。 功能介绍类 功能介绍类引导页主要是对产品的主要功能进行展示，让用户对产品主功能有一个大致的了解。

## 创建方式 ----有两种思路

* 通过版本号来判断是否第一次安装,来改变窗口的根控制器,代码如下:
    
```objc       
// 获取当前的版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
    
    // 获取上一次的版本号
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:THVersionKey];
    
    if ([lastVersion floatValue] > 0) {
        
        [[UIApplication sharedApplication] setStatusBarHidden:NO];
        
        // 没有最新的版本号 创建tabBarVc
        TLTabBarViewController *tabBarVC = [[TLTabBarViewController alloc]init];
        self.tabBarVC = tabBarVC;
        [self showUnreadMessageHotView];
        self.window.rootViewController = tabBarVC;
        
    }else {
        
      
        TLGuidePageVC *vc = [[TLGuidePageVC alloc] init];

        self.window.rootViewController = vc;

        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:THVersionKey];
        
    }
``` 

* 在AppDelegate中，创建一个新的Window，把引导页的控制器设为新window的根控制器,代码如下:

```objc       
 // 添加引导页
    NSArray *imageArray = [[NSArray alloc] init];
    if (BottomSafty == 0) {
        
        imageArray = @[@"guide_page_image_0",@"guide_page_image_1", @"guide_page_image_2", @"guide_page_image_3", @"guide_page_image_4"];
    }else {
        
        imageArray = @[@"guide_page_image_iphoex_0",@"guide_page_image_iphoex_1", @"guide_page_image_iphoex_2", @"guide_page_image_iphoex_3"];
    }
    
    // 体验 按钮
    CGRect ret;
    if (BottomSafty == 0) {
        
        ret = CGRectMake((KUIScreenWidth -140*kScaleW)/2.0, KUIScreenHeight -60*kScaleH, 140*kScaleW, 50);
    }else {
        
        ret = CGRectMake((KUIScreenWidth -140*kScaleW)/2.0, KUIScreenHeight -110*kScaleH, 140*kScaleW, 50);
    }
    
    [GuidePageManager shareManagerWithDelegate:self imageArray:imageArray startBtnFrame:ret isShowBtnBackgroundColor:NO];
```
     
## 创建方式  ----分析

* 如果是采用AppDelegate中使用ViewController方式实现.那就需要用到切换rootViewController。 

    * 利用代理或者block将rootViewController切换回TLTabBarViewController;
    
    * 利用这种方式有弊端，即：用户第一次安装的时候，如果没有走完引导页面，现在窗口的跟控制器还是引导页的控制，项目中所有的控制器都还没有创建，这时候进入后台，收到平台发送的通知，点击通知用户是无法跳转到对应的界面;
    
    * 这种情况其实很少出现，项目最好不要通过修改window的根控制器来做引导页。
    
* 通过创建一个新的Window，然后把引导页的控制设置为新Window的根控制器，降低了代码的耦合性，引导页功能独立。

## 使用    

* 路由&无参数

    * 由ViewController向TestViewController跳转，在ViewController中将通过路由找到TestViewController
    
```objc       
UIViewController *doc = [[RouterManager sharedInstance]
                             performAction:@"TestViewController"
                             params:nil
                             shouldCacheTarget:NO];

[self.navigationController pushViewController:doc animated:YES];
```

* 路由&带参数

    * 由ViewController向TestViewController跳转，在ViewController中将通过路由找到TestViewController，
    传入的参数赋值给目标控制器，在TestViewController中只需声明一下入参接收对应的key
```objc       
@implementation UIViewController (routerManager)

- (id)createVC:(NSDictionary *)dict{
    
    Class class = getClassFromAtcion(_cmd);
    if (class) {
        
        UIViewController *doc = self;
        doc = [[class alloc]init];
        doc = [doc mj_setKeyValues:dict];
        return doc;
    }
    return nil;
}
@end
```

```objc       
UIViewController *doc = [[RouterManager sharedInstance]
                             performAction:@"TestViewController"
                             params:@{
                                      @"info":@{
                                              @"user":@"我是正向传值参数:push",
                                              }
                                      }
                             shouldCacheTarget:NO];

[self.navigationController pushViewController:doc animated:YES];
```    

* 路由&带参数&回调反向传值

    * 在ViewController和TestViewController中同时声明一个blcok,在demo中有详细说明
```objc       
- (IBAction)popBtnClick:(UIButton *)sender
{
    
    self.backblock(@"我是返回值参数:pop");
    
    [self.navigationController popViewControllerAnimated:YES];
}
```

```objc       
__weak typeof(self) weakSelf = self;
self.backWithDict = ^(NSString *str) {
        
        weakSelf.backLabel.text = str;
};
    
UIViewController *doc = [[RouterManager sharedInstance]
                             performAction:@"TestViewController"
                             params:@{
                                      @"info":@{
                                              @"user":@"我是正向传值参数:push",
                                              },
                                      @"backblock":self.backWithDict
                                      }
                             shouldCacheTarget:NO];

[self.navigationController pushViewController:doc animated:YES];
```    


![Mou icon](https://github.com/MrLujh/Fastlane--Packaging/blob/master/111.gif)


