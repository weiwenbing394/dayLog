//
//  Test3.m
//  test
//
//  Created by Admin on 2017/12/15.
//  Copyright © 2017年 xiaowei. All rights reserved.
//

#import "Test3.h"
#import "Test1.h"
#import "Test2.h"

@interface Test3 ()

@property (nonatomic,strong) Test1 *test1;

@property (nonatomic,strong) Test2 *test2;

@property (nonatomic,strong) UIViewController *currentVC;

@end

@implementation Test3

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn1=[[UIButton alloc]initWithFrame:CGRectMake(10, 20, 100, 44)];;
    [btn1 setTitle:@"第一个" forState:0];
    [btn1 setBackgroundColor:[UIColor blackColor]];
    btn1.tag=0;
    [btn1 setTitleColor:[UIColor whiteColor] forState:0];
    [btn1 addTarget:self action:@selector(changeVC:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    UIButton *btn2=[[UIButton alloc]initWithFrame:CGRectMake(120, 20, 100, 44)];;
    [btn2 setTitle:@"第二个" forState:0];
    btn2.tag=1;
    [btn2 setBackgroundColor:[UIColor blackColor]];
    [btn2 setTitleColor:[UIColor whiteColor] forState:0];
    [btn2 addTarget:self action:@selector(changeVC:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    
    
    self.test1=[[Test1 alloc]init];
    self.test2=[[Test2 alloc]init];
    
    
    
    
    [self addChildViewController:self.test2];
    self.test2.view.frame=CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64);
    [self.view addSubview:self.test2.view];
    [self.test2 didMoveToParentViewController:self];
    
 
//    self.test1.view.frame=CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64);
//    [self.view addSubview:self.test1.view];
//    [self.test1 didMoveToParentViewController:self];
//    self.currentVC=self.test1;
    
}

- (void)changeVC:(UIButton *)sender{
    if (sender.tag==0) {
        [self replaceController:self.test2 newController:self.test1];
    }else{
        [self replaceController:self.test1 newController:self.test2];
    }
}

- (void)replaceController:(UIViewController *)oldController newController:(UIViewController *)newController{
    
//        [self addChildViewController:newController];
//        [oldController willMoveToParentViewController:nil];
    
    
    [self addChildViewController:newController];
    
    [self transitionFromViewController:oldController toViewController:oldController duration:1 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
        
        newController.view.frame=CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64);
        [self.view addSubview:newController.view];
        [newController didMoveToParentViewController:self];
        
        [oldController willMoveToParentViewController:nil];
        [oldController.view removeFromSuperview];
        [oldController removeFromParentViewController];
        
    } completion:^(BOOL finished) {
        
//        newController.view.frame=CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64);
//        [self.view addSubview:newController.view];
//
//        [oldController.view removeFromSuperview];
        
//
//        if (finished) {
//            [newController didMoveToParentViewController:self];
//
//            [oldController willMoveToParentViewController:nil];
//            [oldController removeFromParentViewController];
//            self.currentVC=newController;
//        }else{
//            self.currentVC=oldController;
//        }
        
    }];
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
