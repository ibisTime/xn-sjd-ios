//
//  CalendarCustomVC.m
//  Time Island
//
//  Created by shaojianfei on 2019/1/15.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "CalendarCustomVC.h"
#import <FSCalendar.h>
#import "LunarFormatter.h"
#import <EventKit/EventKit.h>
@interface CalendarCustomVC ()<FSCalendarDataSource,FSCalendarDelegate>
@property (nonatomic ,strong) UIView *content;

@property (nonatomic ,strong) UILabel *titleLab;

@property (strong, nonatomic) NSCalendar *gregorian;
@property (weak  , nonatomic) FSCalendar *calendar;
@property (strong, nonatomic) UILabel* SignLab;
@property (assign, nonatomic) NSInteger SignCount;

@property (strong, nonatomic) NSDateFormatter *dateFormatter;
@property (strong, nonatomic) NSDate *minimumDate;
@property (strong, nonatomic) NSDate *maximumDate;
@property (strong, nonatomic) NSCache *cache;
@property (assign, nonatomic) BOOL showsLunar;
@property (assign, nonatomic) BOOL showsEvents;
@property (strong, nonatomic) LunarFormatter *lunarFormatter;
@property (strong, nonatomic) NSArray<EKEvent *> *events;
//签到列表
@property (strong, nonatomic) NSMutableArray *signInList;
/**
 签到按钮
 */
@property (strong,nonatomic) UIButton *signBtn;

/**
 记录年月(正式使用时,不需要此属性)
 */
@property (strong,nonatomic) NSString *dateStr;
@end

@implementation CalendarCustomVC
{
    NSInteger _count;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
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

- (NSMutableArray *)signInList{
    if (!_signInList) {
        _signInList = [NSMutableArray array];
    }
    return _signInList;
}

- (LunarFormatter *)lunarFormatter{
    if (!_lunarFormatter) {
        _lunarFormatter = [[LunarFormatter alloc] init];
    }
    return _lunarFormatter;
}

- (NSDateFormatter *)dateFormatter{
    if (!_dateFormatter) {
        _dateFormatter = [[NSDateFormatter alloc]init];
        _dateFormatter.dateFormat = @"yyyy-MM-dd";
    }
    return _dateFormatter;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTopView];
    [self initSignedView];
    [self initCalendar];
    [self calendarConfig];
    //1.加载缓存的日期,并选中
    [self getCache];
    //载入节假日
    [self loadCalendarEvents];
    //显示农历
    [self lunarItemClicked];
    //显示节假日
    [self eventItemClicked];
}

- (void)initCalendar
{
    
    //创建日历类
    FSCalendar *calendar = [[FSCalendar alloc] initWithFrame:CGRectMake(20, self.content.yy-30, kScreenWidth - 40, 300)];
    calendar.backgroundColor = [UIColor whiteColor];
    calendar.dataSource = self;
    calendar.delegate = self;
    //日历语言为中文
    calendar.locale = [NSLocale localeWithLocaleIdentifier:@"zh-CN"];
    //允许多选,可以选中多个日期
    calendar.allowsMultipleSelection = YES;
    //如果值为1,那么周日就在第一列,如果为2,周日就在最后一列
    calendar.firstWeekday = 1;
    //周一\二\三...或者头部的2017年11月的显示方式
    calendar.appearance.caseOptions = FSCalendarCaseOptionsHeaderUsesDefaultCase;
    [self.view addSubview:calendar];
    self.calendar = calendar;
    
    UIButton * signButton = [UIButton buttonWithTitle:@"马上签到" titleColor:kWhiteColor backgroundColor:RGB(253, 103, 103) titleFont:15];
    [self.view addSubview:signButton];
    signButton.frame = CGRectMake(35, calendar.yy+30, kScreenWidth-70, 45);
    [signButton addTarget:self action:@selector(signInAction:) forControlEvents:UIControlEventTouchUpInside];
    [signButton setBackgroundColor:kLightGreyColor forState:UIControlStateDisabled];
    
    
}

