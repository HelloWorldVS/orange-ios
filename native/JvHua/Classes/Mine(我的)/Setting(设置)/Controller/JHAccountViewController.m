//
//  JHAccountViewController.m
//  JvHua
//
//  Created by 乔耐 on 15/11/25.
//  Copyright © 2015年 juzi. All rights reserved.
//

#import "JHAccountViewController.h"
#import "JHAddressController.h"
#import "JHCreditController.h"


#import <ALBB_OSS_IOS_SDK/OSSService.h>

#define ORIGINAL_MAX_WIDTH 640.0f
@interface JHAccountViewController () <UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    NSString *_changeStr;
    
    OSSBucket *bucket;
    OSSData *ossDownloadData;
    OSSData *ossUploadData;
    NSString *accessKey;
    NSString *secretKey;
    NSString *yourBucket;
    NSString *yourDownloadObjectKey;
    NSString *yourUploadObjectKey;
    NSString *yourUploadDataPath;
    NSString *yourHostId;

}
@property (nonatomic, strong) UIImageView *portraitImageView;

@end

@implementation JHAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"账号设置";
   
    self.view.backgroundColor = KLightGreyColor;
    
    UITapGestureRecognizer *view1Tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(view1Tap:)];
    [_view1 addGestureRecognizer:view1Tap];
    
    UITapGestureRecognizer *view2Tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(view2Tap:)];
    [_view2 addGestureRecognizer:view2Tap];
    
    UITapGestureRecognizer *view3Tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(view3Tap:)];
    [_view3 addGestureRecognizer:view3Tap];

}

#pragma mark 选择头像
- (void)view1Tap:(UITapGestureRecognizer *)tap
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从手机相册中选择", nil];
    [actionSheet showInView:self.view];
    
}

#pragma mark 编辑地址管理
- (void)view2Tap:(UITapGestureRecognizer *)tap
{
    JHAddressController *addressList = [[JHAddressController alloc] init];
    [self.navigationController pushViewController:addressList animated:YES];
}


#pragma mark 编辑信用认证
- (void)view3Tap:(UITapGestureRecognizer *)tap
{
    JHCreditController *credit = [[JHCreditController alloc] init];
    [self.navigationController pushViewController:credit animated:YES];
}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [self addCarema];
    }else if (buttonIndex == 1){
        [self openPicLibrary];
    }
}

- (void)addCarema{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:picker animated:YES completion:^{}];
    }else{
        //如果没有提示用户
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Tip" message:@"Your device don't have camera" delegate:nil cancelButtonTitle:@"Sure" otherButtonTitles:nil];
        [alert show];
    }

}


- (void)openPicLibrary{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:picker animated:YES completion:^{
        }];
    }

}




//- (void)initOSSService:(NSString *)objectKey image:(UIImage *)image
//{
//    id<ALBBOSSServiceProtocol> ossService = [ALBBOSSServiceProvider getService];
//    [ossService setGlobalDefaultBucketAcl:PRIVATE];
//    [ossService setGlobalDefaultBucketHostId:yourHostId];
//    [ossService setAuthenticationType:ORIGIN_AKSK];
//    [ossService setGenerateToken:^(NSString *method, NSString *md5, NSString *type, NSString *date, NSString *xoss, NSString *resource){
//        NSString *signature = nil;
//        NSString *content = [NSString stringWithFormat:@"%@\n%@\n%@\n%@\n%@%@", method, md5, type, date, xoss, resource];
//        signature = [OSSTool calBase64Sha1WithData:content withKey:secretKey];
//        signature = [NSString stringWithFormat:@"OSS %@:%@", accessKey, signature];
//        NSLog(@"here signature:%@", signature);
//        return signature;
//    }];
//    bucket = [ossService getBucket:yourBucket];
//    ossUploadData = [ossService getOSSDataWithBucket:bucket key:objectKey];
//    NSData *uploadData = UIImageJPEGRepresentation(image, 1.0);
//    [ossUploadData setData:uploadData withType:@"type"];
//    [ossUploadData enableUploadCheckMd5sum:YES];
//}


#pragma mark - UIImagePickerControllerDelegate
//-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
//    UIImage *editImage = [info objectForKey:UIImagePickerControllerEditedImage];
//    [self dismissViewControllerAnimated:YES completion:^{
//        
//        //        [self.delegate DKInputFunctionView:self sendPicture:editImage];
//        
//        NSString *fileName = [NSString stringWithFormat:@"user_photo_%@.jpg", [JHUtilTool getCurrentToken]];
//        
//        [self initOSSService:fileName image:editImage];
//        
//        
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//            [ossUploadData uploadWithUploadCallback:^(BOOL isSuccess, NSError *error) {
//                if (isSuccess) {
//                    NSLog(@"上传成功");
//                    
//                    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//                    [dict setObject:[JHUtilTool getCurrentToken] forKey:@"token"];
//                    [dict setObject:fileName forKey:@"photo"];
//                    [JHHttpTool putWithURL:KDisplayPic params:dict success:^(id json) {
//                        if ([json[@"code"] integerValue] == 1) {
//                            _iconImage.image = editImage;
//                        }
//                    } failure:^(NSError *error) {
//                        
//                    }];
//                } else {
//                    NSLog(@"上传失败");
//                    NSLog(@"失败原因：%@", error);
//                }
//            } withProgressCallback:^(float progress) {
//                NSLog(@"当前进度： %f", progress);
//                dispatch_async(dispatch_get_main_queue(), ^{
//                });
//            }];
//        });
//    }];
//}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    [picker dismissViewControllerAnimated:YES completion:^() {
        UIImage *portraitImg = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        portraitImg = [self imageByScalingToMaxSize:portraitImg];
        // 裁剪
