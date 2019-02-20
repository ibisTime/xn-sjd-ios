//
//  FriendsTreeHeadCell.m
//  Time Island
//
//  Created by 郑勤宝 on 2019/1/11.
//  Copyright © 2019 ChengLian. All rights reserved.
//

#import "FriendsTreeHeadCell.h"

@implementation FriendsTreeHeadCell{
    UIImageView *headImg;
    UILabel *nameLbl;
    
    
}



-(DonationAnimationView *)animationView
{
    if (!_animationView) {
        _animationView = [[DonationAnimationView alloc]initWithFrame:CGRectMake(kWidth(598)/2, kHeight(550)/2, 45, 70)];
        _animationView.alpha = 0;
    }
    return _animationView;
}
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
        
    
        
        UIView *headPortraitView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 207/2, 72.5 - 64 + kNavigationBarHeight, 207, 39)];
        headPortraitView.backgroundColor = kWhiteColor;
        kViewRadius(headPortraitView, 39/2);
        headPortraitView.alpha = 0.3;
        [self addSubview:headPortraitView];
        
        headImg = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 207/2 + 4.5, 72.5 - 64 + kNavigationBarHeight + 4.5, 30, 30)];
        kViewBorderRadius(headImg, 15, 1, kTabbarColor);
        headImg.image = kImage(@"头像");
        [self addSubview:headImg];
        
        nameLbl = [UILabel labelWithFrame:CGRectMake(headImg.xx + 7.5, 72.5 - 64 + kNavigationBarHeight, SCREEN_WIDTH - headImg.xx - 7.5 - 5, 39) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(15) textColor:kHexColor(@"#23AD8C")];
        nameLbl.text = @"1125g";
        [self addSubview:nameLbl];
        
        
        
        UIButton *mapBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        mapBtn.frame = CGRectMake(18 , kHeight(432) - 50.5, 36, 38);
        [mapBtn setImage:kImage(@"地图") forState:(UIControlStateNormal)];
        [mapBtn addTarget:self action:@selector(buttonClick:) forControlEvents:(UIControlEventTouchUpInside)];
        mapBtn.tag = 100;
        [self addSubview:mapBtn];
        
        UIButton *barrageBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        barrageBtn.frame = CGRectMake(SCREEN_WIDTH - 35 - 36 - 36 , kHeight(432) - 50.5, 36, 38);
        [barrageBtn setImage:kImage(@"弹幕") forState:(UIControlStateNormal)];
        [barrageBtn addTarget:self action:@selector(buttonClick:) forControlEvents:(UIControlEventTouchUpInside)];
        barrageBtn.tag = 101;
        [self addSubview:barrageBtn];
        
        UIButton *donationBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        donationBtn.frame = CGRectMake(SCREEN_WIDTH - 15 - 36 , kHeight(432) - 50.5, 36, 38);
        [donationBtn setImage:kImage(@"捐赠红色") forState:(UIControlStateNormal)];
        [donationBtn addTarget:self action:@selector(buttonClick:) forControlEvents:(UIControlEventTouchUpInside)];
        donationBtn.tag = 102;
        [self addSubview:donationBtn];
        
        
        [self addSubview:self.animationView];
//        [self animationView];
        
       
    }
    return self;
}


