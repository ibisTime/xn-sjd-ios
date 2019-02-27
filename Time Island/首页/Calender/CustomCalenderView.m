//
//  CustomCalenderView.m
//  Time Island
//
//  Created by 郑勤宝 on 2019/2/27.
//  Copyright © 2019 ChengLian. All rights reserved.
//

#import "CustomCalenderView.h"
#import "CalenderCollCell.h"
@interface CustomCalenderView()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic , strong)NSString *YearMonth;
@end

@implementation CustomCalenderView

-(UICollectionView *)collectionView{
    if (_collectionView==nil) {
        UICollectionViewFlowLayout *flowayout = [[UICollectionViewFlowLayout alloc]init];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 30, (SCREEN_WIDTH - 30)/7 * 6) collectionViewLayout:flowayout];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.backgroundColor = kWhiteColor;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        [_collectionView registerClass:[CalenderCollCell class] forCellWithReuseIdentifier:@"CalenderColl"];
    }
    return _collectionView;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.YearMonth = [self getDateYearMonth];
        [self addSubview:self.collectionView];
    }
    return self;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

#pragma mark------CollectionView的代理方法
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        return 7;
    }
    
    return [self.allDaysArray[0] integerValue] + self.allDaysArray.count-1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        CalenderCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CalenderColl" forIndexPath:indexPath];
        NSArray *array = @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
        cell.timeLbl.text = array[indexPath.row];
        
        return cell;
    }
    CalenderCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CalenderColl" forIndexPath:indexPath];
    if (indexPath.row >= [self.allDaysArray[0] integerValue]-1) {
        NSString *time = [NSString stringWithFormat:@"%ld",indexPath.row - [self.allDaysArray[0] integerValue] + 2];
        cell.timeLbl.text = time;
        
        NSString *timeStr = [NSString stringWithFormat:@"%@-%@",self.YearMonth,time];

        NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
        dateFormatter.dateFormat=@"yyyy-mm-dd";
        NSDate *date1 = [dateFormatter dateFromString:timeStr];
        for (int i = 0; i < _selectArray.count; i ++) {
            NSDate *date2 = [dateFormatter dateFromString:_selectArray[i]];
            BOOL isSelect = [self isSameDay:date1 date2:date2];
            if (isSelect == YES) {
                cell.timeLbl.backgroundColor = kTabbarColor;
                cell.timeLbl.textColor = kWhiteColor;
            }
        }
    }else
    {
        cell.timeLbl.text = @"";
    }
    
    return cell;
}

- (BOOL)isSameDay:(NSDate*)date1 date2:(NSDate*)date2
{
    NSCalendar* calendar = [NSCalendar currentCalendar];
    
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
    NSDateComponents* comp1 = [calendar components:unitFlags fromDate:date1];
    NSDateComponents* comp2 = [calendar components:unitFlags fromDate:date2];
    
    return [comp1 day]   == [comp2 day] &&
    [comp1 month] == [comp2 month] &&
    [comp1 year]  == [comp2 year];
    
}

- (NSString *)getDateYearMonth {
    
    NSDate *newDate = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:newDate];
    NSInteger year = [dateComponent year];
    NSInteger month = [dateComponent month];
    return [NSString stringWithFormat:@"%ld-%ld",year,month];
    
}


-(void)setSelectArray:(NSArray *)selectArray
{
    _selectArray = selectArray;
    [self.collectionView reloadData];
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.01;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    
    return 0.01;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((SCREEN_WIDTH - 30)/7-1,  (SCREEN_WIDTH - 30)/7-1);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(SCREEN_WIDTH, 0.001);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeMake(SCREEN_WIDTH, 0.001);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}




@end
