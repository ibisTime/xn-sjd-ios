//
//  CalendarCustomVC.m
//  Time Island
//
//  Created by shaojianfei on 2019/1/15.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "CalendarCustomVC.h"
//#import <FSCalendar.h>
//#import "LunarFormatter.h"
#import <EventKit/EventKit.h>
#import "CustomCalenderView.h"
@interface CalendarCustomVC ()

@property (nonatomic ,strong) UIView *content;

@property (nonatomic ,strong) UILabel *titleLab;
@property (nonatomic ,strong) CustomCalenderView *cusCalendar;

@property (strong, nonatomic) UILabel* SignLab;
@property (assign, nonatomic) NSInteger SignCount;

@property (strong, nonatomic) NSDateFormatter *dateFormatter;
@property (strong, nonatomic) NSDate *minimumDate;
@property (strong, nonatomic) NSDate *maximumDate;
@property (strong, nonatomic) NSCache *cache;
@property (assign, nonatomic) BOOL showsLunar;
@property (assign, nonatomic) BOOL showsEvents;
//@property (strong, nonatomic) LunarFormatter *lunarFormatter;
@property (strong, nonatomic) NSArray<EKEvent *> *events;
//签到列表
//@property (strong, nonatomic) NSMutableArray *signInList;
/**
 签到按钮
 */
@property (strong,nonatomic) UIButton *signBtn;

/**
 记录年月(正式使用时,不需要此属性)
 */
@property (strong,nonatomic) NSString *dateStr;

@property (nonatomic,strong) NSArray * RuleArray;

@property (nonatomic,strong) NSDictionary * dic;

//@property (nonatomic,strong) UILabel *signCount;


@end

@implementation CalendarCustomVC
{
    NSInteger _count;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getgift];
    self.navigationController.navigationBarHidden = YES;
    self.navigationController.navigationBar.shadowImage = [UIImage new];
}

//如果仅设置当前页导航透明，需加入下面方法
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
    //    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}
#pragma mark - <lazy>

//- (NSMutableArray *)signInList{
//    if (!_signInList) {
//        _signInList = [NSMutableArray array];
//    }
//    return _signInList;
//}

//- (LunarFormatter *)lunarFormatter{
//    if (!_lunarFormatter) {
//        _lunarFormatter = [[LunarFormatter alloc] init];
//    }
//    return _lunarFormatter;
//}

- (NSDateFormatter *)dateFormatter{
    if (!_dateFormatter) {
        _dateFormatter = [[NSDateFormatter alloc]init];
        _dateFormatter.dateFormat = @"yyyy-MM-dd";
    }
    return _dateFormatter;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getgift];
    [self getSign];
    [self getcontinue];
    
    [self initTopView];
    [self initCalendar];

    
}

- (void)initCalendar
{
    NSUInteger dayCount = [self getNumberOfDaysInMonth]; //一个月的总天数
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    NSDate * currentDate = [NSDate date];
    [formatter setDateFormat:@"yyyy-MM"];
    NSString * str = [formatter stringFromDate:currentDate];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSMutableArray * allDaysArray = [[NSMutableArray alloc] init];
    for (NSInteger i = 1; i <= dayCount; i++) {
        NSString * sr = [NSString stringWithFormat:@"%@-%ld",str,i];
        NSDate *suDate = [formatter dateFromString:sr];
        [allDaysArray addObject:[self getweekDayWithDate:suDate]];
    }
    NSLog(@"allDaysArray %@",allDaysArray);
    
    
    // Do any additional setup after loading the view.
    CustomCalenderView *calenderView = [[CustomCalenderView alloc]initWithFrame:CGRectMake(15, self.content.yy-30, SCREEN_WIDTH - 30, (SCREEN_WIDTH - 30)/7 * 6)];
    self.cusCalendar = calenderView;
    calenderView.allDaysArray = allDaysArray;
    calenderView.dayLength = dayCount;
    kViewBorderRadius(calenderView, 5, 1, kLineColor);
    [self.view addSubview:calenderView];

    
    UIButton * signButton = [UIButton buttonWithTitle:@"马上签到" titleColor:kWhiteColor backgroundColor:RGB(253, 103, 103) titleFont:15];
    [self.view addSubview:signButton];
    kViewRadius(signButton, 5);
    signButton.frame = CGRectMake(35, calenderView.yy+30, kScreenWidth-70, 50);
    [signButton addTarget:self action:@selector(signInAction:) forControlEvents:UIControlEventTouchUpInside];
    [signButton setBackgroundColor:kLightGreyColor forState:UIControlStateDisabled];
    
    
}


