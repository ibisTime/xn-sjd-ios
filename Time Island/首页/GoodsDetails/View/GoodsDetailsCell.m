//
//  GoodsDetailsCell.m
//  Time Island
//
//  Created by 梅敏杰 on 2019/1/29.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "GoodsDetailsCell.h"

@implementation GoodsDetailsCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.detail = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
        
        self.detail.scrollView.bounces=NO;
        self.detail.scrollView.showsHorizontalScrollIndicator = NO;
        self.detail.scrollView.scrollEnabled = NO;
        self.detail.backgroundColor = kWhiteColor;
        self.detail.dataDetectorTypes=UIDataDetectorTypeNone;
        
        [self addSubview:self.detail];
    }
    return self;
}
@end
