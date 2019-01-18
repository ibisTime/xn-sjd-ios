//
//  AddressCell.m
//  Time Island
//
//  Created by 梅敏杰 on 2019/1/18.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "AddressCell.h"

@implementation AddressCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //姓名
        self.UserName = [UILabel labelWithFrame:CGRectMake(15, 20, SCREEN_WIDTH / 2, 21) textAligment:NSTextAlignmentLeft backgroundColor:kClearColor font:FONT(15) textColor:kTextBlack];
        self.UserName.text = @"KOLAO";
        [self.contentView addSubview:self.UserName];
        
        //收货电话
        self.UserPhone = [UILabel labelWithFrame:CGRectMake(SCREEN_WIDTH - 15 - 100.5, 20, 100.5, 21) textAligment:NSTextAlignmentLeft backgroundColor:kClearColor font:FONT(15) textColor:kTextBlack];
        self.UserPhone.text = @"15012001100";
        [self.contentView addSubview:self.UserPhone];
        
        //地址
        self.UserAddress = [UILabel labelWithFrame:CGRectMake(15, self.UserName.yy + 15, SCREEN_WIDTH - 30, 21) textAligment:NSTextAlignmentLeft backgroundColor:kClearColor font:FONT(15) textColor:kTextColor3];
        self.UserAddress.text = @"浙江省杭州市梦想小镇互联网村88号2栋";
        [self.contentView addSubview:self.UserAddress];
        
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(15, self.UserAddress.yy + 20, SCREEN_WIDTH - 30, 1)];
        view.backgroundColor = kLineColor;
        [self.contentView addSubview:view];
        
        self.checkBtn = [UIButton buttonWithImageName:@"地址-未选中" selectedImageName:@"地址（选择）"];
        self.checkBtn.selected = YES;
        self.checkBtn.frame = CGRectMake(30, view.yy + 11.5, 18, 18);
        [self.contentView addSubview:self.checkBtn];
        
        
        UILabel * label = [UILabel labelWithFrame:CGRectMake(self.checkBtn.xx + 5, view.yy + 12.5, 73, 16.5) textAligment:NSTextAlignmentCenter backgroundColor:kClearColor font:FONT(12) textColor:kTextColor3];
        label.text = @"设为默认地址";
        if (self.checkBtn.isSelected) {
            label.textColor = kTabbarColor;
        }
        [self.contentView addSubview:label];
        
        
        UIButton * editbtn = [[UIButton alloc]initWithFrame:CGRectMake(label.xx + 123.5, view.yy + 9, 50, 23)];
        [editbtn setTitle:@"编辑" forState:UIControlStateNormal];
        editbtn.backgroundColor = kClearColor;
        [editbtn setTitleColor:kTextColor3 forState:UIControlStateNormal];
        editbtn.layer.borderWidth = 1;
        editbtn.layer.borderColor = kTextColor3.CGColor;
        [self.contentView addSubview:editbtn];
        
        
        UIButton * cancelbtn = [[UIButton alloc]initWithFrame:CGRectMake(editbtn.xx + 123.5, view.yy + 9, 50, 23)];
        [cancelbtn setTitle:@"删除" forState:UIControlStateNormal];
        cancelbtn.backgroundColor = kClearColor;
        [cancelbtn setTitleColor:kTextColor3 forState:UIControlStateNormal];
        cancelbtn.layer.borderWidth = 1;
        cancelbtn.layer.borderColor = kTextColor3.CGColor;
        [self.contentView addSubview:cancelbtn];
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
