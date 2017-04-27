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
#import "DatePickerViewController.h"
#import "LookUpReservationController.h"

#import <Crashlytics/Crashlytics.h>

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
    
    [AutoLayout leadingConstraintFrom:bookButton toView: self.view];
    [AutoLayout trailingConstraintFrom:bookButton toView: self.view];
    
    [AutoLayout leadingConstraintFrom:lookUpButton toView: self.view];
    [AutoLayout trailingConstraintFrom:lookUpButton toView: self.view];
    
    
    NSLayoutConstraint *browseHeight = [AutoLayout genericConstraintFrom:browseButton toView:self.view withAttribute:NSLayoutAttributeTop];
    browseHeight.constant = navBarHeight;
    
    NSLayoutConstraint *bookHeight = [AutoLayout genericConstraintFrom:bookButton toView:self.view withAttribute:NSLayoutAttributeCenterY];
    bookHeight.constant = navBarHeight / 2;
    
    [AutoLayout genericConstraintFrom:lookUpButton toView:self.view withAttribute:NSLayoutAttributeBottom];

    [AutoLayout genericConstraintFrom:bookButton toView:self.view withAttribute:NSLayoutAttributeHeight andMultiplier:0.33];
    [AutoLayout equalHeightConstraintFromView:browseButton toView:bookButton withMultiplier:1.0];
    [AutoLayout equalHeightConstraintFromView:bookButton toView:lookUpButton withMultiplier:1.0];
    
    [browseButton addTarget:self action:@selector(browseButtonSelected) forControlEvents:UIControlEventTouchUpInside];
    [bookButton addTarget:self action:@selector(bookButtonSelected) forControlEvents:UIControlEventTouchUpInside];
    [lookUpButton addTarget:self action:@selector(lookUpButtonSelected) forControlEvents:UIControlEventTouchUpInside];
}

- (void)browseButtonSelected {
    HotelsViewController *hotelsView = [[HotelsViewController alloc]init];
    [Answers logCustomEventWithName:@"ViewController - Browse Button Pressed" customAttributes:nil];
    [self.navigationController pushViewController:hotelsView animated:YES];
}

- (void)bookButtonSelected {
    DatePickerViewController *datePicker = [[DatePickerViewController alloc]init];
    [Answers logCustomEventWithName:@"ViewController - Book Button Pressed" customAttributes:nil];
    [self.navigationController pushViewController:datePicker animated:YES];
}

- (void)lookUpButtonSelected {
    LookUpReservationController *reservations = [[LookUpReservationController alloc]init];
    [Answers logCustomEventWithName:@"ViewController - Look Up Button Pressed" customAttributes:nil];
    [self.navigationController pushViewController:reservations animated:YES];
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
