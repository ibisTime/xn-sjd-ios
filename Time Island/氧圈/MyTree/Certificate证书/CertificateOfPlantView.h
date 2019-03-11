//
//  CertificateOfPlantView.h
//  Time Island
//
//  Created by 郑勤宝 on 2019/1/10.
//  Copyright © 2019 ChengLian. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PersonalCenterModel.h"
#import "CertificateModel.h"
@interface CertificateOfPlantView : UIView

@property (nonatomic , strong)UIButton *ShutDownBtn;

@property (nonatomic , strong)PersonalCenterModel *model;
@property (nonatomic,assign) int count;
@property (nonatomic,strong) CertificateModel * CertificateModel;


@end
