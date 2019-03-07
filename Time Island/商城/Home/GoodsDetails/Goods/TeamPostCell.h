//
//  TeamPostCell.h
//  LHDS
//
//  Created by QinBao Zheng on 2018/8/17.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EvaluationModel.h"
@interface TeamPostCell : UITableViewCell

@property (nonatomic , strong)EvaluationModel *evaModel;

@property (nonatomic , strong)UIImageView *photoImage;

@property (nonatomic , strong)UIImageView *headImage;

@property (nonatomic , strong)UILabel *nameLabel;

@property (nonatomic , strong)UILabel *timeLabel;

@property (nonatomic , strong)UILabel *informationLabel;
@property (nonatomic,strong) UIImageView * imageview;
//@property (nonatomic,strong) UIWebView * informationLabel;

@property (nonatomic,assign) float webViewHeight1;


//@property (nonatomic , strong)UILabel *numberLabel;

//@property (nonatomic , strong)UIButton *praiseButton;
//
//@property (nonatomic , strong)UIButton *commentsButton;

@property (nonatomic , strong)UIView *lineView;

@property (nonatomic , copy)NSString *state;

@end
