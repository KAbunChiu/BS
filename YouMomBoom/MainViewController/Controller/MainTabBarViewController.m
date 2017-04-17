//
//  MainTabBarViewController.m
//  YouMomBoom
//
//  Created by KAbun on 16/12/30.
//  Copyright © 2016年 KABIN. All rights reserved.
//

#import "MainTabBarViewController.h"
#import "KABINNewVC.h"
#import "KABINMineVC.h"
#import "KABINConcernVC.h"
#import "KABINContrbute.h"
#import "KABINEssenceVC.h"
#import "KABINNavigationVC.h"

@interface MainTabBarViewController ()<UITabBarControllerDelegate>

@property(nonatomic,strong) NSMutableArray  *classArrM;

@property(nonatomic,strong) NSMutableArray *imageArrM;

@property(nonatomic,strong) NSMutableArray *classNameArrM;

@property(nonatomic,strong) NSMutableArray *seletedImageArrM;

@property(nonatomic,strong)NSNumber *v;
@end

@implementation MainTabBarViewController

-(NSMutableArray *)classArrM{
    if (!_classArrM) {
        _classArrM=[@[
                    [KABINEssenceVC new],
                    [KABINNewVC new],
                    [KABINContrbute new],
                    [KABINConcernVC new],
                    [KABINMineVC new],
                                ] mutableCopy];
    }
    return _classArrM;
}

-(NSMutableArray *)imageArrM{
    if (!_imageArrM) {
        _imageArrM=[@[@"tabBar_essence_icon",
                                   @"tabBar_new_icon",
                                   @"tabBar_publish_icon",
                                   @"tabBar_me_icon",
                                   @"tabBar_friendTrends_icon"]mutableCopy];
    }
    return _imageArrM;
}

-(NSMutableArray *)classNameArrM{
    if (!_classNameArrM) {
        _classNameArrM=[@[@"精髓",
                                           @"最新",
                                           @"",
                                           @"关注",
                                           @"我"]mutableCopy];
    }
    return _classNameArrM;
}

-(NSMutableArray *)seletedImageArrM{
    if (!_seletedImageArrM) {
        _seletedImageArrM=[@[@"tabBar_essence_click_icon",
                                               @"tabBar_new_click_icon",
                                               @"tabBar_publish_click_icon",
                                               @"tabBar_me_click_icon",
                                               @"tabBar_friendTrends_click_icon"]mutableCopy];
    }
    return _seletedImageArrM;
}

+(void)initialize{
   
    UIBarItem *item=[UIBarItem appearance];
    
    NSMutableDictionary *attr=[NSMutableDictionary dictionary];
    attr[NSForegroundColorAttributeName]=[UIColor darkGrayColor];
    [item setTitleTextAttributes:attr forState:UIControlStateNormal];
    
    NSMutableDictionary *attrs=[NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName]=[UIColor redColor];
    [item setTitleTextAttributes:attrs forState:UIControlStateSelected];
    

    
    [[UITabBar appearance]setBackgroundImage:[UIImage imageNamed:@"tabbar-light"]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate=self;
    [self addChildVC];
    self.v=@0;
}

-(void)addChildVC{
    for (int i=0; i<5; i++) {
        [self setupOneChildViewController:self.classArrM[i] title:self.classNameArrM[i] image:self.imageArrM[i] selectedImage:self.seletedImageArrM[i] indexNum:i];
    }
}

- (void)setupOneChildViewController:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage indexNum:(int)indexNum
{
    if (indexNum==2) {
        vc.tabBarItem.imageInsets=UIEdgeInsetsMake(6, 0, -6, 0);
    }
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    KABINNavigationVC *nvc=[[KABINNavigationVC alloc]initWithRootViewController:vc];
    nvc.navigationBar.translucent=NO;
    [self addChildViewController:nvc];
}

-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    NSInteger selected=[tabBar.items indexOfObject:item];
   
        [self animationWithIndex:selected];
        
    
}

-(void)animationWithIndex:(NSInteger)index{
    NSMutableArray *items=[NSMutableArray new];
    for (UIView *tabBarButton in self.tabBar.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [items addObject:tabBarButton];
        }
    }
    CABasicAnimation *animation =  [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    if (index==2) {
        animation.fromValue = self.v;
        animation.toValue =  [NSNumber numberWithFloat: M_PI_4];
    }else{
        animation.toValue =  [NSNumber numberWithFloat:0];
    }
    self.v=animation.toValue;
    animation.duration  = 0.4;
    animation.autoreverses = NO;
    animation.removedOnCompletion=NO;
    animation.fillMode =kCAFillModeForwards;
    [[items[2] layer] addAnimation:animation forKey:nil];
    
}

@end