#pragma mark - <配置日历>
- (void)calendarConfig{
    //创建系统日历类
    self.gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    //获取日历要显示的日期范围
    NSArray *timeArray = [self getStartTimeAndFinalTime];
    self.dateStr = [timeArray[0] substringToIndex:7];

    //设置最小和最大日期(在最小和最大日期之外的日期不能被选中,日期范围如果大于一个月,则日历可翻动)
    self.minimumDate = [self.dateFormatter dateFromString:timeArray[0]];
    self.maximumDate = [self.dateFormatter dateFromString:timeArray[1]];
    self.calendar.accessibilityIdentifier = @"calendar";
    //title显示方式
    self.calendar.appearance.headerDateFormat = @"yyyy年MM月";
    //关闭字体自适应,设置字体大小\颜色
    self.calendar.appearance.adjustsFontSizeToFitContentSize = NO;
    self.calendar.appearance.subtitleFont = [UIFont systemFontOfSize:8];
    self.calendar.appearance.headerTitleColor = kBlackColor;
    self.calendar.appearance.weekdayTextColor = kBlackColor;
    self.calendar.appearance.selectionColor = RGB(35, 173, 140);
    //日历头部颜色
    self.calendar.calendarHeaderView.backgroundColor = kWhiteColor;
    self.calendar.calendarWeekdayView.backgroundColor = kWhiteColor;
}

