//
//  CompanyCertifycell.m
//  Time Island
//
//  Created by 梅敏杰 on 2019/2/25.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "CompanyCertifycell.h"

@implementation CompanyCertifycell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self CreateTextField];
    }
    return self;
}
-(void)CreateTextField{
//    TLTextField * comname = [[TLTextField alloc]initWithFrame:CGRectMake(15, 0, SCREEN_WIDTH-30, 55) leftTitle:self.title placeholder:self.placeholder];
    TLTextField * comname = [[TLTextField alloc]initWithFrameChangeLeftLbl:CGRectMake(15, 0, SCREEN_WIDTH-30, 55) leftTitle:@"" placeholder:@""];
    comname.font = FONT(15);
    comname.leftLbl.font = FONT(15);
    [self addSubview:comname];
//    self.ComName = comname;
    self.textfield = comname;
}
-(void)setTitle:(NSString *)title{
    _title = title;
}
-(void)setPlaceholder:(NSString *)placeholder{
    _placeholder = placeholder;
    self.textfield.leftLbl.text = self.title;
    self.textfield.leftLbl.numberOfLines = 0;
    self.textfield.placeholder = placeholder;
}
-(void)setKeyStr:(NSString *)keyStr{
    _keyStr = keyStr;
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField.text.length == 0) {
        [TLAlert alertWithMsg:@"请输入"];
    }else{
        if (self.Text) {
            self.Text(textField.text, self.keyStr);
        }
    }
}
@end
