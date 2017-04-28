//
//  DatePickerViewController.m
//  core-data-hotel
//
//  Created by Mike Miksch on 4/25/17.
//  Copyright © 2017 Mike Miksch. All rights reserved.
//

#import "DatePickerViewController.h"
#import "AvailabilityViewController.h"
#import "AutoLayout.h"

@interface DatePickerViewController ()

@property(strong, nonatomic) UIDatePicker *endDate;
@property(strong, nonatomic) UIDatePicker *startDate;
@property(strong, nonatomic) NSCalendar *calendar;

@end

@implementation DatePickerViewController

- (void)loadView {
    [super loadView];
    self.calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    [self setupDatePickers];
    [self setupDoneButton];
    [self.view setBackgroundColor:[UIColor whiteColor]];
}

- (void)setupDoneButton {
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonPressed)];
    [self.navigationItem setRightBarButtonItem:doneButton];
}

- (void)doneButtonPressed {
    NSDate *chosenStartDate = self.startDate.date;
    NSDate *chosenEndDate = self.endDate.date;
//
//    if ([[NSDate date] timeIntervalSinceReferenceDate] > [chosenStartDate timeIntervalSinceReferenceDate]) {
//        self.startDate.date = [NSDate date];
//        
//    }

    AvailabilityViewController *availabilityController = [[AvailabilityViewController alloc]init];
    availabilityController.endDate = chosenEndDate;
    availabilityController.startDate = chosenStartDate;
    [self.navigationController pushViewController:availabilityController animated:YES];
    
}

- (void)updateEndDate {
    self.endDate.minimumDate = [self.calendar dateByAddingUnit:NSCalendarUnitDay value:1 toDate:self.startDate.date options:NSCalendarMatchFirst];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)setupDatePickers {
    
    NSDate *minimumDate = [NSDate date];
    
    UILabel *startDateLabel = [[UILabel alloc]init];
    startDateLabel.text = @"Start Date";
    
    UILabel *endDateLabel = [[UILabel alloc]init];
    endDateLabel.text = @"End Date:";
    
    self.startDate = [[UIDatePicker alloc]init];
    self.startDate.datePickerMode = UIDatePickerModeDate;
    self.startDate.minimumDate = minimumDate;
    self.endDate = [[UIDatePicker alloc]init];
    self.endDate.datePickerMode = UIDatePickerModeDate;
    self.endDate.minimumDate = minimumDate;
    
    [self.view addSubview:startDateLabel];
    [self.view addSubview:endDateLabel];
    [self.view addSubview:self.startDate];
    [self.view addSubview:self.endDate];

    startDateLabel.translatesAutoresizingMaskIntoConstraints = NO;
    endDateLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.startDate.translatesAutoresizingMaskIntoConstraints = NO;
    self.endDate.translatesAutoresizingMaskIntoConstraints = NO;
    
    [AutoLayout leadingConstraintFrom:startDateLabel toView:self.view];
    [AutoLayout trailingConstraintFrom:startDateLabel toView:self.view];
    [AutoLayout genericConstraintFrom:startDateLabel toView:self.view withAttribute:NSLayoutAttributeTop andConstant:75.0];
    
    [AutoLayout leadingConstraintFrom:self.startDate toView:self.view];
    [AutoLayout trailingConstraintFrom:self.startDate toView:self.view];
    [AutoLayout genericConstraintFrom:self.startDate toView:startDateLabel withAttribute:NSLayoutAttributeTop andConstant:8.0];
    
    [AutoLayout leadingConstraintFrom:endDateLabel toView:self.view];
    [AutoLayout trailingConstraintFrom:endDateLabel toView:self.view];
    [AutoLayout genericConstraintFrom:endDateLabel toView:self.startDate withAttribute:NSLayoutAttributeBottom andConstant:16.0];
    
    [AutoLayout leadingConstraintFrom:self.endDate toView:self.view];
    [AutoLayout trailingConstraintFrom:self.endDate toView:self.view];
    [AutoLayout genericConstraintFrom:self.endDate toView:self.startDate withAttribute:NSLayoutAttributeBottom andConstant:210.0];

    [self updateEndDate];
    
    [self.startDate addTarget:self action:@selector(updateEndDate) forControlEvents:UIControlEventValueChanged];

}


@end
