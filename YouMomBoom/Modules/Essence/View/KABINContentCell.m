//
//  KABINContentCell.m
//  YouMomBoom
//
//  Created by KAbun on 17/1/5.
//  Copyright © 2017年 KABIN. All rights reserved.
//

#import "KABINContentCell.h"
#import <UIImageView+WebCache.h>
#import <UIImage+GIF.h>
#import "KABINPictureView.h"
#import "gif.h"
#import "image.h"
#import "video.h"
#import "KABINMediaView.h"


@interface KABINContentCell()
@property (weak, nonatomic) IBOutlet UIImageView *vImg;
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIImageView *iconIv;
@property (weak, nonatomic) IBOutlet UILabel *nickLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *subIconlv;
@property (weak, nonatomic) IBOutlet UIView *toolBarView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIButton *upButton;
@property (weak, nonatomic) IBOutlet UIButton *downButton;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property (nonatomic, weak) UILabel *zanLabel;
@property (nonatomic, weak) UILabel *caiLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *nickW;

@property(nonatomic,assign)BOOL isSelect;

//图片内容
@property(nonatomic,weak) KABINPictureView *pictureView;

@property(nonatomic,weak) KABINMediaView *mediaView;

@property(nonatomic,strong) KABINContentView *contentV;
@end
@implementation KABINContentCell

-(KABINMediaView *)mediaView{
    if (!_mediaView) {
        [self.contentView addSubview:_mediaView=[KABINMediaView videoView]];
    }
    return _mediaView;
}

