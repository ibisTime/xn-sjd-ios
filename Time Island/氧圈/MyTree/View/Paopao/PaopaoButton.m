

#import "PaopaoButton.h"
#import <Masonry/Masonry.h>

@interface PaopaoButton ()

@property (nonatomic, strong) UIImageView *topImageView;
@property (nonatomic, strong) UILabel *bottomLabel;
@property (nonatomic, strong) UILabel *numberLabel;
@end

@implementation PaopaoButton

- (instancetype)init {
    if (self = [super init]) {
        [self addSubview:self.topImageView];
        [self addSubview:self.numberLabel];
        [self addSubview:self.bottomLabel];
        [self.topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.centerX.mas_equalTo(0);
        }];
        
        self.numberLabel.frame = self.topImageView.frame;
        
        [self.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.topImageView.centerX);
            make.centerY.mas_equalTo(self.topImageView.centerY);
        }];
        
        [self.bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.topImageView.mas_bottom).offset(4);
            make.centerX.mas_equalTo(self.topImageView.centerX);
        }];
    }
    return self;
}

- (void)setPaopaoImage:(UIImage *)image {
    self.topImageView.image = image;
}

- (void)setTitle:(NSString *)title {
    self.bottomLabel.text = title;
}

-(void)setNumber:(NSString *)number
{
    self.numberLabel.text = number;
}



#pragma mark - Get

- (UIImageView *)topImageView {
    if (!_topImageView) {
        _topImageView = [[UIImageView alloc] init];
    }
    return _topImageView;
}

-(UILabel *)numberLabel
{
    if (!_numberLabel) {
        _numberLabel = [[UILabel alloc] init];
        _numberLabel.font = HGboldfont(15);
        _numberLabel.textColor = kHexColor(@"#23AD8C ");
        _numberLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _numberLabel;
}


- (UILabel *)bottomLabel {
    if (!_bottomLabel) {
        _bottomLabel = [[UILabel alloc] init];
        _bottomLabel.font = [UIFont systemFontOfSize:12];
        _bottomLabel.textColor = kHexColor(@"#23AD8C ");
        _bottomLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _bottomLabel;
}

@end
