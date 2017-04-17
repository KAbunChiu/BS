//
//  KABINEssenceVC.m
//  YouMomBoom
//
//  Created by KAbun on 16/12/30.
//  Copyright © 2016年 KABIN. All rights reserved.
//

#import "KABINEssenceVC.h"
#import <Masonry.h>
#import "KABINTagsButton.h"
#import "UIView+Extension.h"
#import "KABINContentVC.h"

@interface KABINEssenceVC ()<UIScrollViewDelegate>
@property(nonatomic,strong) NSMutableArray *tagsArrM;
@property(nonatomic,strong) NSMutableArray *tagsURLArrM;
//标签栏
@property(nonatomic,strong) UIScrollView *tagsView;
//标签按钮
@property(nonatomic,weak) KABINTagsButton *tagsBtn;
//滑动条
@property(nonatomic,weak) UIView *slideView;

@property(nonatomic,strong) MASConstraint *sliderViewCenterX;

@property(nonatomic,weak) UIScrollView *contentSrollView;
@end

@implementation KABINEssenceVC

-(NSMutableArray *)tagsArrM{
    if (!_tagsArrM) {
        _tagsArrM=[@[@"推荐",@"视频",@"图片",@"段子",@"网红",@"排行",@"社会",@"美女",@"冷知识",@"游戏"] mutableCopy];
    }
    return _tagsArrM;
}

-(NSMutableArray *)tagsURLArrM{
    if (!_tagsURLArrM) {
        _tagsURLArrM=[@[@"topic/list/jingxuan/1/bs0315-iphone-4.5.1/",
                                       @"topic/list/jingxuan/41/bs0315-iphone-4.5.1/",
                                       @"topic/list/jingxuan/10/bs0315-iphone-4.5.1/",
                                       @"topic/tag-topic/64/hot/bs0315-iphone-4.5.1/",
                                       @"topic/tag-topic/3096/hot/bs0315-iphone-4.5.1/",
                                       @"topic/list/remen/1/bs0315-iphone-4.5.1/",
                                       @"topic/tag-topic/473/hot/bs0315-iphone-4.5.1/",
                                       @"topic/tag-topic/117/hot/bs0315-iphone-4.5.1/",
                                       @"topic/tag-topic/3176/hot/bs0315-iphone-4.5.1/",
                                       @"topic/tag-topic/164/hot/bs0315-iphone-4.5.1/"]   mutableCopy];
    }
    return _tagsURLArrM;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
   self.tabBarController.tabBar.hidden=NO;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
//    self.navigationItem.titleView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"]];
    self.navigationItem.titleView=[self setupTitleText];
    
    [self setupTagsView];
    
    [self setupChildViewController];
    
    [self setupContentView];
  
}

-(UILabel *)setupTitleText{
    UILabel *titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 120, 30)];
    titleLabel.textAlignment=NSTextAlignmentCenter;
    titleLabel.font=[UIFont fontWithName:@"Zapfino" size:15];
    titleLabel.textColor=[UIColor redColor];
    titleLabel.text=@"KABIN App";
    return titleLabel;
}

-(void)setupTagsView{
    UIScrollView *tagsView=[[UIScrollView alloc]init];
    tagsView.backgroundColor=[UIColor colorWithWhite:1.0 alpha:0.7];
    tagsView.delegate=self;
    tagsView.showsVerticalScrollIndicator=NO;
    tagsView.showsHorizontalScrollIndicator=NO;
    tagsView.bounces=NO;
    tagsView.contentSize=CGSizeMake(60*self.tagsArrM.count, -20);
    tagsView.panGestureRecognizer.delaysTouchesBegan=YES;
    [self.view addSubview:tagsView];
    
    [tagsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(0);
        make.right.left.equalTo(self.view).offset(0);
        make.size.mas_offset(CGSizeMake(KABINScrennWidth, 30));
    }];
    self.tagsView=tagsView;
    
    UIView *slideView=[UIView new];
    slideView.backgroundColor=[UIColor redColor];
    slideView.layer.cornerRadius=2;
    self.slideView=slideView;

    for (int i=0; i<self.tagsArrM.count; i++) {
     KABINTagsButton *button= [self tagsButtonTitle:self.tagsArrM[i] andIndex:i];
        if (i==0) {
            button.selected=YES;
            self.tagsBtn=button;
            [button.titleLabel sizeToFit];
            self.slideView.height=2;
            self.slideView.y=button.y+28;
            self.slideView.width=button.titleLabel.frame.size.width;
            self.slideView.centerX=button.centerX;
            [self.slideView sizeToFit];
        }
    }
    [self.tagsView addSubview:slideView];
}

