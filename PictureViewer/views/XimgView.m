//
//  XimgView.m
//  PictureViewer
//
//  Created by xueyongwei on 16/3/10.
//  Copyright © 2016年 xueyongwei. All rights reserved.
//

#import "XimgView.h"
#import "XsingleRotationRecoginzer.h"
@interface XimgView()
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UIButton *delBtn;
@property (weak, nonatomic) IBOutlet UIButton *xzBtn;

@end

@implementation XimgView
-(void)setImg:(UIImage *)img
{
    self.imgView.image = img;
}
- (IBAction)touchDown:(UIButton *)sender {
    NSLog(@"改为旋转");
    sender.superview.tag = XSTAGXuanzhuan;
}
-(void)setXFocused:(BOOL)xFocused
{
    if (xFocused) {
        self.delBtn.hidden = NO;
        self.xzBtn.hidden = NO;
    }else
    {
        self.delBtn.hidden = YES;
        self.xzBtn.hidden = YES;
    }
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"改为拖动");
    self.tag = XSTAGTuodong;
    self.xFocused = YES;
}
- (IBAction)delCilck:(UIButton *)sender {
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    [self removeFromSuperview];
}

@end
