//
//  IssueBook.m
//  Time Island
//
//  Created by 梅敏杰 on 2019/1/17.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "IssueBook.h"

@interface IssueBook ()
@property (nonatomic,strong) UIView * view1;
@property (nonatomic,strong) UIView * view2;
@end

@implementation IssueBook

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发布文章";
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -10;
    [self.RightButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    self.navigationItem.rightBarButtonItems = @[negativeSpacer, [[UIBarButtonItem alloc] initWithCustomView:self.RightButton]];
    self.RightButton.font = FONT(16);
    [self.RightButton setFrame:CGRectMake(SCREEN_WIDTH-47.5, 30, 32.5, 45)];
    [self.RightButton setTitle:@"保存" forState:UIControlStateNormal];
    [self.RightButton addTarget:self action:@selector(saveBook) forControlEvents:(UIControlEventTouchUpInside)];
    

    [self setupview1];
    [self setupview2];
    
    UIButton * issuebtn = [[UIButton alloc]initWithFrame:CGRectMake(15, self.view2.yy + 81, SCREEN_WIDTH - 30, 42) title:@"发布" backgroundColor:kTabbarColor];
    [issuebtn addTarget:self action:@selector(IssueBook) forControlEvents:UIControlEventTouchUpInside];
    issuebtn.layer.cornerRadius = 4;
    issuebtn.layer.masksToBounds = YES;
    [self.view addSubview:issuebtn];
}

-(void)setupview1{
    self.view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 301.5)];
    self.view1.backgroundColor = kWhiteColor;
    UITextField * textfield = [[UITextField alloc]initWithFrame:CGRectMake(15, 0, SCREEN_WIDTH - 30, 55)];
    textfield.placeholder = @"标题";
    textfield.font = FONT(15);
    [self.view1 addSubview:textfield];
    
    [self.view1 addSubview:[self createview:CGRectMake(15, textfield.yy - 1, SCREEN_WIDTH - 30, 1)]];
    
    UITextView * textview = [[UITextView alloc]initWithFrame:CGRectMake(15, textfield.yy + 2, SCREEN_WIDTH - 30, 156.5)];
    textview.font = FONT(13);
    textview.delegate = self;
    textview.text = @"发表下您的感想吧";
    textview.textColor = kHexColor(@"#999999");
    [self.view1 addSubview:textview];
    
    UIImageView * image = [[UIImageView alloc]initWithFrame:CGRectMake(15, textfield.yy + 156.5, 80, 80)];
    image.image = kImage(@"上传图片");
    
    image.userInteractionEnabled = YES;
    UITapGestureRecognizer * ges1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ChooseImage)];
    ges1.delegate = self;
    [image addGestureRecognizer:ges1];
    
    [self.view1 addSubview:image];
    
    [self.view addSubview:self.view1];
}

-(void)setupview2{
    self.view2 = [[UIView alloc]initWithFrame:CGRectMake(0, self.view1.yy + 10, SCREEN_WIDTH, 110)];
    self.view2.backgroundColor = kWhiteColor;
    
    TLTextField * textfield1 = [[TLTextField alloc]initWithFrame:CGRectMake(15, 0, SCREEN_WIDTH - 30, 55) placeholder:@"关联古树"];
    textfield1.enabled = NO;
    
    
    UIImageView * image1 = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 30 - 24.5, 22.5, 9.65, 9.65)];
    image1.image = kImage(@"下拉");
    [textfield1 addSubview:image1];
    
    [textfield1 addTarget:self action:@selector(ChooseTree) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self.view2 addSubview:textfield1];
    
    [self.view2 addSubview:[self createview:CGRectMake(15, textfield1.yy - 1, SCREEN_WIDTH - 30, 1)]];
    
    
    
    TLTextField * textfield2 = [[TLTextField alloc]initWithFrame:CGRectMake(15, textfield1.yy, SCREEN_WIDTH - 30, 55) placeholder:@"公开/私密/仅好友可见"];
    textfield2.enabled = NO;
    [self.view2 addSubview:textfield2];
    
    UIImageView * image2 = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 30 - 24.5, 22.5, 9.65, 9.65)];
    image2.image = kImage(@"下拉");
    [textfield2 addSubview:image2];
    
    
    [textfield2 addTarget:self action:@selector(ChooseState) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self.view2 addSubview:[self createview:CGRectMake(15, textfield2.yy - 1, SCREEN_WIDTH - 30, 1)]];
    
    
    
    [self.view addSubview:self.view2];
}


-(UIView*)createview:(CGRect)frame{
    UIView * view = [[UIView alloc]initWithFrame:frame];
    view.backgroundColor = kLineColor;
    return view;
}


#pragma UITextViewDelegate
- (void)textViewDidEndEditing:(UITextView *)textView
{
    if(textView.text.length < 1){
        textView.text = @"发表下您的感想吧";
        textView.textColor = kHexColor(@"#999999");
    }
}
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if([textView.text isEqualToString:@"发表下您的感想吧"]){
        textView.text=@"";
        textView.textColor=[UIColor blackColor];
    }
}

#pragma 按钮点击
-(void)IssueBook{
    NSLog(@"%s",__func__);
}
-(void)saveBook{
    NSLog(@"%s",__func__);
}

#pragma 手势
-(void)ChooseImage{
    NSLog(@"%s",__func__);
}
-(void)ChooseTree{
    NSLog(@"%s",__func__);
}
-(void)ChooseState{
    NSLog(@"%s",__func__);
}

@end
