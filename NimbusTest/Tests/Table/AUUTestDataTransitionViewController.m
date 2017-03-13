//
//  AUUTestDataTransitionViewController.m
//  Nimbus
//
//  Created by JyHu on 2017/3/13.
//
//

#import "AUUTestDataTransitionViewController.h"
#import "NimbusCore.h"

@interface AUUTestDataTransitionViewController () <NIActionsDataTransition>

@end

@implementation AUUTestDataTransitionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"导航栏标题";
    
    UILabel *label = [[UILabel alloc] initWithFrame:self.view.frame];
    label.text = @"点击返回";
    label.textColor = [UIColor redColor];
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
}

- (void)transitionFrom:(id)controller withObject:(id)object userInfo:(id)info
{
    NSLog(@"%@ -- %@ -- %@", controller, object, info);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