-(KABINTagsButton*)tagsButtonTitle:(NSString *)title andIndex:(int )index{
    KABINTagsButton *btn=[KABINTagsButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.frame=CGRectMake(index*60, 0, 60, 30);
    [btn addTarget:self action:@selector(tagsBtnClick:) forControlEvents:UIControlEventTouchUpInside];
     [self.tagsView addSubview:btn];
    return btn;
}

-(void)tagsBtnClick:(KABINTagsButton *)btn{
    self.tagsBtn.selected=NO;
    btn.selected=YES;
    self.tagsBtn=btn;
    
    [UIView animateWithDuration:0.25f animations:^{
        self.slideView.height=2;
        self.slideView.y=btn.y+28;
        self.slideView.width=btn.titleLabel.frame.size.width;
        self.slideView.centerX=btn.centerX;
        [self.slideView sizeToFit];
    }];

    int index = (int)[self.tagsView.subviews indexOfObject:btn];
    [self.contentSrollView setContentOffset:CGPointMake(index * self.contentSrollView.frame.size.width, self.contentSrollView.contentOffset.y) animated:YES];
    if (btn.x>KABINScrennWidth/2) {
        self.tagsView.contentOffset=CGPointMake(index*60-KABINScrennWidth/2+btn.size.width/2, 0);
    }else{
        self.tagsView.contentOffset=CGPointMake(0, 0);
    }
}

-(void)setupContentView{
    UIScrollView *content=[UIScrollView new];
//    content.backgroundColor=[UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1.0];
    content.backgroundColor=[UIColor whiteColor];
    content.delegate=self;
    content.contentSize=CGSizeMake(self.tagsArrM.count*KABINScrennWidth, KABINScrennHeight-30-55);
    content.showsVerticalScrollIndicator=NO;
    content.showsHorizontalScrollIndicator=NO;
    content.panGestureRecognizer.delaysTouchesBegan=YES;
    content.bounces=NO;
    content.userInteractionEnabled=YES;
    content.pagingEnabled = YES;
    [self.view addSubview:content];
    
    [content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view).offset(0);
        make.top.equalTo(self.tagsView.mas_bottom).offset(0);
        make.bottom.equalTo(self.view).offset(0);
    }];
   
    self.contentSrollView=content;
    [self switchController:0];
}

-(void)setupChildViewController{
    for (int i=0; i <self.tagsURLArrM.count; i++) {
        [self setupOneChildViewController:self.tagsURLArrM[i]];
    }
}

-(void)switchController:(int )index{
    KABINContentVC *contentVC=self.childViewControllers[index];
    contentVC.view.y=0;
    contentVC.view.width=self.contentSrollView.width;
    contentVC.view.height=self.contentSrollView.height;
    contentVC.view.x=contentVC.view.width*index;
    [self.contentSrollView addSubview:contentVC.view];
}


-(void)setupOneChildViewController:(id)type{
        KABINContentVC *contentVC=[KABINContentVC new];
        contentVC.URL=type;
        [self addChildViewController:contentVC];
}

- (void)scrollViewDidEndDecelerating:(nonnull UIScrollView *)scrollView
{
    if (scrollView==self.contentSrollView) {
        int index = scrollView.contentOffset.x / scrollView.frame.size.width;
        [self tagsBtnClick:self.tagsView.subviews[index]];
        [self switchController:index];
    }
}

- (void)scrollViewDidEndScrollingAnimation:(nonnull UIScrollView *)scrollView
{
    if (scrollView==self.contentSrollView) {
          [self switchController:(int)(scrollView.contentOffset.x / scrollView.frame.size.width)];
    }
}


@end
