//
//  TransportCell.m
//  Time Island
//
//  Created by shaojianfei on 2019/1/24.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "TransportCell.h"

@implementation TransportCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self initUI];
//        [self getdata];
    }
    return self;
}

- (void)initUI
{
    self.nameLbl = [UILabel labelWithFrame:CGRectMake(15, 20, kWidth(120), 22) textAligment:NSTextAlignmentLeft backgroundColor:kClearColor font:FONT(13) textColor:kTextColor];
    [self addSubview:self.nameLbl];
    self.nameLbl.text = @"配送方式";
    self.countLbl = [UILabel labelWithFrame:CGRectMake(kScreenWidth-100, 20, 80, 22) textAligment:NSTextAlignmentCenter backgroundColor:kClearColor font:FONT(13) textColor:kTextColor];
    
    if ([self.postalFee integerValue] == 0) {
        self.countLbl.text = @"快递免邮";
    }
    else{
        self.countLbl.text = [NSString stringWithFormat:@"快递费:%@",self.postalFee];
    }
    
    self.countLbl.centerY = self.nameLbl.centerY;
    [self addSubview:self.countLbl];
    self.youImage = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 21, 22, 6, 11)];
    self.youImage.image = HGImage(@"积分更多");
    [self addSubview:self.youImage];
     self.youImage.centerY = self.nameLbl.centerY;
}

-(void)getdata{
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = @"629801";
    http.parameters[@"addressCode"] = self.addressCode;
    http.parameters[@"commodityCodeList"] = self.commodityCodeList;
    [http postWithSuccess:^(id responseObject) {
        
    } failure:^(NSError *error) {
        
    }];
}


@end
