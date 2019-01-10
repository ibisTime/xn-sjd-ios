//
//  TitleView.m
//  Time Island
//
//  Created by shaojianfei on 2019/1/10.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "TitleView.h"

@implementation TitleView

// 如果这个没有调用父类的方法可以不用写该方法
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}
// 这个重写方法为重点
- (void)setFrame:(CGRect)frame {
    [super setFrame:CGRectMake(0, 0, self.superview.frame.size.width,         self.superview.bounds.size.height)];
}


@end
