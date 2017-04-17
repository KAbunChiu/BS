//
//  KABINCommentVC.m
//  YouMomBoom
//
//  Created by KAbun on 17/4/12.
//  Copyright © 2017年 KABIN. All rights reserved.
//

#import "KABINCommentVC.h"
#import "KABINNetworkTool.h"
#import "KABINCommentModel.h"
#import <MJExtension.h>
#import "KABINCommentCell.h"


@interface KABINCommentVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)NSMutableArray *dataArrM;

@property(nonatomic,weak)UITableView *tableView;


@end

@implementation KABINCommentVC

static NSString *str=@"cell";

-(NSMutableArray *)dataArrM{
    if (!_dataArrM) {
        _dataArrM=[NSMutableArray new];
    }
    return _dataArrM;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarController.tabBar.hidden=YES;
    [self loadData];
    [self setupUI];
}

-(void)loadData{
    NSString *urls=[NSString stringWithFormat:@"%@/0/bs0315-iphone-4.5.6/0-20.json",self.ord_id];
    NSString *URL=[CommentNet stringByAppendingString:urls];
    [self.dataArrM removeAllObjects];
    [KABINNetworkTool GET:URL params:nil progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        KABINCommentModel *model=[KABINCommentModel mj_objectWithKeyValues:responseObject];
       
        for (CommentListModel *cModel in model.normalModel.listModel) {
            
              [self.dataArrM addObject:cModel];
        }
      
        [self.tableView reloadData];
 
    } failuer:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];

}

-(void)setupUI{
    UITableView *tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, KABINScrennWidth, KABINScrennHeight) style:UITableViewStylePlain];
    tableView.delegate=self;
    tableView.dataSource=self;
    tableView.backgroundColor=[UIColor whiteColor];
    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:tableView];
    [tableView registerNib:[UINib nibWithNibName:@"KABINCommentCell" bundle:nil] forCellReuseIdentifier:str];
    self.tableView=tableView;
}

#pragma mark    -   TableViewDelegate

//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return 1;
//}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //Model里面算文本的高度
    return [self.dataArrM[indexPath.row] height];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArrM.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    KABINCommentCell *cell=[tableView dequeueReusableCellWithIdentifier:str];
    cell.lModel=self.dataArrM[indexPath.row];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

@end
