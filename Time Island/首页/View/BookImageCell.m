//
//  BookImageCell.m
//  Time Island
//
//  Created by 梅敏杰 on 2019/2/14.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "BookImageCell.h"

@implementation BookImageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setBookModel:(BookModel *)BookModel{
    NSArray * arr = [BookModel.photo componentsSeparatedByString:@"||"];
    for (int i = 0; i < arr.count; i ++) {
        //            [self.photo sd_setImageWithURL:[NSURL URLWithString:[arr[i] convertImageUrl]]];
        UIImageView * image = [[UIImageView alloc]initWithFrame:CGRectMake(15 , 0 + 200 * i, SCREEN_WIDTH - 30, 200)];
        [image sd_setImageWithURL:[NSURL URLWithString:[arr[i] convertImageUrl]]];
        [self addSubview:image];
        
    }
}

@end