-(void)setDonation:(NSInteger)donation
{
    if (donation == 100) {
        self.animationView.alpha = 1;
        CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
        CATransform3D scale1 = CATransform3DMakeScale(0.5, 0.5, 1);
        CATransform3D scale2 = CATransform3DMakeScale(1.6, 1.6, 1);
        CATransform3D scale3 = CATransform3DMakeScale(0.9, 0.9, 1);
        CATransform3D scale4 = CATransform3DMakeScale(1.0, 1.0, 1);
        NSArray *frameValues = [NSArray arrayWithObjects:[NSValue valueWithCATransform3D:scale1],[NSValue valueWithCATransform3D:scale2],[NSValue valueWithCATransform3D:scale3],[NSValue valueWithCATransform3D:scale4],nil];
        [animation setValues:frameValues];
        NSArray *frameTimes = [NSArray arrayWithObjects:[NSNumber numberWithFloat:0.0],[NSNumber numberWithFloat:0.5],[NSNumber numberWithFloat:0.8],[NSNumber numberWithFloat:0.9],nil];
        [animation setKeyTimes:frameTimes];
        animation.fillMode = kCAFillModeForwards;
        animation.duration = 0.5f;
        [self.animationView.layer addAnimation:animation forKey:@"DSPopUpAnimation"];
        
        
        dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC));
        dispatch_after(delayTime, dispatch_get_main_queue(), ^{
            //                [weakSelf delayMethod];
            [UIView animateWithDuration:2 animations:^{
                self.animationView.alpha = 0;
            }];
        });
    }
}

-(void)buttonClick:(UIButton *)sender
{
    [_delegate FriendsTreeHeadButton:sender.tag - 100];
}

- (void)floatingBallHeader:(FloatingBallHeader *)floatingBallHeader didPappaoAtIndex:(NSInteger)index isLastOne:(BOOL)isLastOne {
    NSLog(@"点了%zd", index);
    
    
    MyTreeEnergyModel * model = self.energyModels[index];
    [_delegate paopaoclick:model];
//    TLNetworking * http = [[TLNetworking alloc]init];
//    http.code = @"629350";
//    http.parameters[@"code"] = model.code;
//    http.parameters[@"userId"] = [TLUser user].userId;
//    [http postWithSuccess:^(id responseObject) {
//        [TLAlert alertWithSucces:@"收取成功!"];
//
//
    
//    if ([self.delegate respondsToSelector:@selector(floatingBallHeader:didPappaoAtIndex:isLastOne:)]) {
//        [self.delegate paopaoclick:model];
//    }
    [self.delegate paopaoclick:model];
    
    
//    TLNetworking * http = [[TLNetworking alloc]init];
//    http.code = @"629350";
//    http.parameters[@"code"] = model.code;
//    http.parameters[@"userId"] = [TLUser user].userId;
//    [http postWithSuccess:^(id responseObject) {
//        [TLAlert alertWithSucces:@"收取成功!"];
//    } failure:^(NSError *error) {
//
//    }];
    
    
    
    NSLog(@"点了%zd", index);
    if (isLastOne) {
        
        
    }
    if (isLastOne) {
        
        
    }
    
}
-(void)setModel:(PersonalCenterModel *)model{
    _model = model;
    [headImg sd_setImageWithURL:[NSURL URLWithString:[model.user[@"photo"] convertImageUrl]] placeholderImage:kImage(@"头像")];
}
-(void)setEnergyModels:(NSMutableArray<MyTreeEnergyModel *> *)energyModels{
    _energyModels = energyModels;
    NSMutableArray * array = [NSMutableArray array];
    for (int i = 0; i < energyModels.count; i++) {
        MyTreeEnergyModel * model = energyModels[i];
        
        [array addObject:@{@"number":model.quantity,@"name":model.status}];
        
    }
    self.floatingBallHeader.dataList = array;
    NSLog(@"self.floatingBallHeader.dataList = %@",self.floatingBallHeader.dataList);
}

-(void)setBarrageModel:(BarrageModel *)barrageModel
{
    CGSize size = [barrageModel.content sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:FONT(14),NSFontAttributeName,nil]];
    // 名字的H
    CGFloat nameW = size.width;
    _barrView = [[BarrageEncapsulationView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH, kHeight(432) - 100, nameW + 65, 40)];
    [self addSubview:_barrView];
    [UIView animateWithDuration:4 animations:^{
        self.barrView.frame = CGRectMake(- nameW - 65, kHeight(432) - 100, nameW + 65, 40);
        self.barrView.model = barrageModel;
    } completion:^(BOOL finished) {
        [self.barrView removeFromSuperview];
    }];
    
}

@end
