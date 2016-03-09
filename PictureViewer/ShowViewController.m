//
//  ShowViewController.m
//  PictureViewer
//
//  Created by xueyongwei on 16/3/8.
//  Copyright © 2016年 xueyongwei. All rights reserved.
//

#import "ShowViewController.h"

@interface ShowViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@end

@implementation ShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.imgView.image = self.img;
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
