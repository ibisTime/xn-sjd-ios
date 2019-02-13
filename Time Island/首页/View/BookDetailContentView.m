//
//  BookDetailContentView.m
//  Time Island
//
//  Created by 梅敏杰 on 2019/1/28.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "BookDetailContentView.h"

@implementation BookDetailContentView

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
    UILabel * content = [UILabel labelWithFrame:CGRectMake(15, 0, SCREEN_WIDTH - 30, 50) textAligment:NSTextAlignmentLeft backgroundColor:kClearColor font:FONT(15) textColor:kBlackColor];
    content.numberOfLines = 0;
    [self addSubview:content];
    self.content = content;
    
    UIImageView * photo = [[UIImageView alloc]initWithFrame:CGRectMake(15, self.content.yy + 25, SCREEN_WIDTH - 30, 200)];
    [self addSubview:photo];
    self.photo = photo;
}
-(void)setBookModel:(BookModel *)BookModel{
    if ([self.state isEqualToString:@"collect"]) {
        self.content.text = BookModel.article[@"content"];
        [_content sizeToFit];
        _content.frame = CGRectMake(15, 0, _content.width, 50);
        
        [self.photo sd_setImageWithURL:[NSURL URLWithString:[BookModel.article[@"photo"] convertImageUrl]]];
    }else{
        self.content.text = BookModel.content;
        [_content sizeToFit];
        _content.frame = CGRectMake(15, 0, _content.width, 50);
        
        [self.photo sd_setImageWithURL:[NSURL URLWithString:[BookModel.photo convertImageUrl]]];
    }
    
    
}
@end
