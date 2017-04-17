//
//  KABINCommentCell.m
//  YouMomBoom
//
//  Created by KAbun on 17/4/13.
//  Copyright © 2017年 KABIN. All rights reserved.
//

#import "KABINCommentCell.h"
#import <UIImageView+WebCache.h>
#import "KABINTextView.h"

@interface KABINCommentCell()
@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UIImageView *sexImage;
@property (weak, nonatomic) IBOutlet UIButton *zanBtn;
@property (weak, nonatomic) IBOutlet UIButton *caiBtn;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;


@property(nonatomic,strong)KABINTextView *textView;

@end

@implementation KABINCommentCell

-(KABINTextView *)textView{
    if (!_textView) {
        _textView=[KABINTextView commentText];
        
    }
    return _textView;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupUI];
}

-(void)setupUI{
    
    self.userImage.layer.cornerRadius=20;
    self.userImage.layer.masksToBounds=YES;
    
    self.commentLabel.layer.cornerRadius=4;
    self.commentLabel.layer.masksToBounds=YES;
    
    [self.zanBtn setImage:[UIImage imageNamed:@"mainCellDing"] forState:UIControlStateNormal];
    [self.caiBtn setImage:[UIImage imageNamed:@"mainCellCai"] forState:UIControlStateNormal];

   
}

-(void)setLModel:(CommentListModel *)lModel{
    _lModel=lModel;
    
    if ([lModel.userModel.sex isEqualToString:@"m"]) {
        self.sexImage.image=[UIImage imageNamed:@"m"];
    }else{
        self.sexImage.image=[UIImage imageNamed:@"l"];
    }

    self.name.text=lModel.userModel.username;
    [self.zanBtn setTitle:[NSString stringWithFormat:@"%@",lModel.like_count] forState:UIControlStateNormal];
    [self.caiBtn setTitle:[NSString stringWithFormat:@"%@",lModel.hate_count] forState:UIControlStateNormal];

    [self.userImage sd_setImageWithURL:[NSURL URLWithString:lModel.userModel.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];

    if ([lModel.userModel.total_cmt_like_count integerValue]>999) {
        self.commentLabel.text=[NSString stringWithFormat:@"%.1fk",[lModel.userModel.total_cmt_like_count floatValue]*0.001];
    }else{
        self.commentLabel.text=lModel.userModel.total_cmt_like_count;
    }
    
    self.contentLabel.text=lModel.content;
}

@end
