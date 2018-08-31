//
//  DWAlertTool.m
//  DWduifubao
//
//  Created by 席亚坤 on 2017/7/13.
//  Copyright © 2017年 bianming. All rights reserved.
//

#import "DWAlertTool.h"
#import "ToolsManager.h"
@implementation DWAlertTool
#pragma mark - 取消确定 --居中
+(void)alertWithTitle:(NSString*)title message:(NSString*)message OKWithTitle:(NSString*)OKtitle  CancelWithTitle:(NSString*)Canceltitle withOKDefault:(OKDefault)defaultaction withCancel:(Cancel)cancelaction{
    UIAlertController * alertC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction * OK = [UIAlertAction actionWithTitle:OKtitle style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        defaultaction (action);
    }];
    if (Canceltitle.length)
    {
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:Canceltitle style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
            cancelaction (action);
        }];
        [alertC addAction:cancel];
    }
    [alertC addAction:OK];
    [[ToolsManager getCurrentUIVC] presentViewController:alertC animated:NO completion:nil];
}

#pragma mark ************照片专用
+(void)photoAlertWithTitle:(NSString*)title message:(NSString*)message OKWithTitle:(NSString*)OKtitle OK1WithTitle:(NSString*)OK1title CancelWithTitle:(NSString*)Canceltitle withOKDefault:(OKDefault)defaultaction withOK1Default:(OK1Default)defaultaction1 withCancel:(Cancel)cancelaction{
    UIAlertController * alertC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:(UIAlertControllerStyleActionSheet)];
    UIAlertAction * OK = [UIAlertAction actionWithTitle:OKtitle style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        defaultaction (action);
    }];
    UIAlertAction * OK1 = [UIAlertAction actionWithTitle:OK1title style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        defaultaction1 (action);
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:Canceltitle style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        cancelaction (action);
    }];
    [alertC addAction:OK];
    [alertC addAction:OK1];
    [alertC addAction:cancel];
    UIViewController *vc = [ToolsManager getCurrentUIVC];
    [vc presentViewController:alertC animated:NO completion:nil];
}





@end
