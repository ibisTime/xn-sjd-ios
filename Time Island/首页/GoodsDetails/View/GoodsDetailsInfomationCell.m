//
//  GoodsDetailsInfomationCell.m
//  Time Island
//
//  Created by 郑勤宝 on 2019/1/21.
//  Copyright © 2019 ChengLian. All rights reserved.
//

#import "GoodsDetailsInfomationCell.h"

@implementation GoodsDetailsInfomationCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        
        UILabel *nameLbl = [UILabel labelWithFrame:CGRectMake(50, 10, SCREEN_WIDTH - 65, 14) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(14) textColor:kTextBlack];
        nameLbl.text = @"碳泡泡积蓄需要时间，完成上述行为后，记得第二天来收集碳泡泡。";
        nameLbl.numberOfLines = 2;
        
        [self addSubview:nameLbl];
        self.nameLbl = nameLbl;
        
        UILabel *TheLabel = [UILabel labelWithFrame:CGRectMake(15, 10, 32, 14) textAligment:(NSTextAlignmentCenter) backgroundColor:kRedColor font:FONT(11) textColor:kWhiteColor];
        TheLabel.text = @"个人";
        [self addSubview:TheLabel];
        self.TheLabel = TheLabel;
        kViewRadius(TheLabel, 7);
        
        UILabel *priceLabel = [UILabel labelWithFrame:CGRectMake(15, 55, 0, 16) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(16) textColor:kRedColor];
        
        //        priceLabel.backgroundColor = [UIColor yellowColor];
        [self addSubview:priceLabel];
        self.priceLabel = priceLabel;
        
        
        UILabel *addressLabel = [UILabel labelWithFrame:CGRectMake(priceLabel.frame.size.width + 9, 57, SCREEN_WIDTH - priceLabel.xx - 15, 14) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:FONT(11) textColor:RGB(153, 153, 153)];
        addressLabel.text = @"浙江省 杭州市";
        [self addSubview:addressLabel];
        self.addressLabel = addressLabel;
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 80, SCREEN_WIDTH, 8)];
        lineView.backgroundColor = RGB(244, 244, 244);
        [self addSubview:lineView];
        
        
        
//        UIView *progressBottomView = [[UIView alloc]initWithFrame:CGRectMake(15, 110, SCREEN_WIDTH - 15 - 60, 5)];
//        progressBottomView.backgroundColor = RGB(244, 244, 244);
//        kViewRadius(progressBottomView, 2.5);
//        [self addSubview:progressBottomView];
//
//        UIView *progressView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/2 , 5)];
//        progressView.backgroundColor = kRedColor;
//        kViewRadius(progressView, 2.5);
//        [progressBottomView addSubview:progressView];
//        self.progressView = progressView;
//
//
//
//        UILabel *numberLbl = [UILabel labelWithFrame:CGRectMake(progressBottomView.xx + 10, progressBottomView.y - 5, 40, 15) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(15) textColor:kTextBlack];
//        numberLbl.text = @"50%";
//        [self addSubview:numberLbl];
//        self.numberLbl = numberLbl;
        

        
//        UIView *lineView1 = [[UIView alloc]initWithFrame:CGRectMake(0, 172, SCREEN_WIDTH, 8)];
//        lineView1.backgroundColor = RGB(244, 244, 244);
//        [self addSubview:lineView1];
        
    }
    return self;
}

-(void)setTreeModel:(TreeModel *)TreeModel{
    self.nameLbl.text = TreeModel.name;
    [self.nameLbl sizeToFit];
    self.TheLabel.text = TreeModel.status;
//    self.priceLabel.text = [NSString stringWithFormat:@"¥ %@",TreeModel.productSpecsList[0][@"price"] ];
    if (TreeModel.productSpecsList.count > 0) {
        float money = [TreeModel.productSpecsList[0][@"price"] floatValue] / 1000.00;
        NSString *str= [NSString stringWithFormat:@"¥ %.2f",money];
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
        [attrStr addAttribute:NSFontAttributeName value:FONT(11) range:NSMakeRange(0, 1)];
        self.priceLabel.attributedText = attrStr;
        [self.priceLabel sizeToFit];
        self.priceLabel.frame = CGRectMake(15, 55, self.priceLabel.width, 18);
    }
    if (TreeModel.treeList.count>0) {
        self.addressLabel.text = [NSString stringWithFormat:@"%@ %@",TreeModel.treeList[0][@"city"],TreeModel.treeList[0][@"area"]];
    }
    NSString * raise = TreeModel.raiseCount;
    NSString * now = TreeModel.nowCount;
    self.targetNumber = [NSArray arrayWithObjects:raise,now,nil];
    
    if ([TreeModel.sellType isEqualToString:@"4"]) {
        NSArray *targetName = @[@"目标份数/份",@"已募集份数/份"];
        if (self.targetNumber.count > 0) {
            for (int i = 0; i < 2; i ++) {
                UILabel *targetNameLbl = [UILabel labelWithFrame:CGRectMake(50 + i % 2 * (SCREEN_WIDTH - 100)/2, self.numberLbl.yy + 10, (SCREEN_WIDTH - 100)/2, 11) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:FONT(11) textColor:RGB(153, 153, 153)];
                targetNameLbl.text = targetName[i];
                [self addSubview:targetNameLbl];
                
                UILabel *targetNumberLbl = [UILabel labelWithFrame:CGRectMake(50 + i % 2 * (SCREEN_WIDTH - 100)/2, targetNameLbl.yy + 5, (SCREEN_WIDTH - 100)/2, 13) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:FONT(13) textColor:kTextBlack];
                targetNumberLbl.text = self.targetNumber[i];
                [self addSubview:targetNumberLbl];
            }
            UIView *progressBottomView = [[UIView alloc]initWithFrame:CGRectMake(15, 110, SCREEN_WIDTH - 15 - 60, 5)];
            progressBottomView.backgroundColor = RGB(244, 244, 244);
            kViewRadius(progressBottomView, 2.5);
            [self addSubview:progressBottomView];
            
            UIView *progressView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/2 , 5)];
            progressView.backgroundColor = kRedColor;
            kViewRadius(progressView, 2.5);
            [progressBottomView addSubview:progressView];
            self.progressView = progressView;
            
            
            
            UILabel *numberLbl = [UILabel labelWithFrame:CGRectMake(progressBottomView.xx + 10, progressBottomView.y - 5, 40, 15) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(15) textColor:kTextBlack];
            numberLbl.text = @"50%";
            [self addSubview:numberLbl];
            self.numberLbl = numberLbl;
            self.progressView.width = [TreeModel.nowCount intValue]/ [TreeModel.raiseCount intValue] * (kScreenWidth - 15 - 60);
            self.numberLbl.text = [NSString stringWithFormat:@"%d%@", [TreeModel.nowCount intValue]/ [TreeModel.raiseCount intValue] * 100,@"%"];
        }
        UIView *lineView1 = [[UIView alloc]initWithFrame:CGRectMake(0, 172, SCREEN_WIDTH, 8)];
        lineView1.backgroundColor = RGB(244, 244, 244);
        [self addSubview:lineView1];
    }
    
    
    
    
}


@end
