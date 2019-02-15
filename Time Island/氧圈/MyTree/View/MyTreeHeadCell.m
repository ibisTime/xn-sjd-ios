//
//  MyTreeHeadCell.m
//  Time Island
//
//  Created by 郑勤宝 on 2019/1/10.
//  Copyright © 2019 ChengLian. All rights reserved.
//

#import "MyTreeHeadCell.h"

@implementation MyTreeHeadCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIImageView *backImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,  kHeight(432))];
        backImg.image = kImage(@"树 跟背景");
        [self addSubview:backImg];
        
        FloatingBallHeader *floatingBallHeader = [[FloatingBallHeader alloc] initWithFrame:CGRectMake(0, kNavigationBarHeight, SCREEN_WIDTH, (kHeight(432) - kNavigationBarHeight) - kHeight(200))];
        floatingBallHeader.delegate = self;

//        floatingBallHeader.dataList = @[@{@"number":@"68g",@"name":@"BTC"},        @{@"number":@"68g",@"name":@"线下"}, @{@"number":@"2g",@"name":@"线下支付"}, @{@"number":@"268g",@"name":@"支付"},@{@"number":@"63g",@"name":@"线下支付"}, @{@"number":@"638g",@"name":@"线下"}, @{@"number":@"168g",@"name":@"线下支付"}];
        
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
        
        
        NSArray *iconImgArray = @[@"地图",@"道具",@"攻略",@"赠送"];
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
    NSMutableArray * array = [NSMutableArray array];
    for (int i = 0; i < energyModels.count; i++) {
        MyTreeEnergyModel * model = energyModels[i];
        
        [array addObject:@{@"number":model.quantity,@"name":model.status}];
        
    }
    self.floatingBallHeader.dataList = array;
    NSLog(@"self.floatingBallHeader.dataList = %@",self.floatingBallHeader.dataList);
}

-(void)buttonClick:(UIButton *)sender
{
    [_delegate MyTreeHeadButton:sender.tag - 100];
}

- (void)floatingBallHeader:(FloatingBallHeader *)floatingBallHeader didPappaoAtIndex:(NSInteger)index isLastOne:(BOOL)isLastOne {
    NSLog(@"点了%zd", index);
    if (isLastOne) {
        
        
    }
    
}

//-(void)getdata{
//    TLNetworking * http = [[TLNetworking alloc]init];
//    http.code = @"629355";
//    http.parameters[@"status"] = @"0";
//    http.parameters[@"limit"] = @(5);
//    http.parameters[@"start"] = @(1);
//    http.parameters[@"adoptTreeCode"] = self.model.code;
//    [http postWithSuccess:^(id responseObject) {
//        self.energyModels = [MyTreeEnergyModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"list"]];
//        for (int i = 0; i < self.energyModels.count; i++) {
//            MyTreeEnergyModel * model = self.energyModels[i];
////            [self.floatingBallHeader.dataList arrayByAddingObjectsFromArray:@[@{@"number":model.quantity,@"name":model.status}]];
//        }
//        NSLog(@"self.floatingBallHeader.dataList = %@",self.floatingBallHeader.dataList);
//    } failure:^(NSError *error) {
//        NSLog(@"%@",error);
//    }];
//}


//-(void)setModel:(PersonalCenterModel *)model{
//    _model = model;
//    [self getdata];
//}

@end
