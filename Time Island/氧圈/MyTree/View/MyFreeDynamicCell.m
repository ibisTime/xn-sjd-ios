//
//  MyFreeDynamicCell.m
//  Time Island
//
//  Created by 郑勤宝 on 2019/1/10.
//  Copyright © 2019 ChengLian. All rights reserved.
//

#import "MyFreeDynamicCell.h"

@implementation MyFreeDynamicCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
//        for (int i = 0; i < 6; i ++) {
//            UIButton *dynamicBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
//            dynamicBtn.frame = CGRectMake(SCREEN_WIDTH/6/2 - 20 + i%6*SCREEN_WIDTH/6, 15, 40, 40);
//            [dynamicBtn setImage:kImage(@"头像") forState:(UIControlStateNormal)];
//            [dynamicBtn addTarget:self action:@selector(dynamicBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
//            dynamicBtn.tag = 100 + i;
//            [self addSubview:dynamicBtn];
//
//
//            UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(26-2, 21 - 2, 22, 22)];
//            bottomView.backgroundColor = kWhiteColor;
//            kViewRadius(bottomView, 10);
//            [dynamicBtn addSubview:bottomView];
//
//
//            UILabel *numLbl = [UILabel labelWithFrame:CGRectMake(2, 2, 18, 18) textAligment:(NSTextAlignmentCenter) backgroundColor:kHexColor(@"#23AD8C") font:FONT(8) textColor:kWhiteColor];
//            numLbl.text = @"5g";
//            kViewRadius(numLbl, 9);
//            [bottomView addSubview:numLbl];
//
//        }
        
    }
    return self;
}

-(void)dynamicBtnClick:(UIButton *)sender
{
    [_delegate MyFreeDynamicButton:sender.tag];
}

-(void)setDynamicPhotoModels:(NSMutableArray<DynamicModel *> *)DynamicPhotoModels{
    _DynamicPhotoModels=DynamicPhotoModels;
    int count;
    if (DynamicPhotoModels.count > 6) {
        count = 6;
    }
    else{
        count = (int)DynamicPhotoModels.count;
    }
    
    
    for (int i = 0; i < count; i ++) {
        DynamicModel * model = DynamicPhotoModels[i];
        
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/6/2 - 20 + i%6*SCREEN_WIDTH/6, 15, 40, 40)];
        
        UIButton *dynamicBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        dynamicBtn.frame = CGRectMake(SCREEN_WIDTH/6/2 - 20 + i%6*SCREEN_WIDTH/6, 15, 40, 40);
//        [dynamicBtn setImage:kImage(@"头像") forState:(UIControlStateNormal)];
        
        if (model.userInfo[@"photo"]) {
            UIImageView * image = [[UIImageView alloc]init];
             [image sd_setImageWithURL:[NSURL URLWithString:[model.userInfo[@"photo"] convertImageUrl]] placeholderImage:kImage(@"头像")];
            [dynamicBtn setImage:image.image forState:(UIControlStateNormal)];
        }
        else{
            [dynamicBtn setImage:kImage(@"头像") forState:(UIControlStateNormal)];
        }
       
        [dynamicBtn addTarget:self action:@selector(dynamicBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
        dynamicBtn.tag = 100 + i;
        
        kViewRadius(dynamicBtn, 20);
        [self addSubview:dynamicBtn];
        
        
        UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(26-2, 21 - 2, 22, 22)];
        bottomView.backgroundColor = kWhiteColor;
        kViewRadius(bottomView, 10);
//        [dynamicBtn addSubview:bottomView];
        [view addSubview:bottomView];
        
        
        UILabel *numLbl = [UILabel labelWithFrame:CGRectMake(2, 2, 18, 18) textAligment:(NSTextAlignmentCenter) backgroundColor:kHexColor(@"#23AD8C") font:FONT(8) textColor:kWhiteColor];
//        numLbl.text = @"5g";
        numLbl.text = model.quantity;
        kViewRadius(numLbl, 9);
        [bottomView addSubview:numLbl];
//        [self addSubview:numLbl];
        
        
        [self addSubview:view];
    }
}

@end
