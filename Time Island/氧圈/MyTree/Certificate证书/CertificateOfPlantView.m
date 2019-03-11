//
//  CertificateOfPlantView.m
//  Time Island
//
//  Created by 郑勤宝 on 2019/1/10.
//  Copyright © 2019 ChengLian. All rights reserved.
//

#import "CertificateOfPlantView.h"

#define WIDTH kWidth(280)
@implementation CertificateOfPlantView
{
    UIImageView *headImg;
    UILabel *contentLbl;
    UILabel *introduceLbl;
    UILabel *codeNumberLbl;
    UIImageView *backImg ;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIButton *ShutDownBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        ShutDownBtn.frame = CGRectMake(SCREEN_WIDTH - kWidth(75) + 25, kHeight(177/2), 25, 25);
        [ShutDownBtn setImage:kImage(@"删除") forState:(UIControlStateNormal)];
        self.ShutDownBtn = ShutDownBtn;
        [self addSubview:ShutDownBtn];
        

        
        for (int i = 0; i < 1; i ++) {
            backImg = [[UIImageView alloc]initWithFrame:CGRectMake(35, kHeight(139), SCREEN_WIDTH - 75, kHeight(435))];
//            backImg.image = kImage(@"证书背景");
            [self addSubview:backImg];
            
            
//            UIImageView *cerBackImg = [[UIImageView alloc]initWithFrame:CGRectMake((backImg.width - kHeight(106.5)) / 2, kHeight(21), kHeight(106.5), kHeight(71))];
//
//            cerBackImg.image = kImage(@"植物证书");
//            [backImg addSubview:cerBackImg];
//
//            UILabel *nameLbl = [UILabel labelWithFrame:CGRectMake(cerBackImg.width/2 - kHeight(40), kHeight(46.5), kHeight(80), kHeight(22.5)) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:FONT(16) textColor:kHexColor(@"#A1622A")];
//            nameLbl.text = @"植物证书";
////            nameLbl.backgroundColor = [UIColor whiteColor];
//            [cerBackImg addSubview:nameLbl];
            
            
            
            headImg = [[UIImageView alloc]initWithFrame:CGRectMake((backImg.width - kHeight(45)) / 2, kHeight(120), kHeight(45), kHeight(45))];
            kViewRadius(headImg, kHeight(45)/2);
//            headImg.image = kImage(@"头像");
            [backImg addSubview:headImg];
            
            contentLbl = [UILabel labelWithFrame:CGRectMake(kWidth(20), headImg.yy + kHeight(10), backImg.width - kWidth(40), kHeight(16)) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:HGboldfont(16) textColor:kTextBlack];
            contentLbl.text = @"tignting，谢谢你";
            [backImg addSubview:contentLbl];
            
            introduceLbl = [UILabel labelWithFrame:CGRectMake(kWidth(20), contentLbl.yy + kHeight(13.5), backImg.width - kWidth(40), 0) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(15) textColor:kHexColor(@"#666666")];
            introduceLbl.attributedText = [UserModel ReturnsTheDistanceBetween:@"你已于2018年4月21日认养的樟树，已被认领，将种植到鄂尔多斯地区。"];
            introduceLbl.numberOfLines = 0;
            [introduceLbl sizeToFit];
            [backImg addSubview:introduceLbl];
            
            
            codeNumberLbl = [UILabel labelWithFrame:CGRectMake(kWidth(45), introduceLbl.yy + kHeight(60), WIDTH - kWidth(60), kHeight(25)) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:FONT(18) textColor:kHexColor(@"#23AD8C")];
            codeNumberLbl.text = @"NO.SP1883457567798";
            [backImg addSubview:codeNumberLbl];
            
        }
    }
    return self;
}
-(void)setModel:(PersonalCenterModel *)model{
    _model = model;
    [self getdata];
    if (model) {
        [headImg sd_setImageWithURL:[NSURL URLWithString:[model.user[@"photo"] convertImageUrl]] placeholderImage:kImage(@"头像")];
        
        if (model.user[@"nickname"]) {
            contentLbl.text = model.user[@"nickname"];
        }else{
            contentLbl.text = [model.user[@"loginName"] stringByReplacingOccurrencesOfString:[model.user[@"loginName"]substringWithRange:NSMakeRange(3,4)] withString:@" **** "];
        }
        
        NSString *str = [NSString stringWithFormat:@"你已于%@认养的%@，已被认领，将种植到%@%@%@。",[model.createDatetime convertToChineseDate],model.tree[@"scientificName"],model.tree[@"province"],model.tree[@"city"],model.tree[@"area"]];
        introduceLbl.attributedText = [UserModel ReturnsTheDistanceBetween:str];
        [introduceLbl sizeToFit];
        introduceLbl.frame = CGRectMake(kWidth(21), contentLbl.yy + kHeight(13.5), SCREEN_WIDTH - 75 - kWidth(40), introduceLbl.height);
        
        codeNumberLbl.text = model.treeNumber;
    }
    
}

-(void)getdata{
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = @"629206";
    http.parameters[@"code"] = self.model.code;
    [http postWithSuccess:^(id responseObject) {
        self.CertificateModel = [CertificateModel mj_objectWithKeyValues:responseObject[@"data"]];
        [backImg sd_setImageWithURL:[NSURL URLWithString:[self.CertificateModel.certificateTemplate convertImageUrl]]];
    } failure:^(NSError *error) {
        
    }];
}
@end
