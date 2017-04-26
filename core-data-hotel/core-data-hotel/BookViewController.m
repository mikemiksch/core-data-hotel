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
#import "Reservation+CoreDataClass.h"
#import "Reservation+CoreDataProperties.h"
#import "AutoLayout.h"
#import "AppDelegate.h"

@interface BookViewController ()


@property(strong, nonatomic) UITextField *firstName;
@property(strong, nonatomic) UITextField *lastName;
@property(strong, nonatomic) UITextField *email;


@end

@implementation BookViewController

- (void)loadView {
    [super loadView];
    [self setupReservationInfo];
    [self setupSaveButton];
    [self.view setBackgroundColor:[UIColor whiteColor]];
}

-(void)setupReservationInfo {
    
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
    
}

- (void)setupSaveButton {
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveButtonPressed)];
    [self.navigationItem setRightBarButtonItem:saveButton];
}

- (void)saveButtonSelected:(UIBarButtonItem *)sender {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = appDelegate.persistentContainer.viewContext;
    
    Reservation *reservation = [NSEntityDescription insertNewObjectForEntityForName:@"reservation" inManagedObjectContext:context];
    
    reservation.startDate = [NSDate date];
    reservation.endDate = self.endDate;
    reservation.room = self.room;
    
    self.room.reservation = reservation;
    
    reservation.guest = [NSEntityDescription insertNewObjectForEntityForName:@"Guest" inManagedObjectContext:context];
    reservation.guest.firstName = self.firstName.text;
    reservation.guest.lastName = self.lastName.text;
    reservation.guest.email = self.email.text;
    
    NSError *saveError;
    [context save:&saveError];
    
    if (saveError) {
        NSLog(@"Save error is %@", saveError);
    } else {
        NSLog(@"Reservation Saved Successfully");
        
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


@end
