//
//  BookVideoCell.h
//  Time Island
//
//  Created by shaojianfei on 2019/1/14.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "BookModel.h"

@interface BookVideoCell : BaseTableViewCell
@property (nonatomic ,strong) UILabel *moreLab;

@property (nonatomic ,strong) UIImageView *iconImage;

@property (nonatomic ,strong) UILabel *detailLab;

@property (nonatomic ,strong) UILabel *moneyLab;

@property (nonatomic ,strong) UILabel *timeLab;

@property (nonatomic ,strong) UILabel *collectLab;

@property (nonatomic ,strong) UILabel *praiseLab;
@property (nonatomic,strong) BookModel * BookModel;

@end
