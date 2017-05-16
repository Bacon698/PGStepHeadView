//
//  ViewController.m
//  PGStepHeadView
//
//  Created by 张培根 on 2017/5/16.
//
//


#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIView *headViewA;
@property (weak, nonatomic) IBOutlet UIView *headViewB;
@property (weak, nonatomic) IBOutlet UIView *headViewC;

@property (strong,nonatomic) PGStepHeadView *stepHeadViewA;
@property (strong,nonatomic) PGStepHeadView *stepHeadViewB;
@property (strong,nonatomic) PGStepHeadView *stepHeadViewC;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.stepHeadViewA = [[PGStepHeadView alloc]initWithTitles:@[@"第一步",@"第二步"] equalInterval:YES];
    [self.stepHeadViewA addToView:self.headViewA];
    [self.stepHeadViewA setIndex:1];

    self.stepHeadViewB = [[PGStepHeadView alloc]initWithTitles:@[@"第一步",@"第二步",@"第三步",@"第四步",@"第五步"]];
    [self.stepHeadViewB addToView:self.headViewB];
    [self.stepHeadViewB setIndex:2];
    
    self.stepHeadViewC = [[PGStepHeadView alloc]initWithStepCount:4];
    [self.stepHeadViewC addToView:self.headViewC];
    [self.stepHeadViewC setIndex:3];
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
