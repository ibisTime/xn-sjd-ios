//
//  MyTreeHeadCell.m
//  Time Island
//
//  Created by 郑勤宝 on 2019/1/10.
//  Copyright © 2019 ChengLian. All rights reserved.
//

#import "MyTreeHeadCell.h"

@implementation MyTreeHeadCell
{
    UIImageView * img;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIImageView *backImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,  kHeight(432))];
        backImg.image = kImage(@"树 跟背景");
        [self addSubview:backImg];
        
        
        img = [[UIImageView alloc]initWithFrame:CGRectMake(0, 50, SCREEN_WIDTH,  kHeight(432) - 100)];
        [self addSubview:img];

        
        FloatingBallHeader *floatingBallHeader = [[FloatingBallHeader alloc] initWithFrame:CGRectMake(0, kNavigationBarHeight, SCREEN_WIDTH, (kHeight(432) - kNavigationBarHeight) - kHeight(200))];
        floatingBallHeader.delegate = self;
        floatingBallHeader.state = @"1";
  
        [self addSubview:floatingBallHeader];
        self.floatingBallHeader = floatingBallHeader;
        
        
        UIButton *certificateBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        certificateBtn.frame = CGRectMake(15.5, 78 - 64 + kNavigationBarHeight, 46, 41);
        [certificateBtn setImage:kImage(@"证书") forState:(UIControlStateNormal)];
        [self addSubview:certificateBtn];
        [certificateBtn addTarget:self action:@selector(buttonClick:) forControlEvents:(UIControlEventTouchUpInside)];
        certificateBtn.tag = 100;
        
        UIView *headPortraitView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 207/2, 72.5 - 64 + kNavigationBarHeight, 207, 39)];
        headPortraitView.backgroundColor = kWhiteColor;
        kViewRadius(headPortraitView, 39/2);
        headPortraitView.alpha = 0.3;
        [self addSubview:headPortraitView];
        
        UIImageView *headImg = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 207/2 + 4.5, 72.5 - 64 + kNavigationBarHeight + 4.5, 30, 30)];
        kViewBorderRadius(headImg, 15, 1, kTabbarColor);
//        headImg.image = kImage(@"头像");
//        ;
//        NSString * str = [[TLUser user].photo convertImageUrl];
        [headImg sd_setImageWithURL:[NSURL URLWithString:[[TLUser user].photo convertImageUrl]] placeholderImage:kImage(@"头像")];
        [self addSubview:headImg];
        
        UILabel *nameLbl = [UILabel labelWithFrame:CGRectMake(headImg.xx + 7.5, 72.5 - 64 + kNavigationBarHeight, SCREEN_WIDTH - headImg.xx - 7.5 - 5, 39) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(15) textColor:kHexColor(@"#23AD8C")];
        nameLbl.text = @"礼物";
        [self addSubview:nameLbl];
        
        
        NSArray *iconImgArray = @[@"地图",@"道具",@"攻略"];
        for (int i = 0; i < iconImgArray.count; i ++) {
            UIButton *iconBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
            iconBtn.frame = CGRectMake(18 + i%iconImgArray.count * 56.5, kHeight(432) - 50.5, 36, 38);
            [iconBtn setImage:kImage(iconImgArray[i]) forState:(UIControlStateNormal)];
            [iconBtn addTarget:self action:@selector(buttonClick:) forControlEvents:(UIControlEventTouchUpInside)];
            iconBtn.tag = 101 + i;
            [self addSubview:iconBtn];
        }
        
        UIButton *emotionalStoryBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        emotionalStoryBtn.frame = CGRectMake(SCREEN_WIDTH - 75, kHeight(432) - 59, 58, 47);
        [emotionalStoryBtn setImage:kImage(@"情感故事") forState:(UIControlStateNormal)];
        [emotionalStoryBtn addTarget:self action:@selector(buttonClick:) forControlEvents:(UIControlEventTouchUpInside)];
        emotionalStoryBtn.tag = 105;
        [self addSubview:emotionalStoryBtn];
        
    }
    return self;
}


-(void)setEnergyModels:(NSMutableArray<MyTreeEnergyModel *> *)energyModels
{
    _energyModels = energyModels;
    NSMutableArray * array = [NSMutableArray array];
    for (int i = 0; i < energyModels.count; i++) {
        MyTreeEnergyModel * model = energyModels[i];
        
        [array addObject:@{@"number":model.quantity,@"name":model.status}];
        
    }
    self.floatingBallHeader.dataList = array;
    NSLog(@"self.floatingBallHeader.dataList = %@",self.floatingBallHeader.dataList);
}

-(void)setModel:(PersonalCenterModel *)model{
    
    if ([model.isShelter isEqualToString:@"1"]) {
        
        img.image = kImage(@"保护罩");
    }
}

-(void)buttonClick:(UIButton *)sender
{
    NSLog(@"%s",__func__);
    [_delegate MyTreeHeadButton:sender.tag - 100];
}

- (void)floatingBallHeader:(FloatingBallHeader *)floatingBallHeader didPappaoAtIndex:(NSInteger)index isLastOne:(BOOL)isLastOne {
    
    MyTreeEnergyModel * model = self.energyModels[index];
    
//    if ([self.delegate respondsToSelector:@selector(floatingBallHeader:didPappaoAtIndex:isLastOne:)]) {
    [self.delegate paopaoclick:model];
//    }
    
//    TLNetworking * http = [[TLNetworking alloc]init];
//    http.code = @"629350";
//    http.parameters[@"code"] = model.code;
//    http.parameters[@"userId"] = [TLUser user].userId;
//    [http postWithSuccess:^(id responseObject) {
//        [TLAlert alertWithSucces:@"收取成功!"];
//    } failure:^(NSError *error) {
//
//    }];
    
    
    
//    NSLog(@"点了%zd", index);
//    if (isLastOne) {
//
//
//    }
    
}



@end
