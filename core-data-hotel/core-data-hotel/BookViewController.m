//
//  BookViewController.m
//  core-data-hotel
//
//  Created by Mike Miksch on 4/25/17.
//  Copyright © 2017 Mike Miksch. All rights reserved.
//

#import "BookViewController.h"
#import "Guest+CoreDataClass.h"
#import "Guest+CoreDataProperties.h"
#import "AutoLayout.h"

@interface BookViewController ()


@property(strong, nonatomic) UITextField *firstName;
@property(strong, nonatomic) UITextField *lastName;
@property(strong, nonatomic) UITextField *email;

@end

@implementation BookViewController

- (void)loadView {
    [super loadView];
    [self setupReservationInfo];
    [self.view setBackgroundColor:[UIColor whiteColor]];
}

-(void)setupReservationInfo {
    
    UIButton *bookReservationButton = [self createButtonWithTitle:@"Book Reservation"];
    
    self.firstName = [[UITextField alloc]init];
    self.lastName = [[UITextField alloc]init];
    self.email = [[UITextField alloc]init];
    
    self.firstName.placeholder = @"First Name";
    self.lastName.placeholder = @"Last Name";
    self.email.placeholder = @"Email Address";
    
    [self.view addSubview:self.firstName];
    [self.view addSubview:self.lastName];
    [self.view addSubview:self.email];
    
    self.firstName.translatesAutoresizingMaskIntoConstraints = NO;
    self.lastName.translatesAutoresizingMaskIntoConstraints = NO;
    self.email.translatesAutoresizingMaskIntoConstraints = NO;
    
    [AutoLayout leadingConstraintFrom:self.firstName toView:self.view];
    [AutoLayout trailingConstraintFrom:self.firstName toView:self.view];
    [AutoLayout genericConstraintFrom:self.firstName toView:self.view withAttribute:NSLayoutAttributeTop andConstant:75.0];
    
    [AutoLayout leadingConstraintFrom:self.lastName toView:self.view];
    [AutoLayout trailingConstraintFrom:self.lastName toView:self.view];
    [AutoLayout genericConstraintFrom:self.lastName toView:self.view withAttribute:NSLayoutAttributeTop andConstant:100.0];
    
    [AutoLayout leadingConstraintFrom:self.email toView:self.view];
    [AutoLayout trailingConstraintFrom:self.email toView:self.view];
    [AutoLayout genericConstraintFrom:self.email toView:self.view withAttribute:NSLayoutAttributeTop andConstant:125.0];
    
    [AutoLayout leadingConstraintFrom:bookReservationButton toView:self.view];
    [AutoLayout trailingConstraintFrom:bookReservationButton toView:self.view];
    [AutoLayout genericConstraintFrom:bookReservationButton toView:self.view withAttribute:NSLayoutAttributeTop andConstant:150.0];
    
    [bookReservationButton addTarget:self action:@selector(bookReservationButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    
}

- (UIButton *)createButtonWithTitle:(NSString *)title {
    UIButton *button = [[UIButton alloc]init];
    [button setTitle:title forState:normal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [self.view addSubview:button];
    
    return button;
}

- (void)bookReservationButtonPressed {
    Guest *newGuest = [[Guest alloc]init];
    NSLog(@"newGuest");
//    newGuest.firstName = self.firstName.text;
//    newGuest.lastName = self.lastName.text;
//    newGuest.email = self.email.text;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


@end
