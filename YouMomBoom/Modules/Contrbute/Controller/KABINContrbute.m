//
//  KABINContrbute.m
//  YouMomBoom
//
//  Created by KAbun on 16/12/30.
//  Copyright © 2016年 KABIN. All rights reserved.
//

#import "KABINContrbute.h"

@interface KABINContrbute ()

@end

@implementation KABINContrbute

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor colorWithWhite:0.9 alpha:0.5];

    
    
    UILabel *label=[UILabel new];
    label.frame=CGRectMake(KABINScrennWidth/2-150, KABINScrennHeight/2-50, 300, 100);
    label.text=@"未开发";
    label.font=[UIFont systemFontOfSize:30];
    label.textAlignment=NSTextAlignmentCenter;
    label.textColor=[UIColor redColor];
    [self.view addSubview:label];

}


@end