//        VPImageCropperViewController *imgEditorVC = [[VPImageCropperViewController alloc] initWithImage:portraitImg cropFrame:CGRectMake(0, 100.0f, self.view.frame.size.width, self.view.frame.size.width) limitScaleRatio:3.0];
//        imgEditorVC.delegate = self;
//        [self presentViewController:imgEditorVC animated:YES completion:^{
//            // TO DO
//        }];
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:^(){
    }];
}

#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
}

#pragma mark camera utility
- (BOOL) isCameraAvailable{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}

- (BOOL) isRearCameraAvailable{
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
}

- (BOOL) isFrontCameraAvailable {
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
}

- (BOOL) doesCameraSupportTakingPhotos {
    return [self cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypeCamera];
}

- (BOOL) isPhotoLibraryAvailable{
    return [UIImagePickerController isSourceTypeAvailable:
            UIImagePickerControllerSourceTypePhotoLibrary];
}
- (BOOL) canUserPickVideosFromPhotoLibrary{
    return [self
            cameraSupportsMedia:(__bridge NSString *)kUTTypeMovie sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}
- (BOOL) canUserPickPhotosFromPhotoLibrary{
    return [self
            cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (BOOL) cameraSupportsMedia:(NSString *)paramMediaType sourceType:(UIImagePickerControllerSourceType)paramSourceType{
    __block BOOL result = NO;
    if ([paramMediaType length] == 0) {
        return NO;
    }
    NSArray *availableMediaTypes = [UIImagePickerController availableMediaTypesForSourceType:paramSourceType];
    [availableMediaTypes enumerateObjectsUsingBlock: ^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *mediaType = (NSString *)obj;
        if ([mediaType isEqualToString:paramMediaType]){
            result = YES;
            *stop= YES;
        }
    }];
    return result;
}

#pragma mark image scale utility
- (UIImage *)imageByScalingToMaxSize:(UIImage *)sourceImage {
    if (sourceImage.size.width < ORIGINAL_MAX_WIDTH) return sourceImage;
    CGFloat btWidth = 0.0f;
    CGFloat btHeight = 0.0f;
    if (sourceImage.size.width > sourceImage.size.height) {
        btHeight = ORIGINAL_MAX_WIDTH;
        btWidth = sourceImage.size.width * (ORIGINAL_MAX_WIDTH / sourceImage.size.height);
    } else {
        btWidth = ORIGINAL_MAX_WIDTH;
        btHeight = sourceImage.size.height * (ORIGINAL_MAX_WIDTH / sourceImage.size.width);
    }
    CGSize targetSize = CGSizeMake(btWidth, btHeight);
    return [self imageByScalingAndCroppingForSourceImage:sourceImage targetSize:targetSize];
}

- (UIImage *)imageByScalingAndCroppingForSourceImage:(UIImage *)sourceImage targetSize:(CGSize)targetSize {
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor; // scale to fit height
        else
            scaleFactor = heightFactor; // scale to fit width
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else
            if (widthFactor < heightFactor)
            {
                thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
            }
    }
    UIGraphicsBeginImageContext(targetSize); // this will crop
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil) NSLog(@"could not scale image");
    
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    return newImage;
}

#pragma mark portraitImageView getter
- (UIImageView *)portraitImageView {
    if (!_portraitImageView) {
        CGFloat w = 100.0f; CGFloat h = w;
        CGFloat x = (self.view.frame.size.width - w) / 2;
        CGFloat y = (self.view.frame.size.height - h) / 2;
        _portraitImageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, w, h)];
        [_portraitImageView.layer setCornerRadius:(_portraitImageView.frame.size.height/2)];
        [_portraitImageView.layer setMasksToBounds:YES];
        [_portraitImageView setContentMode:UIViewContentModeScaleAspectFill];
        [_portraitImageView setClipsToBounds:YES];
        _portraitImageView.layer.shadowColor = [UIColor blackColor].CGColor;
        _portraitImageView.layer.shadowOffset = CGSizeMake(4, 4);
        _portraitImageView.layer.shadowOpacity = 0.5;
        _portraitImageView.layer.shadowRadius = 2.0;
        _portraitImageView.layer.borderColor = [[UIColor blackColor] CGColor];
        _portraitImageView.layer.borderWidth = 2.0f;
        _portraitImageView.userInteractionEnabled = YES;
        _portraitImageView.backgroundColor = [UIColor blackColor];
        UITapGestureRecognizer *portraitTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(editPortrait)];
        [_portraitImageView addGestureRecognizer:portraitTap];
    }
    return _portraitImageView;
}

//- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
//    [self dismissViewControllerAnimated:YES completion:nil];
//}
//


//- (void)loadGroups{
//   
//    JHItem *head = [JHItemArrow itemWithTitle:@"头像" icon:@"image"];
//    JHGroup *group1 = [JHGroup groupWithItems:@[head] header:nil];
//    
//    
//    JHItem *add = [JHItemArrow itemWithTitle:@"地址管理" destController:[JHAddressController class]];
//    JHItem *credit = [JHItemArrow itemWithTitle:@"信用认证" destController:[JHCreditController class]];
//    
//    JHGroup *group2 = [JHGroup groupWithItems:@[add,credit]];
//    self.groups = @[group1,group2];
//}



@end
