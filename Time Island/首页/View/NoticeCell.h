//
//  NoticeCell.h
//  Time Island
//
//  Created by shaojianfei on 2019/1/14.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface NoticeCell : BaseTableViewCell
@property (nonatomic ,strong) UILabel *moreLab;

@property (nonatomic ,strong) UIImageView *iconImage;
@property (nonatomic ,strong) UILabel *titleLab;
@property (nonatomic ,strong) UILabel *timeLab;
@property (nonatomic ,strong) UILabel *detailLab;

@end
