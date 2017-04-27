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
#import <Crashlytics/Crashlytics.h>
#import "HotelService.h"

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
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveButtonPressed:)];
    [self.navigationItem setRightBarButtonItem:saveButton];
}

- (void)saveButtonPressed:(UIBarButtonItem *)sender {
    
    if(![[self.firstName text]  isEqual: @""] && ![[self.lastName text]  isEqual: @""] && ![[self.email text]  isEqual: @""]) {
    
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
        NSManagedObjectContext *context = appDelegate.persistentContainer.viewContext;
    
        Guest *guest = [NSEntityDescription insertNewObjectForEntityForName:@"Guest" inManagedObjectContext:context];
        guest.firstName = self.firstName.text;
        guest.lastName = self.lastName.text;
        guest.email = self.email.text;
        [HotelService makeReservation:self.startDate to:self.endDate in:_room for:guest appDelegate:appDelegate context:context];
        [self.navigationController popToRootViewControllerAnimated:YES];
   
    }

}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


@end
