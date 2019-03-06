//
//  ServiceTableView.m
//  Time Island
//
//  Created by 梅敏杰 on 2019/3/5.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "ServiceTableView.h"
#import "MineMessageCell.h"
#import "YourMessageCell.h"
@implementation ServiceTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    if (self = [super initWithFrame:frame style:style]) {
        
        self.dataSource = self;
        self.delegate = self;
        
    }
    
    return self;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.model[0].messageList.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //我发送的消息
    if ([self.model[0].messageList[indexPath.section][@"userId"] isEqualToString:[TLUser user].userId]) {
        static NSString *rid=@"minecell";
        
        MineMessageCell *cell=[tableView dequeueReusableCellWithIdentifier:rid];
        
        if(cell==nil){
            
            cell=[[MineMessageCell alloc] initWithStyle:UITableViewCellStyleDefault      reuseIdentifier:rid];
            
        }
        cell.backgroundColor = RGB(236, 236, 236);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.content.text = self.model[0].messageList[indexPath.section][@"content"];
        CGSize strSize = [self.model[0].messageList[indexPath.section][@"content"] boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 120, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
        
        //一行
        if (strSize.height <= 18) {
            cell.conview.frame = CGRectMake(SCREEN_WIDTH - 70 - strSize.width - 20, 15, strSize.width + 20, 50);
            cell.content.frame = CGRectMake(10, 10, strSize.width, 30);
            
        }
        //很多很多行
        else if (strSize.height > 1000){
            cell.conview.frame = CGRectMake(SCREEN_WIDTH - 70 - strSize.width - 20, 15, strSize.width + 20, 1020);
            cell.content.frame = CGRectMake(10, 10, cell.conview.width - 20, 1000);
            
        }
        //多行
        else
        {
            cell.conview.frame = CGRectMake(SCREEN_WIDTH - 70 - strSize.width - 20, 15, strSize.width + 20, strSize.height + 20);
            cell.content.frame = CGRectMake(10, 10, cell.conview.width - 20, strSize.height);
        }
        
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:cell.conview.bounds byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft) cornerRadii:CGSizeMake(6,6)];//圆角大小
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = cell.conview.bounds;
        maskLayer.path = maskPath.CGPath;
        cell.conview.layer.mask = maskLayer;
        
        
        cell.img.frame = CGRectMake(SCREEN_WIDTH - 60, cell.conview.yy - 50, 50, 50);
        return cell;
    }
    
    //我接受到的消息
    static NSString *rid=@"yourmessage";
    
    YourMessageCell *cell=[tableView dequeueReusableCellWithIdentifier:rid];
    
    if(cell==nil){
        
        cell=[[YourMessageCell alloc] initWithStyle:UITableViewCellStyleDefault      reuseIdentifier:rid];
        
    }
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = RGB(236, 236, 236);
    cell.content.text = self.model[0].messageList[indexPath.section][@"content"];
    CGSize strSize = [self.model[0].messageList[indexPath.section][@"content"] boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 120, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
    
    //一行
    if (strSize.height <= 18) {
        cell.conview.frame = CGRectMake(70, 15, strSize.width + 20, 50);
        cell.content.frame = CGRectMake(10, 10, strSize.width, 30);
        
    }
    //很多很多行
    else if (strSize.height > 1000){
        cell.conview.frame = CGRectMake(70, 15, strSize.width + 20, 1020);
        cell.content.frame = CGRectMake(10, 10, cell.conview.width - 20, 1000);
        
    }
    //多行
    else
    {
        cell.conview.frame = CGRectMake(70, 15, strSize.width + 20, strSize.height + 20);
        cell.content.frame = CGRectMake(10, 10, cell.conview.width - 20, strSize.height);
    }
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:cell.conview.bounds byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomRight) cornerRadii:CGSizeMake(6,6)];//圆角大小
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = cell.conview.bounds;
    maskLayer.path = maskPath.CGPath;
    cell.conview.layer.mask = maskLayer;
    
    
    cell.img.frame = CGRectMake(10, cell.conview.yy - 50, 50, 50);
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 30)];
    UILabel * label = [UILabel labelWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 10) textAligment:(NSTextAlignmentCenter) backgroundColor:RGB(224, 224, 224) font:FONT(10) textColor:kBlackColor];
    label.text = [self.model[0].messageList[section][@"createDatetime"] convertToDetailDate];
    [label sizeToFit];
    label.frame = CGRectMake((SCREEN_WIDTH - label.width)/2, 10, label.width, 10);
    
    [view addSubview:label];
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    if ([self heightforcell:self.model[0].messageList[indexPath.section][@"content"]] > 80) {
//        return [self heightforcell:self.model[0].messageList[indexPath.section][@"content"]] + 30;
//    }
    CGSize strSize = [self.model[0].messageList[indexPath.section][@"content"] boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 120, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
    
    if (strSize.height <= 18) {
        return 80;
    }
    if (strSize.height > 1000) {
        return 1050;
    }
    return strSize.height + 50;
    
}

- (float) heightForString:(NSString *)value andWidth:(float)width{
    //获取当前文本的属性
    NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:value];
//    _text.attributedText = attrStr;
    NSRange range = NSMakeRange(0, attrStr.length);
    // 获取该段attributedString的属性字典
    NSDictionary *dic = [attrStr attributesAtIndex:0 effectiveRange:&range];
    // 计算文本的大小
    CGSize sizeToFit = [value boundingRectWithSize:CGSizeMake(width - 16.0, MAXFLOAT) // 用于计算文本绘制时占据的矩形块
                                           options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading // 文本绘制时的附加选项
                                        attributes:dic        // 文字的属性
                                           context:nil].size; // context上下文。包括一些信息，例如如何调整字间距以及缩放。该对象包含的信息将用于文本绘制。该参数可为nil
    return sizeToFit.height + 16.0;
    
}

@end