- (NSInteger)getNumberOfDaysInMonth
{
    NSCalendar * calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian]; // 指定日历的算法 NSGregorianCalendar - ios 8
    NSDate * currentDate = [NSDate date];
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit: NSCalendarUnitMonth forDate:currentDate];
    return range.length;
}


/**
 *  获得某天的数据
 *
 *  获取指定的日期是星期几
 */
- (id) getweekDayWithDate:(NSDate *) date
{
    NSCalendar * calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar]; // 指定日历的算法
    NSDateComponents *comps = [calendar components:NSWeekdayCalendarUnit fromDate:date];
    return @([comps weekday]);
    
}

//点击签到按钮的Action
- (void)signInAction:(UIButton *)btn{
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = @"805140";
    http.parameters[@"userId"] = [TLUser user].userId;
    [http postWithSuccess:^(id responseObject) {


        [self getSign];
    } failure:^(NSError *error) {
        
    }];
    
}
//从网络获取所有签到结果
- (void)getSign{

    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = @"805146";
    http.parameters[@"userId"] = [TLUser user].userId;
    http.parameters[@"createStartDatetime"] = [NSString stringWithFormat:@"%@",self.minimumDate];
    http.parameters[@"createEndDatetime"] = [NSString stringWithFormat:@"%@",self.maximumDate];
    [http postWithSuccess:^(id responseObject) {
//        weakSelf.signInList = responseObject[@"data"][0][@"signResList"];
//        weakSelf.SignCount = weakSelf.signInList.count;
        
        NSMutableArray *dataArrayCache = [NSMutableArray array];
        NSArray *array = responseObject[@"data"];
        
        NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
        dateFormatter.dateFormat=@"yyyy-MM-dd";
        
        for (int i = 0; i < array.count; i ++) {
            NSArray *timeArray = array[i][@"signResList"];
            for (int j = 0; j < timeArray.count; j ++) {
                NSString * str = [timeArray[j] convertDate];
                [dataArrayCache addObject:str];
            }
        }
        
        self.cusCalendar.selectArray = dataArrayCache;

    } failure:^(NSError *error) {
    }];
}




- (void)initTopView
{

     UIView *content = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 350)];
    self.content = content;
    content.backgroundColor = kCalendarColor;
    [self.view addSubview:content];
    UILabel *Title = [UILabel labelWithTitle:@"签到" frame:CGRectMake((kScreenWidth-100)/2, kStatusBarHeight+10, 100, 31)];
    self.titleLab = Title;
    Title.textColor = kWhiteColor;
    Title.font = [UIFont systemFontOfSize:18];
    Title.backgroundColor = kClearColor;
    [content addSubview:Title];
    UIButton *backButton = [UIButton buttonWithImageName:@"返回白色"];
    backButton.frame = CGRectMake(0, kStatusBarHeight+10, 60, 30);
    [content addSubview:backButton];
    [backButton addTarget:self action:@selector(backToTopView) forControlEvents:UIControlEventTouchUpInside];
}

