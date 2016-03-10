//
//  CViewController.m
//  PictureViewer
//
//  Created by xueyongwei on 16/3/7.
//  Copyright © 2016年 xueyongwei. All rights reserved.
//

#import "CViewController.h"
#import "DrawView.h"
#import "ShowViewController.h"

@interface CViewController ()
@property (weak, nonatomic) IBOutlet DrawView *drawView;

@end

@implementation CViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)onBackClick:(UIButton *)sender {
    [self.drawView unDo];
}
- (IBAction)onRedoClick:(UIButton *)sender {
    [self.drawView reDo];
}

- (IBAction)onColorCLick:(UIButton *)sender {
    self.drawView.erase = NO;
    self.drawView.color = sender.backgroundColor;
}
- (IBAction)onEraseClick:(UIButton *)sender {
    self.drawView.erase = YES;
    self.drawView.color = [UIColor clearColor];
}
//-(UIImage *)getImageFromView:(UIView *)theView
//{
//    UIGraphicsBeginImageContextWithOptions(theView.bounds.size, NO, [UIScreen mainScreen].scale);
//    [theView.layer renderInContext:UIGraphicsGetCurrentContext()];
//    UIImage *image=UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    return image;
//}
- (IBAction)onSaveClicj:(UIButton *)sender {
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    if ([self.drawView getImage]) {
        NSNotification *noti = [NSNotification notificationWithName:@"loadImg" object:nil userInfo:@{@"image":[self.drawView getImage]}];
        [center postNotification:noti];
        
        [self.navigationController popViewControllerAnimated:YES];
    }else
    {
        NSLog(@"无图像！");
    }
   
//    UIImage *img = [self.drawView getImage];
//    ShowViewController *sh = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ShowViewController"];
//    sh.img = img;
//    [self.navigationController pushViewController:sh animated:YES];
}

@end
