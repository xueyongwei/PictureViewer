//
//  ViewController.h
//  PictureViewer
//
//  Created by xueyongwei on 16/3/1.
//  Copyright © 2016年 xueyongwei. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "XimgView.h"

@protocol ViewControllerDelegate

-(void)loadXimgViewWithImg:(UIImage *)image;

@end

@interface ViewController : UIViewController
-(void)xFocusChange:(XimgView *)view;
@end

