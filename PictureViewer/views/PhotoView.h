//
//  PhotoView.h
//  PictureViewer
//
//  Created by xueyongwei on 16/3/1.
//  Copyright © 2016年 xueyongwei. All rights reserved.
//

#import <UIKit/UIKit.h>
//@class ViewController;
#import "ViewController.h"

@interface PhotoView : UIView
@property (weak, nonatomic) IBOutlet ViewController *VC;

@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UIImageView *xzView;

@end
