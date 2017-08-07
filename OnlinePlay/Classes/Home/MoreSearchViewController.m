//
//  MoreSearchViewController.m
//  OnlinePlay
//
//  Created by afarsoft on 2017/7/19.
//  Copyright © 2017年 afarsoft. All rights reserved.
//

#import "MoreSearchViewController.h"
#import "Timestamp.h"

@interface MoreSearchViewController ()

@end

@implementation MoreSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = _navcTitle;
    [self customNavigationBar:YES leftImage:@"title_button_back" right:NO rightImage:@""];
    //[self sendRequestMoreData];
}
- (void)leftClick:(UIButton *)sender{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (void)initUI{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)sendRequestMoreData{
    
    NSString *str = @"http://218.11.0.112/api/live/infos?id=1500428473429471%2C1500430622272626%2C1500431293435756%2C1500430604758743%2C1500430556156797&multiaddr=1&lc=0000000000000066&cc=TG0001&cv=IK4.0.89_Iphone&proto=7&idfa=18FFBF19-F9C5-430F-B9FA-3ADFA9763739&idfv=F7715FF6-D9C5-40CC-B09C-551AF6B88139&devi=787020bb8b0e1d25ec60b6ac309682f194ee148e&osversion=ios_10.300000&ua=iPhone9_2&imei=&imsi=&uid=527478701&sid=20rQmVCFxjlxBdz2i0gekTgEgYca7CIHhyvrsTKfHfU1cTFi2Ijj&conn=wifi&mtid=b70cf13999285b30e8cb7af3d27be282&mtxid=1675901723b9&logid=226,229,240&s_sg=4c22b04daf5a2306081504503c627672&s_sc=100&s_st=%@";
    NSString *string = [NSString stringWithFormat:str,[Timestamp getCurrentDateTimestamp]];
    NSLog(@"%@",string);
    NSString *utf = [string stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    //NSString *utf = [string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [AFNetHelper GET:utf parameters:nil success:^(id responseObject) {
        NSLog(@"%@",responseObject);
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
@end
