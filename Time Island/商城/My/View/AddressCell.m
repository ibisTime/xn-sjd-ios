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
//        self.UserName.text = @"KOLAO";
        [self.contentView addSubview:self.UserName];
        
        //收货电话
        self.UserPhone = [UILabel labelWithFrame:CGRectMake(self.UserName.xx, 20, SCREEN_WIDTH - self.UserName.xx - 15, 21) textAligment:NSTextAlignmentRight backgroundColor:kClearColor font:FONT(15) textColor:kTextBlack];
//        self.UserPhone.text = @"15012001100";
        [self.contentView addSubview:self.UserPhone];
        
        //地址
        self.UserAddress = [UILabel labelWithFrame:CGRectMake(15, 56, SCREEN_WIDTH - 30, 21) textAligment:NSTextAlignmentLeft backgroundColor:kClearColor font:FONT(15) textColor:kHexColor(@"#666666")];
//        self.UserAddress.text = @"浙江省杭州市梦想小镇互联网村88号2栋";
        [self.contentView addSubview:self.UserAddress];
        
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(15, self.UserAddress.yy + 20, SCREEN_WIDTH - 30, 1)];
        view.backgroundColor = kLineColor;
        [self.contentView addSubview:view];
        
        self.checkBtn = [UIButton buttonWithImageName:@"地址-未选中" selectedImageName:@"地址（选择）"];
        self.checkBtn.frame = CGRectMake(15, view.yy + 11.5, 18, 18);
        [self.contentView addSubview:self.checkBtn];

        
        
        self.label = [UILabel labelWithFrame:CGRectMake(self.checkBtn.xx + 5, view.yy + 12.5, 80, 16.5) textAligment:NSTextAlignmentCenter backgroundColor:kClearColor font:FONT(12) textColor:kTextColor3];
        self.label.text = @"设为默认地址";
        if (self.checkBtn.isSelected) {
            self.label.textColor = kHexColor(@"#F68646");
        }
        [self.contentView addSubview:self.label];
        
        
        UIButton * editbtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 140, view.yy + 9, 50, 23)];
        [editbtn setTitle:@"编辑" forState:UIControlStateNormal];
        editbtn.backgroundColor = kClearColor;
        self.editbtn = editbtn;
        [editbtn setTitleColor:kTextColor3 forState:UIControlStateNormal];
        editbtn.layer.borderWidth = 1;
        editbtn.layer.cornerRadius = 2;
        editbtn.layer.masksToBounds = YES;
        editbtn.titleLabel.font = FONT(12);
        editbtn.layer.borderColor = kHexColor(@"#999999").CGColor;
//        editbtn.tag = 2;
//        [editbtn addTarget:self action:@selector(clickSelect:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:editbtn];
        
        
        UIButton * cancelbtn = [[UIButton alloc]initWithFrame:CGRectMake(editbtn.xx + 25.5, view.yy + 9, 50, 23)];
        [cancelbtn setTitle:@"删除" forState:UIControlStateNormal];
        cancelbtn.backgroundColor = kClearColor;
        self.cancelbtn = cancelbtn;
        [cancelbtn setTitleColor:kTextColor3 forState:UIControlStateNormal];
        cancelbtn.titleLabel.font = FONT(12);
        cancelbtn.layer.borderWidth = 1;
        cancelbtn.layer.cornerRadius = 2;
        cancelbtn.layer.masksToBounds = YES;
        cancelbtn.layer.borderColor = kHexColor(@"#999999").CGColor;
        [self.contentView addSubview:cancelbtn];
        
        
        UIView * lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 150 - 10, SCREEN_WIDTH, 10)];
        lineView.backgroundColor = kBackgroundColor;
        [self addSubview:lineView];
        
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
- (void)clickSelect:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    if (sender.isSelected) {
        self.label.textColor = kHexColor(@"#F68646");
    }
    else{
        self.label.textColor = kTextColor3;
    }
    if (self.checkBtn.isSelected) {
        self.label.textColor = kHexColor(@"#F68646");
    }
    [_delegrate ClickButton:sender.tag];
}
-(UIView*)createview:(CGRect)frame{
    UIView * view = [[UIView alloc]initWithFrame:frame];
    view.backgroundColor = kLineColor;
    return view;
}

@end
