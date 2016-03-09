//
//  BViewController.m
//  PictureViewer
//
//  Created by xueyongwei on 16/3/7.
//  Copyright © 2016年 xueyongwei. All rights reserved.
//

#import "BViewController.h"
#import "XsingleRotationRecoginzer.h"
#import "InputTextViewController.h"


@interface BViewController ()
{
    BOOL xuanzhuan;
}
@property (weak, nonatomic) IBOutlet UIView *testView;
@property (weak, nonatomic) IBOutlet UILabel *wordLabel;
@property (weak, nonatomic) IBOutlet UIButton *xzBtn;

@end

@implementation BViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    xuanzhuan = NO;
    // Do any additional setup after loading the view, typically from a nib.
    //    self.testView.layer.cornerRadius = 120;
    XsingleRotationRecoginzer *rotationGesture = [[XsingleRotationRecoginzer alloc] initWithTarget:self action:@selector(rotationAction:)];
    rotationGesture.suofang = YES;
    
    [self.testView addGestureRecognizer:rotationGesture];
    
    [self wordLabelAddGues];
}

-(void)wordLabelAddGues
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapWordLabelHandle:)];
    [self.wordLabel addGestureRecognizer:tap];
}
-(void)tapWordLabelHandle:(UITapGestureRecognizer *)recognizer
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    InputTextViewController *ip = [sb instantiateViewControllerWithIdentifier:@"InputTextViewController"];
    [ip stringWith:^(NSString *inputStr) {
        self.wordLabel.text = inputStr;
    }];

    [self.navigationController pushViewController:ip animated:YES];
    
}
- (IBAction)touchDown:(UIButton *)sender {
    xuanzhuan = YES;
    self.testView.tag = XSTAGXuanzhuan;
    NSLog(@"%@",NSStringFromClass([sender.superview class]));
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    xuanzhuan = NO;
    self.testView.tag = XSTAGTuodong;
}
-(void)rotationAction:(XsingleRotationRecoginzer*)rotation {
    if (!xuanzhuan) {
        return;
    }
    rotation.view.transform = CGAffineTransformRotate(rotation.view.transform, rotation.rotation);
    rotation.rotation = 0;
    rotation.view.transform = CGAffineTransformScale(rotation.view.transform, rotation.scale, rotation.scale);
    self.xzBtn.transform = CGAffineTransformScale(self.xzBtn.transform, 1.0f/rotation.scale, 1.0f/rotation.scale);
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
