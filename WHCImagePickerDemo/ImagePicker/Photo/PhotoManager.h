//
//  PhotoManager.h
//  WHCBase
//
//  Created by 汪弘昌 on 2018/8/20.
//  Copyright © 2018年 1111. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DWAlertTool.h"
#import <UIKit/UIKit.h>
#import "ToolsManager.h"
#import "LGPhotoPickerViewController.h"
#import "ZLCameraViewController.h"

@interface PhotoManager : NSObject
@property (nonatomic, assign)NSInteger maxCount;
@property (nonatomic, copy) void(^selectImage)(UIImage* image);
@property (nonatomic, copy) void(^selectCustomImages)(NSArray <LGPhotoAssets *> * images);
@property (nonatomic, copy) void(^customCameraImages)(NSArray <ZLCamera *> * images);
+(PhotoManager*)shareManager;
- (void)jumpPhotoAlbum;
- (void)jumpCustomPhotoAlbum;
@end
