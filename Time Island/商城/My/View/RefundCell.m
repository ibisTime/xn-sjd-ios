//
//  RefundCell.m
//  Time Island
//
//  Created by 梅敏杰 on 2019/3/4.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "RefundCell.h"

@implementation RefundCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.textfield = [[TLTextField alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 30, 55) leftTitle:@"" titleWidth:100 placeholder:@""];
        [self addSubview:self.textfield];
        
        
        
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(15, 54, SCREEN_WIDTH - 30, 1)];
        view.backgroundColor = kLineColor;
        [self addSubview:view];
        
    }
    return self;
}
-(void)setTitle:(NSString *)title{
    self.textfield.leftLbl.text = title;
    
    self.textfield.placeholder = [NSString stringWithFormat:@"请输入%@",title];
}

@end
