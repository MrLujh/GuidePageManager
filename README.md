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

## 创建方式

* 有两种思路

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
    
* 各维度解耦

    * 工程大了以后，要分拆，不管是组件化还是插件化，还是什么，解耦是第一步，而且是各个维度的解耦。
    
* 完善工具集

    * 模式演进的过程中，解耦的过程中，就会衍生出很多的工具。在进化过程里我们也会去思考，哪些工作是需要工具化的，主动去开发工具。一个完善的工具集，会极大提升团队的生产力，可以说是最有价值的部分。    

## 开发模式升级

* 模块化

    * 先按功能把工程做横向分层，在业务层再做纵向梳理。把不同的模块代码简单的放在一个文件夹里，而工程的组织形式并没有发生变化。跨团队基本不会在同一个模块代码上产生冲突。
    
* 插件化

    * 进一步发展，业务越来越复杂，团队工作越发细分，人也越来越多，代码量越来越大。简单的使用文件夹来组织模块的方式显得力不从心。多业务跨团队，不同的开发节奏，复杂的依赖关系，导致我们会花掉大量的时间解决编译不过的问题。等待其他模块集成这件事居然成了我们开发效率最大的瓶颈。

* 插件化

    * 代码独立，先从形式上解耦
    
    * 独立代码工程化，为独立运行打下基础
    
    * 梳理依赖关系，独立工程可编译
    
    * 放弃源码依赖，提速集成编译

## 解耦思路

* 工欲善其事，必先利其器。这句话每个人都在说，却不是每个人都能做到。一个具有工具文化的团队会在质量，效率各个方面都会有很大优势。
  
* 一个工程，从原始状态迅速膨胀到天猫现在的体量的，依赖关系之复杂，超乎想象。

* 耦合三类：

    * 界面耦合，就是用户操作流程里，不同界面间的跳转，这些界面的跳转是硬编码
    
    * 依赖耦合，顾名思义，两个模块之间的有依赖，就是耦合
    
    * 工程耦合，每个模块有自己的生命周期和运行时，每个模块在生产环境里又需要依赖主工程的运行时
    
    * 放弃源码依赖，提速集成编译
    
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


