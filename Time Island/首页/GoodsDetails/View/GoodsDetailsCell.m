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
        self.detail = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        self.detail.delegate = self;
        [self addSubview:self.detail];
    }
    return self;
}
-(void)setTreeModel:(TreeModel *)TreeModel{
    [self.detail loadHTMLString:TreeModel.Description baseURL:nil];
}
//-(void)webViewDidFinishLoad:(UIWebView *)webView{
//    CGSize * websize = [webView sizeThatFits:CGSizeZero];
//}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
}
@end