-(KABINPictureView *)pictureView{
    if (!_pictureView) {
        [self.contentView addSubview:_pictureView=[KABINPictureView pictureView]];
    }
    return _pictureView;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupUI];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(void)setupUI{
    self.bottomView.backgroundColor=[UIColor colorWithWhite:1 alpha:0];
    self.upButton.backgroundColor=[UIColor colorWithWhite:1 alpha:0];
    self.downButton.backgroundColor=[UIColor colorWithWhite:1 alpha:0];
    
    self.vImg.hidden=YES;
    self.subIconlv.hidden=YES;
    self.iconIv.layer.cornerRadius=20;
    self.iconIv.layer.masksToBounds=YES;
    
    
    
    
    self.vImg.image=[UIImage imageNamed:@"Profile_AddV_authen"];
    self.subIconlv.image=[UIImage sd_animatedGIFNamed:@"member_ diamond_icon"];
    
    
   
    
    [self.shareButton setImage:[UIImage imageNamed:@"mainCellShare"] forState:UIControlStateNormal];
    [self.shareButton setImage:[UIImage imageNamed:@"mainCellShareClick"] forState:UIControlStateDisabled];
    
    [self.commentButton setImage:[UIImage imageNamed:@"mainCellComment"] forState:UIControlStateNormal];
    [self.commentButton setImage:[UIImage imageNamed:@"mainCellCommentClick"] forState:UIControlStateDisabled];

    [self.commentButton addTarget:self action:@selector(CommentClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *zanLabel=[UILabel new];
    zanLabel.frame=CGRectMake(50, 10, 20, 20);
    zanLabel.textColor=[UIColor redColor];
    zanLabel.text=@"+1";
    zanLabel.textAlignment=NSTextAlignmentCenter;
    zanLabel.hidden=YES;
    zanLabel.font=[UIFont systemFontOfSize:13];
    self.zanLabel=zanLabel;
    [self.upButton addSubview:zanLabel];
    
    UILabel *caiLabel=[UILabel new];
    caiLabel.frame=CGRectMake(50, 10, 20, 20);
    caiLabel.textColor=[UIColor redColor];
    caiLabel.text=@"+1";
    caiLabel.font=[UIFont systemFontOfSize:13];
    caiLabel.textAlignment=NSTextAlignmentCenter;
    caiLabel.hidden=YES;
    self.caiLabel=caiLabel;
    [self.downButton addSubview:caiLabel];
    
   
    [self.upButton addTarget:self action:@selector(zan:) forControlEvents:UIControlEventTouchUpInside];
    [self.downButton addTarget:self action:@selector(cai:) forControlEvents:UIControlEventTouchUpInside];
    
    
}

-(void)prepareForReuse{
    [super prepareForReuse];

    
   
}

-(void)setModel:(listModel *)model{
    _model=model;
    
    [self.iconIv sd_setImageWithURL:[NSURL URLWithString:model.u.header.firstObject] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
    self.timeLabel.text=model.passtime;
    self.nickLabel.text=model.u.name;
    self.textLabel.text=model.text;
   
    gif *gifModel=model.gif;
    image *imageModel=model.image;
    video *videoModel=model.video;
  
    self.nickW.constant=model.u.textW;
    [self layoutIfNeeded];
    KABINLog(@"%f",self.nickLabel.frame.size.width);
    self.contentV=nil;
    if ([model.type isEqualToString:@"image"]) {
        [self.pictureView setupImageURL:[imageModel.big lastObject] andGIF:NO andBigImage:imageModel.isBig];
        [self.pictureView.seeBigImage addTarget:self action:@selector(bigClick:) forControlEvents:UIControlEventTouchUpInside];
        self.contentV=self.pictureView;
        self.mediaView.hidden=YES;
    }else if ([model.type isEqualToString:@"gif"]){
        [self.pictureView setupImageURL:[gifModel.images firstObject] andGIF:gifModel.isGif andBigImage:NO];
        self.contentV=self.pictureView;
        self.mediaView.hidden=YES;
    }else if ([model.type isEqualToString:@"video"]){
        [self.mediaView setupPlayCount:[videoModel.playcount integerValue] andTime:[videoModel.duration integerValue] andImageURL:[videoModel.thumbnail firstObject]];
        [self.mediaView.playButton addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
         self.pictureView.hidden=YES;
        self.contentV=self.mediaView;
    }else{
        self.pictureView.hidden=YES;
        self.mediaView.hidden=YES;
    }
    self.contentV.hidden=NO;
    self.contentV.frame=model.contentFrame;
   
    if ([model.u.is_v isEqualToNumber:@1]) {
        self.vImg.hidden=NO;
    }else if ([model.u.is_vip isEqualToNumber:@1] ){
        self.subIconlv.hidden=NO;
        self.nickLabel.textColor=[UIColor redColor];
    }else if([model.u.is_v isEqualToNumber:@0]){
        self.vImg.hidden=YES;
    }else if([model.u.is_vip isEqualToNumber:@0]){
        self.subIconlv.hidden=YES;
        self.nickLabel.textColor=[UIColor blueColor];
    }
    
    [self.upButton setTitle:model.up forState:UIControlStateNormal];
    [self.downButton setTitle:[NSString stringWithFormat:@"%@",model.down] forState:UIControlStateNormal];
    [self.commentButton setTitle:[NSString stringWithFormat:@"%@",model.forward] forState:UIControlStateNormal];
    [self.shareButton setTitle:[NSString stringWithFormat:@"%@",model.status] forState:UIControlStateNormal];
    
    [self.upButton setImage:[UIImage imageNamed:@"mainCellDing"] forState:UIControlStateNormal];
    [self.downButton setImage:[UIImage imageNamed:@"mainCellCai"] forState:UIControlStateNormal];

}

-(void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    static CGFloat margin=10;
    frame.origin.x=margin;
    frame.size.width-=2*margin;
    frame.size.height-=margin;
    frame.origin.y-=margin;
    
}

-(void)click:(UIButton *)button{
    CGFloat time=[self.model.video.duration floatValue];
    self.vblock([self.model.video.video lastObject],time);
}

-(void)bigClick:(UIButton*)b{
    self.pblock([self.model.image.height floatValue],[self.model.image.big firstObject],[self.model.image.width floatValue]);
}

#pragma mark    -   评论按钮响应
-(void)CommentClick:(UIButton *)btn{
    self.comblock();
}

#pragma mark    -   赞按钮响应
-(void)zan:(UIButton *)btn{
    btn.selected=!btn.selected;
    if (btn.selected) {
         self.zanLabel.text=@"+1";
        [UIView animateWithDuration:1.0 animations:^{
            self.zanLabel.hidden=NO;
            self.zanLabel.frame=CGRectMake(btn.frame.origin.x+60, 0, 20, 20);
        } completion:^(BOOL finished) {
            self.zanLabel.hidden=YES;
            self.zanLabel.frame=CGRectMake(btn.frame.origin.x+50, 10, 20, 20);
        }];
         [self.upButton setImage:[UIImage imageNamed:@"mainCellDingClick"] forState:UIControlStateNormal];
    }else{
        self.zanLabel.text=@"-1";
        [UIView animateWithDuration:1.0 animations:^{
            self.zanLabel.hidden=NO;
            self.zanLabel.frame=CGRectMake(btn.frame.origin.x+60, 0, 20, 20);
        } completion:^(BOOL finished) {
            self.zanLabel.hidden=YES;
            self.zanLabel.frame=CGRectMake(btn.frame.origin.x+50, 10, 20, 20);
        }];
        [self.upButton setImage:[UIImage imageNamed:@"mainCellDing"] forState:UIControlStateNormal];
    }
}

#pragma mark    -   踩按钮响应
-(void)cai:(UIButton *)btn{
    btn.selected=!btn.selected;
    if (btn.selected) {
        self.caiLabel.text=@"+1";
        [UIView animateWithDuration:1.0 animations:^{
            self.caiLabel.hidden=NO;
            self.caiLabel.frame=CGRectMake(60, 0, 20, 20);
        } completion:^(BOOL finished) {
            self.caiLabel.hidden=YES;
            self.caiLabel.frame=CGRectMake(50, 10, 20, 20);
        }];
        [self.downButton setImage:[UIImage imageNamed:@"mainCellCaiClick"] forState:UIControlStateNormal];
    }else{
        self.caiLabel.text=@"-1";
        [UIView animateWithDuration:1.0 animations:^{
            self.caiLabel.hidden=NO;
            self.caiLabel.frame=CGRectMake(60, 0, 20, 20);
        } completion:^(BOOL finished) {
            self.caiLabel.hidden=YES;
            self.caiLabel.frame=CGRectMake(50, 10, 20, 20);
        }];
        [self.downButton setImage:[UIImage imageNamed:@"mainCellCai"] forState:UIControlStateNormal];
    }
}

@end
