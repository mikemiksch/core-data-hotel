//
//  AvailabilityViewController.m
//  core-data-hotel
//
//  Created by Mike Miksch on 4/25/17.
//  Copyright © 2017 Mike Miksch. All rights reserved.
//

#import "AvailabilityViewController.h"
#import "AutoLayout.h"
#import "AppDelegate.h"
#import "Reservation+CoreDataClass.h"
#import "Reservation+CoreDataProperties.h"
#import "Room+CoreDataClass.h"
#import "Room+CoreDataProperties.h"
#import "BookViewController.h"
#import "Hotel+CoreDataClass.h"
#import "Hotel+CoreDataProperties.h"
#import "HotelService.h"

@interface AvailabilityViewController () <UITableViewDataSource, UITableViewDelegate>

@property(strong, nonatomic) UITableView *availabilityTableView;

@property(strong, nonatomic) NSFetchedResultsController *availableRooms;

@end

@implementation AvailabilityViewController

- (NSFetchedResultsController *)availableRooms {
    if (!_availableRooms) {
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
        NSManagedObjectContext *context = appDelegate.persistentContainer.viewContext;
        _availableRooms = [HotelService checkAvailability:self.startDate to:self.endDate appDelegate:appDelegate context:context];
    }
    return _availableRooms;
}


- (void)loadView {
    [super loadView];
    [self setupTableView];
    [self.view setBackgroundColor:[UIColor whiteColor]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)setupTableView {
    self.availabilityTableView = [[UITableView alloc]init];
    self.availabilityTableView.dataSource = self;
    self.availabilityTableView.delegate = self;
    [self.view addSubview:self.availabilityTableView];
    [self.availabilityTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.availabilityTableView.translatesAutoresizingMaskIntoConstraints = NO;
    [AutoLayout fullScreenContraintsWithVFLForView:self.availabilityTableView];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id<NSFetchedResultsSectionInfo> sectionInfo = [[self.availableRooms sections]objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    Room *currentRoom = [self.availableRooms objectAtIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%i", currentRoom.number];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    Room *selectedRoom = [self.availableRooms objectAtIndexPath:indexPath];
    BookViewController *bookingView = [[BookViewController alloc]init];
    bookingView.room = selectedRoom;
    bookingView.startDate = self.startDate;
    bookingView.endDate = self.endDate;
    [self.navigationController pushViewController:bookingView animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.availableRooms.sections.count;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    id<NSFetchedResultsSectionInfo> sectionInfo = [[self.availableRooms sections]objectAtIndex:section];
    
    return sectionInfo.name;
}

@end
