//
//  ViewController.m
//  PGStepHeadView
//
//  Created by 张培根 on 2017/5/16.
//
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIView *headView;
@property (strong,nonatomic) PGStepHeadView *stepHeadView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.stepHeadView = [[PGStepHeadView alloc]initWithTitles:@[@"第一步",@"第二步",@"第三步",@"第四步"]];
    [self.stepHeadView addToView:self.headView];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
