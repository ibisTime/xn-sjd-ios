//
//  BookDetailHeadView.h
//  Time Island
//
//  Created by shaojianfei on 2019/1/15.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "BaseView.h"
#import "BookModel.h"
#import "PersonalCenterModel.h"


@interface BookDetailHeadView : BaseView
@property (nonatomic ,strong) UILabel *moreLab;

@property (nonatomic ,strong) UIImageView *iconImage;

@property (nonatomic ,strong) UILabel *detailLab;

@property (nonatomic ,strong) UILabel *moneyLab;

@property (nonatomic ,strong) UILabel *timeLab;

//@property (nonatomic ,strong) UILabel *collectLab;
//
//@property (nonatomic ,strong) UILabel *praiseLab;
@property (nonatomic,strong) BookModel * BookModel;
@property (nonatomic,strong) NSString * state;
@property (nonatomic , strong)PersonalCenterModel *model;
@property (nonatomic,strong) void (^ConnectBlock)(PersonalCenterModel * model);
@end
