//
//  BookContentCell.m
//  Time Island
//
//  Created by 梅敏杰 on 2019/2/14.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "BookContentCell.h"

@implementation BookContentCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UILabel * content = [UILabel labelWithFrame:CGRectMake(15, 0, SCREEN_WIDTH - 30, 50) textAligment:NSTextAlignmentLeft backgroundColor:kClearColor font:FONT(15) textColor:kBlackColor];
        content.numberOfLines = 0;
        content.text = self.BookModel.content;
        [self addSubview:content];
        self.content = content;
    }
    return self;
}
-(void)setBookModel:(BookModel *)BookModel{
    _BookModel = BookModel;
    self.content.text = BookModel.content;
    [self.content sizeToFit];
    self.content.frame = CGRectMake(15, 0, SCREEN_WIDTH - 30, self.content.height);
    if (self.cellheight) {
        self.cellheight(self.content.height);
    }
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
