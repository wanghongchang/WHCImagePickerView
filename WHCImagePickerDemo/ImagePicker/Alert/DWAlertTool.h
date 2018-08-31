//
//  DWAlertTool.h
//  DWduifubao
//
//  Created by 席亚坤 on 2017/7/13.
//  Copyright © 2017年 bianming. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface DWAlertTool : NSObject
typedef void(^OKDefault)(UIAlertAction*defaultaction);
typedef void(^OK1Default)(UIAlertAction*defaultaction);
typedef void(^Cancel)(UIAlertAction *cancelaction);
///取消确定 --居中
+(void)alertWithTitle:(NSString*)title message:(NSString*)message OKWithTitle:(NSString*)OKtitle  CancelWithTitle:(NSString*)Canceltitle withOKDefault:(OKDefault)defaultaction withCancel:(Cancel)cancelaction;
+(void)photoAlertWithTitle:(NSString*)title message:(NSString*)message OKWithTitle:(NSString*)OKtitle OK1WithTitle:(NSString*)OK1title CancelWithTitle:(NSString*)Canceltitle withOKDefault:(OKDefault)defaultaction withOK1Default:(OK1Default)defaultaction1 withCancel:(Cancel)cancelaction;
@end
