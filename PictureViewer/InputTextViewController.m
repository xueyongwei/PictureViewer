//
//  InputTextViewController.m
//  PictureViewer
//
//  Created by xueyongwei on 16/3/7.
//  Copyright © 2016年 xueyongwei. All rights reserved.
//

#import "InputTextViewController.h"

@interface InputTextViewController ()<UITextViewDelegate>
{
    iptTextImgBlock tempBlock;
    inputBlock tBlock;
}
@property (weak, nonatomic) IBOutlet UILabel *reviewLabel;
@property (weak, nonatomic) IBOutlet UITextView *inputTV;
@end

@implementation InputTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.inputTV.delegate = self;
    
    self.inputTV.layer.borderWidth = 1.0;
    self.inputTV.layer.borderColor = [UIColor darkGrayColor].CGColor;
    // Do any additional setup after loading the view.
}

- (IBAction)onOKClick:(UIButton *)sender {
    if (tBlock) {
        tBlock(self.inputTV.text);
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    if ([self getImage]) {
        tempBlock([self getImage]);
        [self.navigationController popViewControllerAnimated:YES];
    }else
    {
        NSLog(@"无图像！");
    }
    
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(nonnull NSString *)text
{
    return YES;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.inputTV resignFirstResponder];
}
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@"请输入文字"]) {
        textView.text = @"";
    }
    [self textShouldUpdate:textView.text];
}
-(void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length>2) {
        [self textShouldUpdate:[textView.text substringToIndex:2]];
        return;
    }
    [self textShouldUpdate:textView.text];
}
-(void)textViewDidEndEditing:(UITextView *)textView
{
    [self textViewDidChange:textView];
}
-(void)textShouldUpdate:(NSString *)str
{
    self.reviewLabel.text = str;
}
-(void)imgWith:(iptTextImgBlock)block
{
    tempBlock = block;
}
-(void)stringWith:(inputBlock)block
{
    tBlock = block;
}
- (IBAction)onSystemFontClick:(UIButton *)sender {
    self.reviewLabel.font = [UIFont systemFontOfSize:20];
    
}
- (IBAction)onXiaowanziClick:(UIButton *)sender {
    self.reviewLabel.font = [UIFont fontWithName:@"SentyMARUKO" size:20];
}

- (UIImage *)getImage {
    if (self.inputTV.text.length==0) {
        NSLog(@"未输入文字！");
        return nil;
    }
    // 开启上下文
    
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(50, 21), NO, 0.0);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    ///只裁剪用户有涂鸦的部分
    CGContextBeginPath(context);
    //    CGContextAddRect(context, imageFrame);
    //    CGContextClip(context);
    
    // 将控制器view的layer渲染到上下文
    [self.reviewLabel.layer renderInContext:context];
    
    // 取出图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 结束上下文
    UIGraphicsEndImageContext();
    return newImage;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
