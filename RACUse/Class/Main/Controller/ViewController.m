//
//  ViewController.m
//  RACUse
//
//  Created by liuZX on 2018/1/19.
//  Copyright © 2018年 LiuZX. All rights reserved.
//

#import "ViewController.h"




CGFloat const kCellH = 50.0f;
NSString *const kCellIdentifier = @"cell";

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray *dataSource;

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    

    CGFloat tableY = 64;
    if (iPhoneX) {
        tableY = 88;
    }

    UITableView *myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, tableY, kScreenWidth, kScreenHeight - tableY) style:UITableViewStylePlain];
    [self.view addSubview:myTableView];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    myTableView.tableFooterView = [UIView new];
    myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;


    self.title = @"RAC使用";
}
- (NSArray *)dataSource {
    if (!_dataSource) {
        _dataSource = @[@"场景1:  登录页场景",
                        @"场景2:  多场景绑定",
                        @"场景3:  代替代理"];
    }
    return _dataSource;
}
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kCellH;
}
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    UIView *line = [UIView new];
    line.backgroundColor = [UIColor lightGrayColor];
    [cell.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(cell.contentView);
        make.left.equalTo(cell.contentView.mas_left).offset(15);
        make.right.equalTo(cell.contentView.mas_right).offset(-15);
        make.height.mas_equalTo(.5f);
    }];
    cell.textLabel.text = self.dataSource[indexPath.row];
    return cell;
}
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *jumpVC = [[NSClassFromString([NSString stringWithFormat:@"Demo%ldViewController", indexPath.row + 1]) alloc] init];
    [self.navigationController pushViewController:jumpVC animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
