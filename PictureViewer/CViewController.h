//
//  CViewController.h
//  PictureViewer
//
//  Created by xueyongwei on 16/3/7.
//  Copyright © 2016年 xueyongwei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
typedef void (^scrowImgBlock) (UIImage *image);
@interface CViewController : UIViewController

-(void)imgWith:(scrowImgBlock)block;
@end
