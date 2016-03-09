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
    [self.drawView backDraw];
}
- (IBAction)onColorCLick:(UIButton *)sender {
    self.drawView.erase = NO;
    self.drawView.color = sender.backgroundColor;
}
- (IBAction)onEraseClick:(UIButton *)sender {
    self.drawView.erase = YES;
    self.drawView.color = [UIColor clearColor];
}
-(UIImage *)getImageFromView:(UIView *)theView
{
    //UIGraphicsBeginImageContext(theView.bounds.size);
    UIGraphicsBeginImageContextWithOptions(theView.bounds.size, NO, [UIScreen mainScreen].scale);
    [theView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
- (IBAction)onSaveClicj:(UIButton *)sender {
    
    UIImage *img = [self.drawView getImage];
    ShowViewController *sh = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ShowViewController"];
    sh.img = img;
    [self.navigationController pushViewController:sh animated:YES];
//    UIImageWriteToSavedPhotosAlbum(img, self, @selector(savedPhotoImage:didFinishSavingWithError:contextInfo:), nil);
}
- (void)savedPhotoImage:(UIImage*)image didFinishSavingWithError:(NSError *)error contextInfo: (void *)contextInfo {
    NSLog(@"%@", [error localizedDescription]);
    NSLog(@"info: %@", contextInfo);
    NSString *msg;
    if(error != NULL){
        msg = @"保存图片失败" ;
    }else{
        msg = @"保存图片成功" ;
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:msg
                                                    message:nil
                                                   delegate:self
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil];
    [alert show];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