- (void)initSignedView
{
    
    CGFloat WIDTH = 0.0;
    NSArray *cache = [[NSUserDefaults standardUserDefaults] objectForKey:@"arrayDate"];
    UILabel *signLab = [UILabel labelWithBackgroundColor:kClearColor textColor:kWhiteColor font:24];
    signLab.text = @"每日签到";
    signLab.frame = CGRectMake(10, self.titleLab.yy+30, 120, 30);
    [self.content addSubview:signLab];
    
    UILabel *signLab2 = [UILabel labelWithBackgroundColor:kClearColor textColor:kWhiteColor font:14];
    signLab2.text = @"连续签到越多,奖励越丰富";
    signLab2.frame = CGRectMake(10, signLab.yy+15, 180, 22);
    [self.content addSubview:signLab2];
    
    
    UILabel *signCount = [UILabel labelWithBackgroundColor:kClearColor textColor:kWhiteColor font:12];
    signCount.textAlignment = NSTextAlignmentCenter;
    signCount.text = [NSString stringWithFormat: @"  本月已连续签到%@天, 累计%@天",self.dic[@"continueSignCount"],self.dic[@"monthSignCount"]];
    signCount.frame = CGRectMake(kScreenWidth-kWidth(200), self.titleLab.yy+30, kWidth(185), 23);
    signCount.textColor = kWhiteColor;
//    self.signCount = signCount;
    [self.content addSubview:signCount];
    
    
    signCount.layer.cornerRadius = 12;
    signCount.clipsToBounds = YES;
    signCount.backgroundColor = RGB(25, 118, 112);
    signCount.centerY = signLab.centerY;
    self.SignLab = signCount;
    
    
    UIView *totleView = [UIView new];
    totleView.backgroundColor = RGB(86, 185, 168);
    totleView.layer.cornerRadius = 2.5;
    totleView.clipsToBounds = YES;
    [self.content addSubview:totleView];
    
    
    UIView *progressView = [UIView new];
    progressView.backgroundColor = kWhiteColor;
    progressView.layer.cornerRadius = 2.5;
    progressView.clipsToBounds = YES;
    [self.content addSubview:progressView];
//    CGFloat totalWidth = kScreenWidth-40;
//    CGFloat marge = (totalWidth - 6*23)/5;
    CGFloat buttonW = kScreenWidth-20;
    buttonW = (buttonW - 44*6)/5;
    
    for (int i = 0; i < self.RuleArray.count; i++) {
        UIButton *button = [UIButton buttonWithImageName:@"签到-礼物" cornerRadius:11.5];
        button.frame = CGRectMake(15 + i%self.RuleArray.count*(SCREEN_WIDTH - 30)/self.RuleArray.count + (SCREEN_WIDTH - 30)/self.RuleArray.count/2-6-5.5, signLab2.yy+20, 23, 23);
        [self.content addSubview:button];
        [button setBackgroundImage:kImage(@"签到-礼物") forState:UIControlStateNormal];
        [button setBackgroundColor:RGB(86, 185, 168) forState:UIControlStateNormal];
        
        
        UIView *circle = [UIView new];
        circle.layer.cornerRadius = 6;
        circle.clipsToBounds = YES;
        circle.tag = 1000 + i;
        circle.frame = CGRectMake(15 + i%self.RuleArray.count*(SCREEN_WIDTH - 30)/self.RuleArray.count + (SCREEN_WIDTH - 30)/self.RuleArray.count/2-6, button.yy+5, 12, 12);
        [self.content addSubview:circle];
        circle.tag = i+100;
        
        UILabel *dayLab = [UILabel labelWithBackgroundColor:kClearColor textColor:kWhiteColor font:14];
        [self.content addSubview:dayLab];
        dayLab.frame = CGRectMake(16+i%self.RuleArray.count*(SCREEN_WIDTH - 32)/self.RuleArray.count, circle.yy + 6, 40, 23);
        dayLab.numberOfLines = 0;
        
        if (self.RuleArray) {
            dayLab.text = [NSString stringWithFormat:@"%@",[ self.RuleArray[i][@"ckey"] stringByReplacingOccurrencesOfString:@"DAYS" withString:@"天"]];
        }

        UIButton *score = [UIButton buttonWithTitle:@"" titleColor:kWhiteColor backgroundColor:RGB(25, 118, 112) titleFont:11];
        [self.content addSubview:score];
        score.frame = CGRectMake(16+i%self.RuleArray.count*(SCREEN_WIDTH - 32)/self.RuleArray.count, dayLab.yy+8, (SCREEN_WIDTH - 32)/self.RuleArray.count - 2, 24);
        score.layer.cornerRadius = 3;
        score.clipsToBounds = YES;
        score.titleLabel.numberOfLines = 0;
        if ([self.RuleArray[i][@"remark"] containsString:@"积分"]) {
            [score setTitle:[NSString stringWithFormat:@"%@积分",self.RuleArray[i][@"cvalue"]] forState:UIControlStateNormal];
        }else
        {
            [score setTitle:[NSString stringWithFormat:@"%@碳泡泡",self.RuleArray[i][@"cvalue"]] forState:UIControlStateNormal];
        }
        
        NSInteger num = [self.dic[@"continueSignCount"] integerValue];
//        [self.dic[@"continueSignCount"] integerValue];
        
        if (num >= [self.RuleArray[i][@"ckey"] integerValue]) {
            circle.backgroundColor = kWhiteColor;
            if (num == [self.RuleArray[i][@"ckey"] integerValue]) {
                WIDTH = i%self.RuleArray.count*(SCREEN_WIDTH - 30)/self.RuleArray.count + (SCREEN_WIDTH - 30)/self.RuleArray.count/2-6 + 12;
            }else
            {
                if (i < self.RuleArray.count-1) {
                    if(num > [self.RuleArray[i][@"ckey"] integerValue] && num < [self.RuleArray[i + 1][@"ckey"] integerValue])
                    {
                        WIDTH = i%self.RuleArray.count*(SCREEN_WIDTH - 30)/self.RuleArray.count + (SCREEN_WIDTH - 30)/self.RuleArray.count/2 + (SCREEN_WIDTH - 30)/self.RuleArray.count/([self.RuleArray[i + 1][@"ckey"] integerValue] - [self.RuleArray[i][@"ckey"] integerValue])*(num - [self.RuleArray[i][@"ckey"] integerValue]);
                    }
                }else
                {
                    WIDTH = SCREEN_WIDTH - 30;
                }
            }
        }else
        {
            if (num < [self.RuleArray[0][@"ckey"] integerValue]) {
                WIDTH = (SCREEN_WIDTH - 30)/self.RuleArray.count/[self.RuleArray[0][@"ckey"] integerValue]*num - 12;
            }
            circle.backgroundColor = RGB(86, 185, 168);
        }
    }
    totleView.frame = CGRectMake(15, signLab2.yy+25+3+23, kScreenWidth-30, 5);
    progressView.frame = CGRectMake(15, signLab2.yy+25+3+23, WIDTH, 5);
    UIView *view  = [self.view viewWithTag:100];
    view.backgroundColor = kWhiteColor;
}

-(void)getgift{
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = @"630045";
    http.parameters[@"start"] = @(1);
    http.parameters[@"limit"] = @(10);
    http.parameters[@"type"] = @"SIGN_RULE";
    http.parameters[@"orderColumn"] = @"id";
    http.parameters[@"orderDir"] = @"asc";
    [http postWithSuccess:^(id responseObject) {
        self.RuleArray = responseObject[@"data"][@"list"];
        [self initSignedView];
    } failure:^(NSError *error) {
    }];
}


-(void)getcontinue{
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = @"629906";
    http.parameters[@"userId"] = [TLUser user].userId;
    http.parameters[@"createStartDatetime"] = self.minimumDate;
    http.parameters[@"createEndDatetime"] = self.maximumDate;
    [http postWithSuccess:^(id responseObject) {
        self.dic = (NSDictionary * )responseObject[@"data"];
        [self initSignedView];
    } failure:^(NSError *error) {
    }];
}

- (void)backToTopView
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
