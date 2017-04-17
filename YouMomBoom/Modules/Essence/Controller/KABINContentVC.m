\
//
//  KABINContentVC.m
//  YouMomBoom
//
//  Created by KAbun on 17/1/4.
//  Copyright © 2017年 KABIN. All rights reserved.
//

#import "KABINContentVC.h"
#import "KABINNetworkTool.h"
#import <MJExtension.h>
#import "GuideDetailModel.h"
#import "KABINContentCell.h"
#import "KABINMoreVC.h"
#import "KABINBigPictureVC.h"
#import "KABINGifHeader.h"
#import "info.h"
#import "KABINCommentVC.h"

@interface KABINContentVC ()
@property(nonatomic,strong) NSMutableArray *dataArrM;
@property(nonatomic,assign) NSInteger page;
@property(nonatomic,assign) NSInteger oldPage;
@end

@implementation KABINContentVC

static NSString *CellIdentifier = @"Cell";

-(NSMutableArray *)dataArrM{
    if (!_dataArrM) {
        _dataArrM=[NSMutableArray new];
    }
    return _dataArrM;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.tableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 49, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    [self.tableView registerNib:[UINib nibWithNibName:@"KABINContentCell" bundle:nil] forCellReuseIdentifier:CellIdentifier];
    [self loadData];
}

-(void)loadData{
    self.tableView.mj_header = [KABINGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopics)];
    
    [self.tableView.mj_header beginRefreshing];
    

    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopics)];
}

-(void)loadNewTopics{
    NSString *URLStr=[HomeNET stringByAppendingString:self.URL];
    NSString *URLB=[URLStr stringByAppendingString:@"0-30.json"];
//    KABINLog(@"%@",URLB);
     [self.dataArrM removeAllObjects];
    
    [KABINNetworkTool GET:URLB params:nil progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
       
        GuideDetailModel *model=[GuideDetailModel mj_objectWithKeyValues:responseObject];
        info *infoModel=model.info;
        self.page=[infoModel.np integerValue];
        
        [self.dataArrM addObjectsFromArray:model.list];
        
        [self.tableView reloadData];
        
       
    } failuer:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
   [self.tableView.mj_header endRefreshing];
}


-(void)loadMoreTopics{
    NSString *URLStr=[HomeNET stringByAppendingString:self.URL];
    NSString *par=[NSString stringWithFormat:@"%ld-20,json",self.page];
    NSString *URLB=[URLStr stringByAppendingString:par];
    
    [KABINNetworkTool GET:URLB params:nil progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        GuideDetailModel *model=[GuideDetailModel mj_objectWithKeyValues:responseObject];
        info *infoModel=model.info;
        self.page=[infoModel.np integerValue];
        [self.dataArrM addObjectsFromArray:model.list];
        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
    } failuer:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
  
  

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArrM.count ;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    KABINContentCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    cell.model=self.dataArrM[indexPath.row];
 
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
   
   
    __weak typeof(self) weakSelf = self;
    cell.vblock=^(NSString *str,CGFloat time){
        KABINMoreVC *vc=[KABINMoreVC new];
        vc.timeV=time;
        vc.type=str;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    
    cell.pblock=^(CGFloat height,NSString *url,CGFloat width){
        KABINBigPictureVC *vc=[KABINBigPictureVC new];
        vc.url=url;
        vc.height=height;
        vc.width=width;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    
    cell.comblock=^(){
        KABINCommentVC *commentVC=[KABINCommentVC new];
        commentVC.ord_id=[weakSelf.dataArrM[indexPath.row] ord_ID];
        [weakSelf.navigationController pushViewController:commentVC animated:YES];
    };
    
    return cell;
}

-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    listModel *model=self.dataArrM[indexPath.row];
    
    return model.cellHeight;
}

-(void)dealloc{
    KABINLog(@"%s",__func__);
}
@end
