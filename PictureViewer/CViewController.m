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
{
    scrowImgBlock tempBlock;
}
@property (weak, nonatomic) IBOutlet DrawView *drawView;

@end

@implementation CViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
-(void)imgWith:(scrowImgBlock)block
{
    tempBlock = block;
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
- (IBAction)onSaveClicj:(UIButton *)sender {
    
    if ([self.drawView getImage]) {
        tempBlock([self.drawView getImage]);
        [self.navigationController popViewControllerAnimated:YES];   
    }else
    {
        NSLog(@"无图像！");
    }
}

@end
