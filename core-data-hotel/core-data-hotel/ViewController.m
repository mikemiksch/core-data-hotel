//
//  ViewController.m
//  core-data-hotel
//
//  Created by Mike Miksch on 4/24/17.
//  Copyright © 2017 Mike Miksch. All rights reserved.
//

#import "ViewController.h"
#import "AutoLayout.h"
#import "HotelsViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)loadView {
    [super loadView];
    
    self.view.backgroundColor = [UIColor whiteColor];

    [self setupLayout];

}


- (void)setupLayout {
    
    float navBarHeight = CGRectGetHeight(self.navigationController.navigationBar.frame);
    
    UIButton *browseButton = [self createButtonWithTitle:@"Browse"];
    UIButton *bookButton = [self createButtonWithTitle:@"Book"];
    UIButton *lookUpButton = [self createButtonWithTitle:@"Look Up"];
    
    [AutoLayout leadingConstraintFrom:browseButton toView: self.view];
    [AutoLayout trailingConstraintFrom:browseButton toView: self.view];
    
    NSLayoutConstraint *browseHeight = [AutoLayout genericConstraintFrom:browseButton toView:self.view withAttribute:NSLayoutAttributeHeight];
    
    [browseButton addTarget:self action:@selector(browseButtonSelected) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)browseButtonSelected {
    HotelsViewController *hotelsView = [[HotelsViewController alloc]init];
    NSLog(@"Work on this for lab!");
    [self.navigationController pushViewController:hotelsView animated:YES];
//    [self presentViewController:hotelsView animated:YES completion:nil];
}


- (UIButton *)createButtonWithTitle:(NSString *)title {
    
    UIButton *button = [[UIButton alloc]init];
    
    [button setTitle:title forState:normal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [button setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [self.view addSubview:button];
    
    return button;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
