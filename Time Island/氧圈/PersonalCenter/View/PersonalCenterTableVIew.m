//
//  PersonalCenterTableVIew.m
//  Time Island
//
//  Created by 郑勤宝 on 2019/1/28.
//  Copyright © 2019 ChengLian. All rights reserved.
//

#import "PersonalCenterTableVIew.h"


#import "FriendsTreeHeadCell.h"
#define FriendsTreeHead @"FriendsTreeHeadCell"
#import "EnergyCompeteCell.h"
#define EnergyCompete @"EnergyCompeteCell"
#import "HisDynamicCell.h"
#define HisDynamic @"HisDynamicCell"
#import "PersonalCenterCell.h"
#define PersonalCenter @"PersonalCenterCell"
#import "NotAdoptedCell.h"
#define NotAdopted @"NotAdoptedCell"
#import "PersonalCenterExpressionCell.h"
#define PersonalCenterExpression @"PersonalCenterExpressionCell"

@interface PersonalCenterTableVIew()<UITableViewDelegate, UITableViewDataSource,FriendsTreeHeadDelegate>
{
    UIButton *selectBtn;
    UIView *lineView;
}

@end

@implementation PersonalCenterTableVIew

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    if (self = [super initWithFrame:frame style:style]) {
        
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[FriendsTreeHeadCell class] forCellReuseIdentifier:FriendsTreeHead];
        [self registerClass:[EnergyCompeteCell class] forCellReuseIdentifier:EnergyCompete];
        [self registerClass:[HisDynamicCell class] forCellReuseIdentifier:HisDynamic];
        [self registerClass:[PersonalCenterCell class] forCellReuseIdentifier:PersonalCenter];
        [self registerClass:[NotAdoptedCell class] forCellReuseIdentifier:NotAdopted];
        [self registerClass:[PersonalCenterExpressionCell class] forCellReuseIdentifier:PersonalCenterExpression];
        
//        self.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    
    return self;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dynamicArray.count + 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        if (self.models.count > 0) {
            return self.models.count;
        }
        return 1;
    }
    NSArray *dynamicArray = self.dynamicArray[section - 1];
    return dynamicArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    PersonalCenterCell
    
    if (indexPath.section == 0) {
        if (self.models.count > 0) {
            PersonalCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:PersonalCenter forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.models = self.models[indexPath.row];
            return cell;
        }else
        {
            NotAdoptedCell *cell = [tableView dequeueReusableCellWithIdentifier:NotAdopted forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        
    }
    
    NSArray *dynamicArray = self.dynamicArray[indexPath.section - 1];
    DynamicModel *model = [DynamicModel mj_objectWithKeyValues:dynamicArray[indexPath.row]];
    
    if ([model.type isEqualToString:@"7"] || [model.type isEqualToString:@"4"]) {
        PersonalCenterExpressionCell *cell = [tableView dequeueReusableCellWithIdentifier:PersonalCenterExpression forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.dynamicModel = model;
        
        
        return cell;
    }
    
    
    HisDynamicCell *cell = [tableView dequeueReusableCellWithIdentifier:HisDynamic forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row == dynamicArray.count - 1) {
        cell.bottomLineView.hidden = YES;
    }else
    {
        cell.bottomLineView.hidden = NO;
    }
    
    cell.dynamicModel = model;
    
    
    return cell;
    
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        if(self.models.count > 0)
        {
            return 70;
        }
        return 150;
    }
    NSArray *dynamicArray = self.dynamicArray[indexPath.section - 1];
    DynamicModel *model = [DynamicModel mj_objectWithKeyValues:dynamicArray[indexPath.row]];
    if ([model.type isEqualToString:@"7"] || [model.type isEqualToString:@"4"]) {
        return 65;
    }
    return 48;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.refreshDelegate refreshTableView:self didSelectRowAtIndexPath:indexPath];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section >= 1) {
        
        
        return 35;
    }
    return 0.001;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (section >= 1) {
        UIView *headerView = [UIView new];
        
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 35)];
        backView.backgroundColor = kWhiteColor;
        [headerView addSubview:backView];
        NSArray *dynamicArray = self.dynamicArray[section - 1];
        UILabel *nameLabel = [UILabel labelWithFrame:CGRectMake(15, 6, SCREEN_WIDTH - 30, 18) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGboldfont(18) textColor:kTextBlack];
        if (dynamicArray.count > 0) {
            DynamicModel *model = [DynamicModel mj_objectWithKeyValues:dynamicArray[0]];
            
           
            
            NSDate *currentDate = [NSDate date];//获取当前时间，日期
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8]];
            [dateFormatter setDateFormat:@"YYYY-MM-dd"];
            NSString *dateString = [dateFormatter stringFromDate:currentDate];
            
            if ([dateString isEqualToString:model.time]) {
                nameLabel.text = @"今天";
            }
            else
            {
                NSString *time = [model.time substringWithRange:NSMakeRange(5, model.time.length - 5)];
                nameLabel.text = time;
            }
            
        }
        
        [headerView addSubview:nameLabel];
        
        UIView *roundView = [[UIView alloc]initWithFrame:CGRectMake(30, nameLabel.yy + 5 , 6, 6)];
        roundView.backgroundColor = kHexColor(@"#CCCCCC");
        kViewRadius(roundView, 3);
        [backView addSubview:roundView];
        
        return headerView;
    }
    
    return nil;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        
        
        UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 62.5)];
        
        footView.backgroundColor = kWhiteColor;
        
        UIView *footlineView = [[UIView alloc]initWithFrame:CGRectMake(15, 21, 3, 15)];
        footlineView.backgroundColor = kHexColor(@"#23AD8C");
        kViewRadius(footlineView, 1.5);
        [footView addSubview:footlineView];
        
        UILabel *nameLabel = [UILabel labelWithFrame:CGRectMake(footlineView.xx + 6, 20, SCREEN_WIDTH - footlineView.xx - 21, 17) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGboldfont(17) textColor:kTextBlack];
        nameLabel.text = [LangSwitcher switchLang:@"TA的动态" key:nil];
        [footView addSubview:nameLabel];
        
        return footView;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 0) {
        return 62.5;
    }
    return 0.001;
}


@end
