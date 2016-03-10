//
//  ShowViewController.m
//  PictureViewer
//
//  Created by xueyongwei on 16/3/8.
//  Copyright © 2016年 xueyongwei. All rights reserved.
//

#import "ShowViewController.h"
#import "XimgView.h"
#import "XsingleRotationRecoginzer.h"


@interface ShowViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@end

@implementation ShowViewController
{
    XsingleRotationRecoginzer *xsGesture;
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    self.imgView.image = self.img;
    [self loadXimgViewWithImg:self.img];
}
-(void)loadXimgViewWithImg:(UIImage *)image
{
    XimgView *xv = [[[NSBundle mainBundle]loadNibNamed:@"XimgView" owner:self options:nil]lastObject];
    
    NSLog(@"拿到图片:%@",NSStringFromCGSize(image.size));
    xv.frame = CGRectMake(100, 100, 120, 100);
    xv.img = image;
    [self addXgingOnView:xv];
    [self.view addSubview:xv];
}
-(void)addXgingOnView:(UIView *)view
{
    xsGesture = [[XsingleRotationRecoginzer alloc]initWithTarget:self action:@selector(xsHandle:)];
    [view addGestureRecognizer:xsGesture];
}
-(void)xsHandle:(XsingleRotationRecoginzer *)recognizer
{
    recognizer.view.transform = CGAffineTransformRotate(recognizer.view.transform, recognizer.rotation);
    recognizer.rotation = 0;
    recognizer.view.transform = CGAffineTransformScale(recognizer.view.transform, recognizer.scale, recognizer.scale);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
