//
//  NewsView.m
//  OnlinePlay
//
//  Created by afarsoft on 2017/8/1.
//  Copyright © 2017年 afarsoft. All rights reserved.
//

#import "NewsView.h"
#import "NewsCell.h"

@interface NewsView ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation NewsView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}
- (void)setup{
    self.backgroundColor = [UIColor whiteColor];
    UILabel *new = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 100, 30)];
    new.text = @"消息";
    [self addSubview:new];
    
    UIButton *ignore = [UIButton buttonWithType:UIButtonTypeCustom];
    ignore.frame = CGRectMake(self.frame.size.width-110, 10, 100, 30);
    ignore.titleLabel.font = [UIFont systemFontOfSize:13];
    [ignore setTitle:@"忽略未读" forState:UIControlStateNormal];
    [ignore setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self addSubview:ignore];
    
    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, 40, self.frame.size.width, 1)];
    line.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:line];
    
    UITableView *newTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 42, self.frame.size.width, 208) style:UITableViewStylePlain];
    newTable.delegate = self;
    newTable.dataSource = self;
    newTable.rowHeight = 65;
    newTable.tableFooterView = [[UIView alloc]init];
    [self addSubview:newTable];
    
    [newTable registerNib:[UINib nibWithNibName:@"NewsCell" bundle:nil] forCellReuseIdentifier:@"newsCell"];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NewsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"newsCell" forIndexPath:indexPath];
    [cell.icon sd_setImageWithURL:[NSURL URLWithString:self.portrait] placeholderImage:[UIImage imageNamed:@""]];
    cell.name.text = self.nick;
    return cell;
}
@end
