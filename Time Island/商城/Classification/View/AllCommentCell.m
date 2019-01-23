//
//  AllCommentCell.m
//  Time Island
//
//  Created by shaojianfei on 2019/1/22.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "AllCommentCell.h"
@interface AllCommentCell()
@property (nonatomic ,strong) UIImageView *icon;
@property (nonatomic ,strong) UILabel *seeCount;
@property (nonatomic ,strong) UILabel *timeLab;
@property (nonatomic ,strong) UIButton *commentBtn;
@property (nonatomic ,strong) UIButton *zanBtn;
@property (nonatomic ,strong) UIView *lineView;

@end
@implementation AllCommentCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIImageView *iconIV= [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 30, 30)];
        iconIV.layer.cornerRadius =15;
        iconIV.clipsToBounds = YES;
        iconIV.image = kImage(@"分类二");
        [self addSubview:iconIV];
        UILabel *moreLab = [UILabel labelWithBackgroundColor:kClearColor textColor:kTextColor2 font:13];
        moreLab.frame = CGRectMake(55, 15, 100, 30);
        moreLab.textAlignment = NSTextAlignmentLeft;
        moreLab.text = @"张三";
        //        moreLab.backgroundColor = [UIColor redColor];
        self.moreLab = moreLab;
        [self.contentView addSubview:moreLab];
        
        UILabel *detailLab = [UILabel labelWithBackgroundColor:kClearColor textColor:RGB(0, 0, 0) font:13];
        detailLab.frame = CGRectMake(15, iconIV.yy,kScreenWidth - 30, 35);
        detailLab.numberOfLines = 2;
        detailLab.textAlignment = NSTextAlignmentLeft;
        detailLab.text = @"老主顾了老主顾了老主顾了老主顾了老主顾了老主顾了老主顾了老主顾了老主顾了老主顾了";
        self.detailLab = detailLab;
        [self.contentView addSubview:detailLab];
        UILabel *seeCount = [UILabel labelWithBackgroundColor:kClearColor textColor:RGB(0, 0, 0) font:13];
        seeCount.frame = CGRectMake(15, detailLab.yy+5,80, 35);
        seeCount.textAlignment = NSTextAlignmentLeft;
        seeCount.text = @"浏览100次";
        self.seeCount = seeCount;
        [self.contentView addSubview:seeCount];
        self.commentBtn = [UIButton buttonWithTitle:@"评论" titleColor:kTextColor2 backgroundColor:kClearColor titleFont:12];
        [self.commentBtn setImage:kImage(@"评论") forState:UIControlStateNormal];
        self.commentBtn.frame = CGRectMake(kScreenWidth/2+80, detailLab.yy+5, 48, 33);
        [self addSubview:self.commentBtn];
        [self.commentBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        self.commentBtn.tag = 101;
        [self.commentBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -5)];
        self.commentBtn.centerY = self.seeCount.centerY;
        self.zanBtn = [UIButton buttonWithTitle:@"100" titleColor:kTextColor2 backgroundColor:kClearColor titleFont:10];
        self.zanBtn.frame = CGRectMake(kScreenWidth/2+80+kWidth(48), detailLab.yy+5, 48, 33);
        [self addSubview:self.zanBtn];
        [self.zanBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -5)];

        [self.zanBtn setImage:kImage(@"未点赞") forState:UIControlStateNormal];
          [self.zanBtn setImage:kImage(@"点赞") forState:UIControlStateSelected];
        self.zanBtn.centerY = self.seeCount.centerY;
        self.zanBtn.tag = 102;
        [self.zanBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        UIView *lineView = [UIView new];
        lineView.backgroundColor = RGB(242, 242, 242);
        lineView.frame = CGRectMake(0, seeCount.yy, kScreenWidth, 10);
        [self addSubview:lineView];
        self.lineView = lineView;
    }
    return self;
}
- (void)btnClick:(UIButton *)btn
{
    btn.selected = !btn.selected;
    
}

- (void)setImagesName:(NSArray *)imagesName
{
    _imagesName = imagesName;
}

- (void)layoutImagesView
{
    
}
-(void)setEditModel:(GoodsEditModel *)editModel
{
    _editModel = editModel;
    if (editModel.images.count >0) {
        
    }else{
        editModel.Rowheight = self.zanBtn.yy +20;
        
//        [self setNeedsLayout];
        
        return;
    }
    
    for (int i = 0; i < editModel.images.count; i++) {
        UIImageView *photoImage = [[UIImageView alloc]initWithFrame:CGRectMake(15 + i % 3 *  ((SCREEN_WIDTH - 50)/3 + 10), self.detailLab.yy +10 + i / 3 * ((SCREEN_WIDTH - 50)/3 + 10), (SCREEN_WIDTH - 50)/3, kHeight(102))];
        [photoImage sd_setImageWithURL:[NSURL URLWithString:[editModel.images[i] convertImageUrl]] placeholderImage:kImage(editModel.images[i])];
        photoImage.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(btnclick1:)];
        [photoImage addGestureRecognizer:tap];
        [self addSubview:photoImage];
    }
    self.seeCount.frame = CGRectMake(15, (editModel.images.count/4 +1)*(kHeight(102))+kHeight(100)+(editModel.images.count/4)*15, 80, 35);
    self.commentBtn.frame = CGRectMake(kScreenWidth/2+80, (editModel.images.count/4 +1)*(kHeight(102))+kHeight(100)+(editModel.images.count/4)*15, 48, 33);
    self.zanBtn.frame = CGRectMake(kScreenWidth/2+80+kWidth(48), (editModel.images.count/4 +1)*(kHeight(102))+kHeight(100)+(editModel.images.count/4)*15, 48, 33);
    self.lineView.frame = CGRectMake(0, self.seeCount.yy+20, kScreenWidth, 10);
    editModel.Rowheight = self.seeCount.yy +30;
    
//    [self setNeedsLayout];
}
- (void)btnclick1:(UIButton *)btn
{
    
}
@end