//获取日历范围,让日历出现时就知道该显示哪个月了哪一页了(根据系统时间来获取)
-(NSArray *)getStartTimeAndFinalTime{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *datenow = [NSDate date];
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    NSDate *newDate=[formatter dateFromString:currentTimeString];
    double interval = 0;
    NSDate *firstDate = nil;
    NSDate *lastDate = nil;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    BOOL OK = [calendar rangeOfUnit:NSCalendarUnitMonth startDate:& firstDate interval:&interval forDate:newDate];
    if (OK) {
        lastDate = [firstDate dateByAddingTimeInterval:interval - 1];
    }else {
        return @[@"",@""];
    }
    NSString *firstString = [formatter stringFromDate: firstDate];
    NSString *lastString = [formatter stringFromDate: lastDate];
    //返回数据为日历要显示的最小日期firstString和最大日期lastString
    return @[firstString, lastString];
}
//加载缓存
- (void)getCache{
    //从缓存中先把数据取出来
    NSString *key = [NSString stringWithFormat:@"arrayDate"];
    NSMutableArray *cache = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    //允许用户选择,其实是允许系统来选中签到日期
    self.calendar.allowsSelection = YES;
    self.calendar.allowsMultipleSelection = YES;
    if (cache.count) {//如果cache里面有数据
        //选中日期,只有不在选中之列的才去选中它
        for (NSInteger i = 0; i<cache.count; i++) {
            if (![self.calendar.selectedDates containsObject:cache[i]]) {
                [self.calendar selectDate:cache[i]];
            }
        }
    }else{//如果cache里面没有数据,说明第一次启动
        //创建个可变数组储存进缓存(必要)
        NSMutableArray *cache = [NSMutableArray array];
        [[NSUserDefaults standardUserDefaults] setValue:cache forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    //选择完毕后关闭可选项,不让用户自己点
    self.calendar.allowsSelection = NO;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
}

//点击签到按钮的Action
- (void)signInAction:(UIButton *)btn{
//    btn.enabled = NO;
    //假设在这里网络请求签到成功,成功后需要重新请求签到所有结果
    if (_count>31) {
        NSLog(@"别点了");
        btn.enabled = NO;
        return;
    }else if (!_count){
        _count = 1;
    }
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *datenow = [NSDate date];
//    NSString *firstString = [formatter stringFromDate: datenow];
    
//
    NSString *dateStr = [NSString stringWithFormat:@"%@-%ld",self.dateStr,_count];
    _count++;
    [self.signInList addObject:dateStr];
    [self getSign];
}
//从网络获取所有签到结果
- (void)getSign{
    //配置日期缓存的key
    NSString *key = [NSString stringWithFormat:@"arrayDate"];
    
    //在这里假装网络请求所有的签到结果(signInList)成功了
    NSLog(@"%@",_signInList);
    //获取签到总数量
    self.SignCount = self.signInList.count;
    //常见临时数组dataArrayCache,用于存放签到结果(可能有的人觉得这一步不需要,但是咱们假设的签到结果里面只有纯日期,正式项目中可不一定如此)
    NSMutableArray *dataArrayCache = [NSMutableArray array];
    
    if (self.SignCount) {//如果请求的数据有效
        for (NSString *dateStr in _signInList) {
            //把所有签到数据取出来添加进临时数组
            NSDate *date = [self.dateFormatter dateFromString:dateStr];
            if(date){
                [dataArrayCache addObject:date];
            }
        }
        //用偏好设置保存签到数据到本地缓存
        [[NSUserDefaults standardUserDefaults] setValue:dataArrayCache forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
        //保存后重新加载缓存数据
        [self getCache];
    }
}
- (void)initTopView
{
    UIView *content = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kHeight(300))];
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
    UILabel *signLab = [UILabel labelWithBackgroundColor:kClearColor textColor:kWhiteColor font:24];
    signLab.text = @"每日签到";
    signLab.frame = CGRectMake(10, self.titleLab.yy+30, 120, 30);
    [self.content addSubview:signLab];
    
    UILabel *signLab2 = [UILabel labelWithBackgroundColor:kClearColor textColor:kWhiteColor font:14];
    signLab2.text = @"连续签到越多,奖励越丰富";
    signLab2.frame = CGRectMake(10, signLab.yy+15, 180, 22);
    [self.content addSubview:signLab2];
    UILabel *signCount = [UILabel labelWithBackgroundColor:kClearColor textColor:kWhiteColor font:12];
    signCount.text = @"  本月已连续签到3天, 累计5天";
    signCount.frame = CGRectMake(kScreenWidth-kWidth(200), self.titleLab.yy+30, kWidth(185), 23);
    signCount.textColor = kWhiteColor;
    [self.content addSubview:signCount];
    signCount.layer.cornerRadius = 12;
    signCount.clipsToBounds = YES;
    signCount.backgroundColor = RGB(25, 118, 112);
    signCount.centerY = signLab.centerY;
    self.SignLab = signCount;
    CGFloat totalWidth = kScreenWidth-40;
    CGFloat marge = (totalWidth - 6*23)/5;
    CGFloat buttonW = kScreenWidth-20;
    buttonW = (buttonW - 44*6)/5;
    for (int i = 0; i < 6; i++) {
        UIButton *button = [UIButton buttonWithImageName:@"签到-礼物" cornerRadius:11.5];
        button.frame = CGRectMake(20+i*marge+i*23, signLab2.yy+20, 23, 23);
        [self.content addSubview:button];
        [button setBackgroundImage:kImage(@"签到-礼物") forState:UIControlStateNormal];
        [button setBackgroundColor:RGB(86, 185, 168) forState:UIControlStateNormal];
        UIView *circle = [UIView new];
        circle.backgroundColor = RGB(86, 185, 168);
        circle.layer.cornerRadius = 6;
        circle.clipsToBounds = YES;
        circle.frame = CGRectMake(20+i*marge+i*23, button.yy+5, 12, 12);
        circle.centerX = button.centerX;
        [self.content addSubview:circle];
        circle.tag = i+100;
        UILabel *dayLab = [UILabel labelWithBackgroundColor:kClearColor textColor:kWhiteColor font:14];
        [self.content addSubview:dayLab];
        dayLab.frame = CGRectMake(20+i*marge+i*23, button.yy+25, 33, 23);
        if (i == 5) {
            dayLab.text = [NSString stringWithFormat:@"%d天",i*4];
        }else{
            dayLab.text = [NSString stringWithFormat:@"%d天",(i+1)*3];
        }

        UIButton *score = [UIButton buttonWithTitle:@"" titleColor:kWhiteColor backgroundColor:RGB(25, 118, 112) titleFont:11];
        [self.content addSubview:score];
        score.frame = CGRectMake(10+i*buttonW+i*44, dayLab.yy+8, 44, 19);
        score.layer.cornerRadius = 3;
        score.clipsToBounds = YES;
        if (i==0) {
            [score setTitle:@"15积分" forState:UIControlStateNormal];
        }else if (i==1)
        {
            [score setTitle:@"30积分" forState:UIControlStateNormal];

        }else{
            [score setTitle:[NSString stringWithFormat:@"%d积分",i*20] forState:UIControlStateNormal];

        }
    
    }
    UIView *totleView = [UIView new];
    totleView.backgroundColor = RGB(86, 185, 168);
    totleView.layer.cornerRadius = 2.5;
    totleView.clipsToBounds = YES;
    totleView.frame = CGRectMake(15, signLab2.yy+25+3+23, kScreenWidth-15, 5);
    [self.content addSubview:totleView];
    
    UIView *progressView = [UIView new];
    progressView.backgroundColor = kWhiteColor;
    progressView.layer.cornerRadius = 2.5;
    progressView.clipsToBounds = YES;
    progressView.frame = CGRectMake(15, signLab2.yy+25+3+23, 30, 5);
    [self.content addSubview:progressView];
    UIView *view  = [self.view viewWithTag:100];
    view.backgroundColor = kWhiteColor;
    
}
- (void)backToTopView
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
//显示农历
- (void)lunarItemClicked
{
    self.showsLunar = !self.showsLunar;
    [self.calendar reloadData];
}
//显示节日
- (void)eventItemClicked
{
    self.showsEvents = !self.showsEvents;
    [self.calendar reloadData];
}

//数据源方法,根据是否显示节日和农历
- (NSString *)calendar:(FSCalendar *)calendar subtitleForDate:(NSDate *)date
{
    if (self.showsEvents) {//如果要求显示节日
        EKEvent *event = [self eventsForDate:date].firstObject;
        if (event) {
            return event.title;
        }
    }
    if (self.showsLunar) {//如果要求显示农历
        return [self.lunarFormatter stringFromDate:date];
    }
    return nil;
}
//加载节日到日历中
- (void)loadCalendarEvents
{
    __weak typeof(self) weakSelf = self;
    EKEventStore *store = [[EKEventStore alloc] init];
    //请求访问日历
    [store requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
        //允许访问
        if(granted) {
            NSDate *startDate = self.minimumDate;
            NSDate *endDate = self.maximumDate;
            NSPredicate *fetchCalendarEvents = [store predicateForEventsWithStartDate:startDate endDate:endDate calendars:nil];
            NSArray<EKEvent *> *eventList = [store eventsMatchingPredicate:fetchCalendarEvents];
            NSArray<EKEvent *> *events = [eventList filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(EKEvent * _Nullable event, NSDictionary<NSString *,id> * _Nullable bindings) {
                return event.calendar.subscribed;
            }]];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if (!weakSelf) return;
                weakSelf.events = events;
                [weakSelf.calendar reloadData];
            });
            
        } else {
            
            // Alert
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"权限错误" message:@"获取节日事件需要权限呀大宝贝!" preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
            [self presentViewController:alertController animated:YES completion:nil];
        }
    }];
    
}
//根据日期来显示事件
- (NSArray<EKEvent *> *)eventsForDate:(NSDate *)date
{
    NSArray<EKEvent *> *events = [self.cache objectForKey:date];
    if ([events isKindOfClass:[NSNull class]]) {
        return nil;
    }
    NSArray<EKEvent *> *filteredEvents = [self.events filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(EKEvent * _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
        return [evaluatedObject.occurrenceDate isEqualToDate:date];
    }]];
    if (filteredEvents.count) {
        [self.cache setObject:filteredEvents forKey:date];
    } else {
        [self.cache setObject:[NSNull null] forKey:date];
    }
    return filteredEvents;
}

@end
