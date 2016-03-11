//
//  InputTextViewController.h
//  PictureViewer
//
//  Created by xueyongwei on 16/3/7.
//  Copyright © 2016年 xueyongwei. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^inputBlock) (NSString *inputStr);
typedef void (^iptTextImgBlock) (UIImage *image);
@interface InputTextViewController : UIViewController
-(void)stringWith:(inputBlock)block;
-(void)imgWith:(iptTextImgBlock)block;
@end
