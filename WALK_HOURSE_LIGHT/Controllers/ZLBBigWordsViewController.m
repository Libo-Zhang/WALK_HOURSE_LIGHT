//
//  ZLBBigWordsViewController.m
//  WALK_HOURSE_LIGHT
//
//  Created by tarena on 16/1/19.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "ZLBBigWordsViewController.h"
#import "ZLBBigWordsDetailViewController.h"
#import "Masonry.h"

@interface ZLBBigWordsViewController ()
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UIButton *button;
@end

@implementation ZLBBigWordsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.button.hidden = NO;
    self.textField.hidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (UIButton *)button {
	if(_button == nil) {
		_button = [[UIButton alloc] init];
        _button.backgroundColor = [UIColor yellowColor];
        [_button setTitle:@"确定" forState:UIControlStateNormal];
        [_button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_button];
        [_button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.view.mas_centerX);
            make.centerY.mas_equalTo(self.view.mas_centerY);
        }];
	}
	return _button;
}

- (UITextField *)textField {
	if(_textField == nil) {
		_textField = [[UITextField alloc] init];
        _textField.borderStyle = UITextBorderStyleRoundedRect;
        _textField.placeholder = @"请输入";
       // _textField.backgroundColor = [UIColor redColor];
        [self.view addSubview:_textField];
        [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.button.mas_centerX);
            make.centerY.mas_equalTo(self.button).mas_equalTo(-50);
            make.height.mas_equalTo(50);
            make.width.mas_equalTo(200);
        }];
	}
	return _textField;
}
#pragma mark 按钮点击
-(void)btnClick{
    ZLBBigWordsDetailViewController *detail = [ZLBBigWordsDetailViewController new];
    detail.string = self.textField.text;
    [self presentViewController:detail animated:YES completion:nil];
    NSLog(@"%@",self.textField.text);
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.textField resignFirstResponder];
}

@end
