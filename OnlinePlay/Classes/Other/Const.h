//
//  Const.h
//  OnlinePlay
//
//  Created by afarsoft on 2017/7/17.
//  Copyright © 2017年 afarsoft. All rights reserved.
//

#ifndef Const_h
#define Const_h

/**NSLOG*/
#if DEBUG

#define NSLog(FORMAT, ...) fprintf(stderr,"[%s:%d行] %s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);

#else

#define NSLog(FORMAT, ...) nil

#endif
/**屏幕参数*/
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define ViewWidth  self.view.frame.size.width
#define ViewHeight self.view.frame.size.height
/**Color(有参数)*/
#define RGBColor(R,G,B) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1]
#define RGBAColor(R,G,B,A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]
/**PushController*/
#define PushController(controller) [self.navigationController pushViewController:controller animated:YES];
/**拿到StoryBoard里的Controller*/
#define StoryBoard(name,identifier) [[UIStoryboard storyboardWithName:name bundle:nil] instantiateViewControllerWithIdentifier:identifier];
/**NSUserDefaults*/
#define userDefault [NSUserDefaults standardUserDefaults]
/**API*/
//轮播图
#define ScrollURL @"http://webapi.busi.inke.cn/service/ticker?tab_key=80953E3E797912C8&lc=0000000000000066&cc=TG0001&cv=IK4.0.89_Iphone&proto=7&idfa=18FFBF19-F9C5-430F-B9FA-3ADFA9763739&idfv=F7715FF6-D9C5-40CC-B09C-551AF6B88139&devi=787020bb8b0e1d25ec60b6ac309682f194ee148e&osversion=ios_10.300000&ua=iPhone9_2&imei=&imsi=&uid=527478701&sid=20rQmVCFxjlxBdz2i0gekTgEgYca7CIHhyvrsTKfHfU1cTFi2Ijj&conn=wifi&mtid=b70cf13999285b30e8cb7af3d27be282&mtxid=1675901723b9&logid=226,229,240"
//搜索
#define SearchPlaceholdURL @"http://218.11.0.112/api/recommend/aggregate?interest=2&longitude=113.559831&latitude=34.813961&lc=0000000000000066&cc=TG0001&cv=IK4.0.89_Iphone&proto=7&idfa=18FFBF19-F9C5-430F-B9FA-3ADFA9763739&idfv=F7715FF6-D9C5-40CC-B09C-551AF6B88139&devi=787020bb8b0e1d25ec60b6ac309682f194ee148e&osversion=ios_10.300000&ua=iPhone9_2&imei=&imsi=&uid=527478701&sid=20rQmVCFxjlxBdz2i0gekTgEgYca7CIHhyvrsTKfHfU1cTFi2Ijj&conn=wifi&mtid=b70cf13999285b30e8cb7af3d27be282&mtxid=1675901723b9&logid=226,229,240&s_sg=a843b9552b017bf3ed9ad87a63a634bb&s_sc=100&s_st=%@"
//附近-直播
#define OnlineURL @"http://218.11.0.112/api/live/near_flow_old?&gender=1&gps_info=113.559822%2C34.813883&loc_info=CN%2C%E6%B2%B3%E5%8D%97%E7%9C%81%2C%E9%83%91%E5%B7%9E%E5%B8%82&is_new_user=1&latitude=34.813883&longitude=113.559822&multiaddr=1&interest=0&lc=0000000000000066&cc=TG0001&cv=IK4.0.89_Iphone&proto=7&idfa=18FFBF19-F9C5-430F-B9FA-3ADFA9763739&idfv=F7715FF6-D9C5-40CC-B09C-551AF6B88139&devi=787020bb8b0e1d25ec60b6ac309682f194ee148e&osversion=ios_10.300000&ua=iPhone9_2&imei=&imsi=&uid=527478701&sid=20rQmVCFxjlxBdz2i0gekTgEgYca7CIHhyvrsTKfHfU1cTFi2Ijj&conn=wifi&mtid=b70cf13999285b30e8cb7af3d27be282&mtxid=1675901723b9&logid=226,229,240&s_sg=c38e28b9f6fed9efc567bb5f0741f5cf&s_sc=100&s_st=1500458379"
//发现
#define FindURL @"http://218.11.0.112/api/discover/aggregate?lc=0000000000000067&cc=TG0001&cv=IK4.0.90_Iphone&proto=7&idfa=18FFBF19-F9C5-430F-B9FA-3ADFA9763739&idfv=F7715FF6-D9C5-40CC-B09C-551AF6B88139&devi=787020bb8b0e1d25ec60b6ac309682f194ee148e&osversion=ios_10.300000&ua=iPhone9_2&imei=&imsi=&uid=530468613&sid=20d7ZHBzMn4XQZUwJxaIrSHn4Ki1OV2v8shjVi2pgrMhjYEGx184&conn=wifi&mtid=b70cf13999285b30e8cb7af3d27be282&mtxid=1675901723b9&logid=226,230&s_sg=a08edb55cc5794186bde44e3b98f25ca&s_sc=100&s_st=1500943848"
#define FindTypeURL @"http://218.11.0.112/api/live/themesearch?latitude=34.814201&longitude=113.559950&interest=2&keyword=%@&lc=0000000000000067&cc=TG0001&cv=IK4.0.90_Iphone&proto=7&idfa=18FFBF19-F9C5-430F-B9FA-3ADFA9763739&idfv=F7715FF6-D9C5-40CC-B09C-551AF6B88139&devi=0db66da47c599736e74c021a02d481b473e6b93f&osversion=ios_10.300000&ua=iPhone9_2&imei=&imsi=&uid=530468613&sid=20n9DuwArJTywxrl5Ugm5ZkXFFr4zYFovuSCENCEdEWh7Qi2Dnk&conn=wifi&mtid=b70cf13999285b30e8cb7af3d27be282&mtxid=1675901723b9&logid=226,230,240"
//热门
#define HotScrollURL @"http://218.11.0.112/api/live/ticker?lc=0000000000000067&cc=TG0001&cv=IK4.0.90_Iphone&proto=7&idfa=18FFBF19-F9C5-430F-B9FA-3ADFA9763739&idfv=F7715FF6-D9C5-40CC-B09C-551AF6B88139&devi=787020bb8b0e1d25ec60b6ac309682f194ee148e&osversion=ios_10.300000&ua=iPhone9_2&imei=&imsi=&uid=530468613&sid=20d7ZHBzMn4XQZUwJxaIrSHn4Ki1OV2v8shjVi2pgrMhjYEGx184&conn=wifi&mtid=b70cf13999285b30e8cb7af3d27be282&mtxid=1675901723b9&logid=226,230"
#define HotURL @"http://218.11.0.112/api/live/simpleall?&gender=1&gps_info=113.559823%2C34.813985&loc_info=CN%2C%E6%B2%B3%E5%8D%97%E7%9C%81%2C%E9%83%91%E5%B7%9E%E5%B8%82&is_new_user=0&interest=0&location=&lc=0000000000000067&cc=TG0001&cv=IK4.0.90_Iphone&proto=7&idfa=18FFBF19-F9C5-430F-B9FA-3ADFA9763739&idfv=F7715FF6-D9C5-40CC-B09C-551AF6B88139&devi=787020bb8b0e1d25ec60b6ac309682f194ee148e&osversion=ios_10.300000&ua=iPhone9_2&imei=&imsi=&uid=530468613&sid=20d7ZHBzMn4XQZUwJxaIrSHn4Ki1OV2v8shjVi2pgrMhjYEGx184&conn=wifi&mtid=b70cf13999285b30e8cb7af3d27be282&mtxid=1675901723b9&logid=226,230&s_sg=990e4139f358ff253cb341554f0d557f&s_sc=100&s_st=1500961825"
//小视频
#define VideoURL @"http://218.11.0.112/api/feeds_tab/recommends?limit=10&latitude=34.813986&longitude=113.559852&start=0&lc=0000000000000067&cc=TG0001&cv=IK4.0.90_Iphone&proto=7&idfa=18FFBF19-F9C5-430F-B9FA-3ADFA9763739&idfv=F7715FF6-D9C5-40CC-B09C-551AF6B88139&devi=787020bb8b0e1d25ec60b6ac309682f194ee148e&osversion=ios_10.300000&ua=iPhone9_2&imei=&imsi=&uid=530468613&sid=20d7ZHBzMn4XQZUwJxaIrSHn4Ki1OV2v8shjVi2pgrMhjYEGx184&conn=wifi&mtid=b70cf13999285b30e8cb7af3d27be282&mtxid=1675901723b9&logid=226,230&s_sg=fbf14eca21cfbc2c4e7fdf0691616b16&s_sc=100&s_st=1500967789"
//游戏
#define GameScrollURL @"http://webapi.busi.inke.cn/service/ticker?tab_key=29A41F6781AB3447&lc=0000000000000067&cc=TG0001&cv=IK4.0.90_Iphone&proto=7&idfa=18FFBF19-F9C5-430F-B9FA-3ADFA9763739&idfv=F7715FF6-D9C5-40CC-B09C-551AF6B88139&devi=787020bb8b0e1d25ec60b6ac309682f194ee148e&osversion=ios_10.300000&ua=iPhone9_2&imei=&imsi=&uid=530468613&sid=20d7ZHBzMn4XQZUwJxaIrSHn4Ki1OV2v8shjVi2pgrMhjYEGx184&conn=wifi&mtid=b70cf13999285b30e8cb7af3d27be282&mtxid=1675901723b9&logid=226,230&s_sg=f02389372a7360ef044f6703597c6204&s_sc=100&s_st=1501032764"
#define GameURL @"http://service.ingkee.com/api/game/aggregate?gender=1&latitude=34.814051&longitude=113.559864&location=%E9%83%91%E5%B7%9E%E5%B8%82&tab_key=29A41F6781AB3447&lc=0000000000000067&cc=TG0001&cv=IK4.0.90_Iphone&proto=7&idfa=18FFBF19-F9C5-430F-B9FA-3ADFA9763739&idfv=F7715FF6-D9C5-40CC-B09C-551AF6B88139&devi=787020bb8b0e1d25ec60b6ac309682f194ee148e&osversion=ios_10.300000&ua=iPhone9_2&imei=&imsi=&uid=530468613&sid=20d7ZHBzMn4XQZUwJxaIrSHn4Ki1OV2v8shjVi2pgrMhjYEGx184&conn=wifi&mtid=b70cf13999285b30e8cb7af3d27be282&mtxid=1675901723b9&logid=226,230"
//关注
#define AttentionURL @"http://218.11.0.112/api/live/homepage?&gender=1&gps_info=113.559736%2C34.813984&loc_info=%2C%2C&is_new_user=0&location=%2C%2C&hfv=2.1&type=1&multiaddr=1&deleted_uids=&lc=0000000000000067&cc=TG0001&cv=IK4.0.90_Iphone&proto=7&idfa=18FFBF19-F9C5-430F-B9FA-3ADFA9763739&idfv=F7715FF6-D9C5-40CC-B09C-551AF6B88139&devi=0db66da47c599736e74c021a02d481b473e6b93f&osversion=ios_10.300000&ua=iPhone9_2&imei=&imsi=&uid=530468613&sid=20n9DuwArJTywxrl5Ugm5ZkXFFr4zYFovuSCENCEdEWh7Qi2Dnk&conn=wifi&mtid=b70cf13999285b30e8cb7af3d27be282&mtxid=1675901723b9&logid=226,230,240"
//礼物
#define GiftURL @"http://218.11.0.112/api/resource/user_gifts?live_uid=0&mjid=0&type=2&req_stat=2&scale=3&lc=0000000000000067&cc=TG0001&cv=IK4.0.90_Iphone&proto=7&idfa=18FFBF19-F9C5-430F-B9FA-3ADFA9763739&idfv=F7715FF6-D9C5-40CC-B09C-551AF6B88139&devi=0db66da47c599736e74c021a02d481b473e6b93f&osversion=ios_10.300000&ua=iPhone9_2&imei=&imsi=&uid=530468613&sid=20n9DuwArJTywxrl5Ugm5ZkXFFr4zYFovuSCENCEdEWh7Qi2Dnk&conn=wifi&mtid=b70cf13999285b30e8cb7af3d27be282&mtxid=1675901723b9&logid=226,230,240&s_sg=a24b441a1d64b2d6b054757528f067a7&s_sc=100&s_st=1501567541"
//在直播间用户
#define OnlineUsersURL @"http://218.11.0.112/api/live/users?start=0&count=20&id=%@&lc=0000000000000067&cc=TG0001&cv=IK4.0.90_Iphone&proto=7&idfa=18FFBF19-F9C5-430F-B9FA-3ADFA9763739&idfv=F7715FF6-D9C5-40CC-B09C-551AF6B88139&devi=0db66da47c599736e74c021a02d481b473e6b93f&osversion=ios_10.300000&ua=iPhone9_2&imei=&imsi=&uid=530468613&sid=20n9DuwArJTywxrl5Ugm5ZkXFFr4zYFovuSCENCEdEWh7Qi2Dnk&conn=wifi&mtid=b70cf13999285b30e8cb7af3d27be282&mtxid=1675901723b9&logid=226,230,240&s_sg=d037279cf0cee68ec2d447a4cbd145eb&s_sc=100&s_st=1501576061"
//点赞动画的心
#define HeartURL @"http://218.60.113.17/api/resource/like?lc=0000000000000067&cc=TG0001&cv=IK4.0.90_Iphone&proto=7&idfa=0E824AEA-5EA4-465A-961F-F49C3F8B9BB1&idfv=5218E41A-AA6B-4F93-92EF-87B4972882C9&devi=1275f8cd2a81ea422ddc6dd574461e5436f0b96a&osversion=ios_10.300000&ua=iPhone9_2&imei=&imsi=&uid=530468613&sid=20LJMgZmxoblfr3IpsQei2723R6JLOQBEoUTzi16zPdz3xoN2ahi1&conn=wifi&mtid=b70cf13999285b30e8cb7af3d27be282&mtxid=1675901723b9&logid=226,230,240&s_sg=6f4ef3a5fd6aefed02643e9e315db259&s_sc=100&s_st=1501722139"
#endif /* Const_h */
