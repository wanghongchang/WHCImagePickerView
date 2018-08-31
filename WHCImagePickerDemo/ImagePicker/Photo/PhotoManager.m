//
//  PhotoManager.m
//  WHCBase
//
//  Created by 汪弘昌 on 2018/8/20.
//  Copyright © 2018年 1111. All rights reserved.
//

#import "PhotoManager.h"

@interface PhotoManager()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,LGPhotoPickerViewControllerDelegate>


@end

@implementation PhotoManager

+(PhotoManager*)shareManager{
    static PhotoManager *photoManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        photoManager = [[PhotoManager alloc]init];
    });
    return photoManager;
}
#pragma mark ************系统
- (void)jumpPhotoAlbum
{
    __weak typeof(self) weakSelf = self;
    [DWAlertTool photoAlertWithTitle:nil message:nil OKWithTitle:@"相册" OK1WithTitle:@"相机" CancelWithTitle:@"取消" withOKDefault:^(UIAlertAction *defaultaction) {
        [weakSelf openAlbum];
    } withOK1Default:^(UIAlertAction *defaultaction) {
        [weakSelf openCamera];
    } withCancel:^(UIAlertAction *cancelaction) {
        
    }];
}

- (void)openAlbum {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.allowsEditing = YES;
    picker.delegate = self;
    [[ToolsManager getCurrentUIVC] presentViewController:picker animated:YES completion:nil];
}
- (void)openCamera {
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    
    if ([UIImagePickerController isSourceTypeAvailable: sourceType]){
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = sourceType;
        [[ToolsManager getCurrentUIVC] presentViewController:picker animated:YES completion:nil];
    }else{
        [DWAlertTool alertWithTitle:@"该设备不支持拍照" message:nil OKWithTitle:@"确定" CancelWithTitle:nil withOKDefault:^(UIAlertAction *defaultaction) {
            
        } withCancel:nil];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    NSLog(@"图片选择完成");
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [[ToolsManager getCurrentUIVC] dismissViewControllerAnimated:YES completion:nil];
    if (self.selectImage)
    {
        self.selectImage(image);
    }
}

#pragma mark ************自定义
- (void)jumpCustomPhotoAlbum
{
    __weak typeof(self) weakSelf = self;
    [DWAlertTool photoAlertWithTitle:nil message:nil OKWithTitle:@"相册" OK1WithTitle:@"相机" CancelWithTitle:@"取消" withOKDefault:^(UIAlertAction *defaultaction) {
        [weakSelf openCustomAlbum];
    } withOK1Default:^(UIAlertAction *defaultaction) {
        
    } withCancel:^(UIAlertAction *cancelaction) {
        
    }];
}

- (void)openCustomAlbum {
    LGPhotoPickerViewController *pickerVc = [[LGPhotoPickerViewController alloc] initWithShowType:LGShowImageTypeImagePicker];
    pickerVc.status = PickerViewShowStatusCameraRoll;
    pickerVc.maxCount = _maxCount;   // 最多能选9张图片
    pickerVc.delegate = self;
    [pickerVc showPickerVc:[ToolsManager getCurrentUIVC]];
}

- (void)openCustomCamera {
    ZLCameraViewController *cameraVC = [[ZLCameraViewController alloc] init];
    // 拍照最多个数
    cameraVC.maxCount = 1;
    // 单拍
    cameraVC.cameraType = ZLCameraSingle;
    cameraVC.callback = ^(NSArray *cameras){
        //在这里得到拍照结果
        //数组元素是ZLCamera对象
        /*
         @exemple
         ZLCamera *canamerPhoto = cameras[0];
         UIImage *image = canamerPhoto.photoImage;
         */
        if (self.customCameraImages)
        {
            self.customCameraImages(cameras);
        }
    };
    [cameraVC showPickerVc:[ToolsManager getCurrentUIVC]];
}

#pragma mark - LGPhotoPickerViewControllerDelegate

- (void)pickerViewControllerDoneAsstes:(NSArray <LGPhotoAssets *> *)assets isOriginal:(BOOL)original{
    if (self.selectCustomImages)
    {
        self.selectCustomImages(assets);
    }
}





@end
