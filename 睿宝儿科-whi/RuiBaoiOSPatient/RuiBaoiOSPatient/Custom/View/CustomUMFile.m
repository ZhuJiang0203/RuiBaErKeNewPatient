//
//  CustomUMFile.m
//  RuiBaoiOSDoctor
//
//  Created by whj on 16/5/27.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//

#import "CustomUMFile.h"
#import "UMSocialDataService.h"
#import "UMSocial.h"

@implementation CustomUMFile

+ (void)setupCustomUMFileWithCurrentVC:(UIViewController *)vc title: (NSString *)title content: (NSString *)content img: (UIImage *)img url: (NSString *)url toType: (NSString *)type {

    // 取消提示
    [UMSocialConfig setFinishToastIsHidden:YES  position:UMSocialiToastPositionCenter];

    switch (type.intValue) {
        case 0: { // 患者
            
            break;
        }
        case 1: { // 朋友圈
            
            [UMSocialData defaultData].extConfig.wechatTimelineData.url = url;
            [UMSocialData defaultData].extConfig.wechatTimelineData.title = content;
            
            [[UMSocialDataService defaultDataService] postSNSWithTypes:@[UMShareToWechatTimeline] content:content image:img location:nil urlResource:nil presentedController:nil completion:^(UMSocialResponseEntity *response){
                NSLog(@"%@", response);
                if (response.responseCode == UMSResponseCodeSuccess) { // 成功
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"kShareSuccess" object:nil];
                } else if (response.responseCode == UMSResponseCodeCancel) { // 取消
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"kShareCancle" object:nil];
                } else { // 失败
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"kShareFailed" object:nil];
                }
            }];
            break;
        }
        case 2: { // 微信
            // 设置分享消息类型
            // 应用分享类型: 如果用户已经安装应用，则打开APP，如果为安装APP，则提示未安装或跳转至微信开放平台
            //            [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeApp;
            
            [UMSocialData defaultData].extConfig.wechatSessionData.url = url;
            [UMSocialData defaultData].extConfig.wechatSessionData.title = title;
            
            [[UMSocialDataService defaultDataService] postSNSWithTypes:@[UMShareToWechatSession] content:content image:img location:nil urlResource:nil presentedController:vc completion:^(UMSocialResponseEntity *response){
                NSLog(@"%u", response.responseCode);
                if (response.responseCode == UMSResponseCodeSuccess) { // 成功
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"kShareSuccess" object:nil];
                } else if (response.responseCode == UMSResponseCodeCancel) { // 取消
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"kShareCancle" object:nil];
                } else { // 失败
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"kShareFailed" object:nil];
                }
            }];
            break;
        }
        case 3: { // QQ
            [UMSocialData defaultData].extConfig.qqData.url = url;
            [UMSocialData defaultData].extConfig.qqData.title = title;
            
            [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToQQ] content:content image:img location:nil urlResource:nil presentedController:vc completion:^(UMSocialResponseEntity *response){
                NSLog(@"%@", response);
                if (response.responseCode == UMSResponseCodeSuccess) { // 成功
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"kShareSuccess" object:nil];
                } else if (response.responseCode == UMSResponseCodeCancel) { // 取消
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"kShareCancle" object:nil];
                } else { // 失败
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"kShareFailed" object:nil];
                }
            }];

            break;
        }
        case 4: { // QQ空间
            [UMSocialData defaultData].extConfig.qzoneData.url = url;
            [UMSocialData defaultData].extConfig.qzoneData.title = title;
            
            [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToQzone] content:content image:img location:nil urlResource:nil presentedController:vc completion:^(UMSocialResponseEntity *response){
                NSLog(@"%@", response);
                if (response.responseCode == UMSResponseCodeSuccess) { // 成功
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"kShareSuccess" object:nil];
                } else if (response.responseCode == UMSResponseCodeCancel) { // 取消
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"kShareCancle" object:nil];
                } else { // 失败
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"kShareFailed" object:nil];
                }
            }];

            break;
        }
        case 5: {
            
            [UMSocialData defaultData].extConfig.sinaData.snsName = @"睿宝儿科";
            [UMSocialData defaultData].extConfig.sinaData.shareText = content;
            [UMSocialData defaultData].extConfig.sinaData.shareImage = img;
            [UMSocialData defaultData].extConfig.sinaData.urlResource.url = url;

            [[UMSocialDataService defaultDataService] postSNSWithTypes:@[UMShareToSina] content:content image:img location:nil urlResource:nil presentedController:vc completion:^(UMSocialResponseEntity *response) {
                if (response.responseCode == UMSResponseCodeSuccess) { // 成功
                    
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"kShareSuccess" object:nil];
                } else if (response.responseCode == UMSResponseCodeCancel) { // 取消
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"kShareCancle" object:nil];
                } else { // 失败
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"kShareFailed" object:nil];
                }
            }];
            break;
        }

        default:
            break;
    }
}

@end

