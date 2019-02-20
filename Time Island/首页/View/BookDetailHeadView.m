//
//  BookDetailHeadView.m
//  Time Island
//
//  Created by shaojianfei on 2019/1/15.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "BookDetailHeadView.h"

@implementation BookDetailHeadView{
    NSString * Name;
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kWhiteColor;
        [self initNoticeView];
     
    }
    return self;
}

- (void)initNoticeView
{
   
    UILabel *moreLab = [UILabel labelWithBackgroundColor:kClearColor textColor:RGB(0, 0, 0) font:18];
    moreLab.frame = CGRectMake(15, 20, kScreenWidth-30, 25);
    moreLab.textAlignment = NSTextAlignmentLeft;
    moreLab.text = @"我的第一次认养";
    self.moreLab = moreLab;
    [self addSubview:moreLab];
    [moreLab setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    UILabel *detailLab = [UILabel labelWithBackgroundColor:kClearColor textColor:kTextColor2 font:13];
    detailLab.frame = CGRectMake(15, moreLab.yy+11, 100, 24);
    detailLab.textAlignment = NSTextAlignmentLeft;
    detailLab.text = @"作者: 威震天";
    self.detailLab = detailLab;
    [self addSubview:detailLab];
    
    UILabel *moneyLab = [UILabel labelWithBackgroundColor:kClearColor textColor:kHexColor(@"#23AD8C") font:13];
    moneyLab.frame = CGRectMake(kScreenWidth-155, moreLab.yy+10, 140, 24);
    moneyLab.textAlignment = NSTextAlignmentLeft;
    moneyLab.text = @"关联古树: 爱心树";
    self.moneyLab = moneyLab;
    [self addSubview:moneyLab];
    
    UILabel *timeLab = [UILabel labelWithBackgroundColor:kClearColor textColor:kTextColor2 font:13];
    timeLab.frame = CGRectMake(15, detailLab.yy+10, 150, 24);
    timeLab.textAlignment = NSTextAlignmentLeft;
    timeLab.text = @"2018.01.15";
    self.timeLab = timeLab;
    [self addSubview:timeLab];
    
    UIView *line = [UIView new];
    line.frame = CGRectMake(0, timeLab.yy+20, kScreenWidth, 1);
    line.backgroundColor = RGB(244, 244, 244);
    [self addSubview:line];
    
}
-(void)setBookModel:(BookModel *)BookModel{
    
    if ([self.state isEqualToString:@"collect"]) {
        self.moreLab.text = BookModel.article[@"title"];
        [self getName:BookModel.article[@"publishUserId"]];
//        self.detailLab.text = [NSString stringWithFormat:@"作者 %@",[self getName:BookModel.article[@"publishUserId"]]];
        [_detailLab sizeToFit];
        _detailLab.frame = CGRectMake(15, _moreLab.yy+10, _detailLab.width + 10, 24);
        if (BookModel.treeName) {
            self.moneyLab.text = [NSString stringWithFormat:@"关联古树 %@ >",BookModel.treeName];
            [_moneyLab sizeToFit];
            _moneyLab.frame = CGRectMake(SCREEN_WIDTH - _moneyLab.width - 15, _moreLab.yy+10, _moneyLab.width + 10, 24);
        }
        self.timeLab.text = [BookModel.article[@"publishDatetime"] convertToDetailDate];
    }
    
    else{
        self.moreLab.text = BookModel.title;
        self.detailLab.text = [NSString stringWithFormat:@"作者 %@",BookModel.publishUserName];
    [_detailLab sizeToFit];
    _detailLab.frame = CGRectMake(15, _moreLab.yy+10, _detailLab.width + 10, 24);
    if (BookModel.treeName) {
        self.moneyLab.text = [NSString stringWithFormat:@"关联古树 %@ >",BookModel.treeName];
        [_moneyLab sizeToFit];
        _moneyLab.frame = CGRectMake(SCREEN_WIDTH - _moneyLab.width - 15, _moreLab.yy+10, _moneyLab.width + 10, 24);
    }
    self.timeLab.text = [BookModel.publishDatetime convertToDetailDate];
    }
}

-(void)getName:(NSString *)userid{
    CoinWeakSelf;
    TLNetworking * http = [TLNetworking new];
    http.code = USER_INFO;
    http.parameters[@"userId"] = userid;
    [http postWithSuccess:^(id responseObject) {
        NSString * name = [NSString stringWithFormat:@"%@", responseObject[@"data"][@"nickname"]];
//        Name = name;
        weakSelf.detailLab.text = [NSString stringWithFormat:@"作者 %@",name];
    } failure:^(NSError *error) {
        
    }];
//    return Name;
}

@end
