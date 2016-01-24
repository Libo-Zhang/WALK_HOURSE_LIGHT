//
//  ZLBBigWordsViewController.m
//  WALK_HOURSE_LIGHT
//
//  Created by tarena on 16/1/19.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "ZLBBigWordsViewController.h"
#import "ZLBBigWordsDetailViewController.h"
#import "ZLBColorTableViewController.h"
#import "Masonry.h"

@interface ZLBBigWordsViewController () <UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITextField *textField; //要传递的参数

/** UIBarbuttonitem */
@property (nonatomic, strong) UIBarButtonItem *rightItem;
/** tableview */
@property (nonatomic, strong) UITableView *tableView;
/** UISwitch*/
@property (nonatomic, strong) UISwitch *loopSwitch;

/**ifLoop*/
@property (nonatomic) BOOL isLoop; // 要传递的参数
/** ColorText*/
@property (nonatomic, strong) NSString *colorText;
@property (nonatomic, strong) UIColor *color; // 要传递的参数

/**  UISlider  写成 UIView  不然很麻烦*/
@property (nonatomic, strong) UIView *sliderUivew;
@property (nonatomic, strong) UISlider *slider;
@property (nonatomic, assign) NSInteger sliderValue; // 要传递的参数
@property (nonatomic, strong) UILabel *fontLabel;


@end

@implementation ZLBBigWordsViewController
//tableview 的懒加载
- (UITableView *)tableView {
    if(_tableView == nil) {
        _tableView = [[UITableView alloc] init];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
    }
    return _tableView;
}
/** rightItem 的懒加载*/
- (UIBarButtonItem *)rightItem {
    if(_rightItem == nil) {
        _rightItem = [[UIBarButtonItem alloc] initWithTitle:@"Start" style:UIBarButtonItemStylePlain target:self action:@selector(btnClick)];
        self.navigationItem.rightBarButtonItem = _rightItem;
    }
    return _rightItem;
}
/**UISwitch 的懒加载*/
- (UISwitch *)loopSwitch {
    if(_loopSwitch == nil) {
        _loopSwitch = [[UISwitch alloc] init];
         self.isLoop = self.loopSwitch.on;
        [_loopSwitch addTarget:self action:@selector(switchClick) forControlEvents:UIControlEventValueChanged];
    }
    return _loopSwitch;
}
/**UISliderUIView 的懒加载*/

- (UIView *)sliderUivew {
    if(_sliderUivew == nil) {
        _sliderUivew = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
        //_sliderUivew.backgroundColor = [UIColor redColor];
        self.slider = [[UISlider alloc] init];
        [self.slider addTarget:self action:@selector(slideChange) forControlEvents:UIControlEventValueChanged];
        self.slider.minimumValue = 100;
        self.slider.maximumValue = 200;
        [_sliderUivew addSubview:self.slider];
        [self.slider mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(0);
            make.width.mas_equalTo(100);
            make.centerY.mas_equalTo(_sliderUivew.mas_centerY);
        }];
        self.fontLabel = [[UILabel alloc] init];
        self.fontLabel.text = @"100";
        [_sliderUivew addSubview:self.fontLabel];
        [self.fontLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.slider.mas_left).mas_equalTo(0);
            make.left.mas_equalTo(-15);
            make.centerY.mas_equalTo(_sliderUivew.mas_centerY);
        }];
    }
    return _sliderUivew;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.tableView.userInteractionEnabled = YES;
    self.rightItem.style = UIBarButtonItemStylePlain;
    self.tableView.hidden = NO;
    self.tableView.tableFooterView = [UIView new];
    self.colorText = @"黑色(默认)";
    self.sliderValue = 100;
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSIndexPath *indexpath = [NSIndexPath indexPathForRow:3 inSection:0];
    [self.tableView reloadRowsAtIndexPaths:@[indexpath] withRowAnimation:UITableViewRowAnimationAutomatic];
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



- (UITextField *)textField {
	if(_textField == nil) {
		_textField = [[UITextField alloc] init];
        _textField.borderStyle = UITextBorderStyleRoundedRect;
        _textField.placeholder = @"请输入";


	}
	return _textField;
}
/**UISwitch Click*/
-(void)switchClick{
    self.isLoop = self.loopSwitch.on;
    
}
/**UISlider Change  */
-(void)slideChange{
    self.sliderValue = self.slider.value;

   
    self.fontLabel.text = [NSString stringWithFormat:@"%@",@(self.sliderValue)];
}
/** start 按钮点击  */
-(void)btnClick{
    ZLBBigWordsDetailViewController *detail = [ZLBBigWordsDetailViewController new];
    detail.string = self.textField.text;
    detail.labelSize = self.sliderValue;
    detail.labelColor = self.color;
    detail.isLoop = self.isLoop;
    [self presentViewController:detail animated:YES completion:nil];
    
}
/** 键盘失去第一响应  */
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.textField resignFirstResponder];
}
#pragma mark UITableView 
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        switch (indexPath.row) {
            case 0:
                cell.textLabel.text = @"播放文字";
                
                break;
            case 1:
                [cell.contentView addSubview:self.textField];
                [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(15);
                    make.top.mas_equalTo(5);
                    make.bottom.mas_equalTo(-5);
                    make.right.mas_equalTo(-15);
                }];
                break;
            case 2:
                cell.textLabel.text = @"是否直接播放";
                cell.accessoryView = self.loopSwitch;
                break;
            case 3:
                //这边重用机制  会导致 颜色的显示 显示不对   ,用这种方法 有点消耗内存   其实可以设置 tag 值做,这里没时间实现
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ColorCell"];
                cell.textLabel.textColor = self.color;
                cell.textLabel.text = [NSString stringWithFormat:@"%@ (%@)",@"颜色",self.colorText];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                
                break;
            case 4:
                
                cell.textLabel.text = [NSString stringWithFormat:@"%@",@"字体大小"];
                cell.accessoryView = self.sliderUivew;
                break;
                
            default:
                break;
        }
        
    }
    return cell;
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 3) {
        ZLBColorTableViewController *color = [ZLBColorTableViewController new];
        color.block = ^(UIColor *color,NSString *colorStr){
            self.colorText = colorStr;
            self.color = color;
        };
        [self.navigationController pushViewController:color animated:YES];
    }
    if (indexPath.row == 4) {
        
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}











@end
