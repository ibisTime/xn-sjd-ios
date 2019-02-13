//
//  BuyRemarkCell.m
//  Time Island
//
//  Created by shaojianfei on 2019/1/24.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "BuyRemarkCell.h"

@implementation BuyRemarkCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self initUI];
    }
    return self;
}
- (void)initUI
{
    
    self.filed = [[TLTextField alloc] initWithFrame:CGRectMake(0, 7.5, kScreenWidth, 40) leftTitle:@"买家留言" titleWidth:80 placeholder:@"请输入留言信息"];
    self.filed.leftLbl.font = HGfont(13);
    self.filed.font = HGfont(13);
    [self addSubview:self.filed];
    self.filed.centerY = self.centerY;
    self.filed.delegate = self;
    
    
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    if (self.remark) {
        self.remark(self.filed.text);
    }
}
@end
