//
//  GenderPickerView.m
//  Time Island
//
//  Created by 梅敏杰 on 2019/1/24.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "GenderPickerView.h"

@implementation GenderPickerView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        self.genderarray = @[@"请选择",@"男",@"女"];
        self.delegate = self;
        self.dataSource = self;
        self.layer.borderColor = [UIColor grayColor].CGColor;
        self.layer.borderWidth = 2.0;
        [self reloadAllComponents];
    }
    return self;
}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.genderarray.count;
}
-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    return SCREEN_WIDTH - 30;
}
-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 50;
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return self.genderarray[row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    NSLog(@"%@",self.genderarray[row]);
    if (self.genderblock) {
        self.genderblock(self.genderarray[row]);
    }
    [self removeFromSuperview];
}
@end
