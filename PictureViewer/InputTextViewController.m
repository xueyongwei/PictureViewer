//
//  InputTextViewController.m
//  PictureViewer
//
//  Created by xueyongwei on 16/3/7.
//  Copyright © 2016年 xueyongwei. All rights reserved.
//

#import "InputTextViewController.h"

@interface InputTextViewController ()
{
    inputBlock tempBlock;
}
@property (weak, nonatomic) IBOutlet UITextField *inputTF;
@end

@implementation InputTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)onOKClick:(UIButton *)sender {
    tempBlock(self.inputTF.text);
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)stringWith:(inputBlock)block
{
    tempBlock = block;
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
