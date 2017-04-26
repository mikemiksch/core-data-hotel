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

@interface AvailabilityViewController () <UITableViewDataSource, UITableViewDelegate>

@property(strong, nonatomic) UITableView *availabilityTableView;

@property(strong, nonatomic) NSArray *availableRooms;

@end

@implementation AvailabilityViewController

- (NSArray *)availableRooms {
    if (!_availableRooms) {
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
        
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Reservation"];
        request.predicate = [NSPredicate predicateWithFormat:@"startDate <= %@ AND endDate >= %@", self.endDate, self.startDate];
        
        NSError *roomError;
        NSArray *results = [appDelegate.persistentContainer.viewContext executeFetchRequest:request error:&roomError];
        
        NSMutableArray *unavailableRooms = [[NSMutableArray alloc]init];
        
        for (Reservation *reservation in results) {
            [unavailableRooms addObject:reservation.room];
        }
        
        NSFetchRequest *roomRequest = [NSFetchRequest fetchRequestWithEntityName:@"Room"];
        roomRequest.predicate = [NSPredicate predicateWithFormat:@"NOT self IN %@", unavailableRooms];
        
        NSError *availableRoomError;
        
        _availableRooms = [appDelegate.persistentContainer.viewContext executeFetchRequest:roomRequest error:&availableRoomError];
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
    return self.availableRooms.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    Room *currentRoom = self.availableRooms[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%i", currentRoom.number];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Room *selectedRoom = self.availableRooms[indexPath.row];
    BookViewController *bookingView = [[BookViewController alloc]init];
    bookingView.room = selectedRoom;
    bookingView.startDate = self.startDate;
    bookingView.endDate = self.endDate;
    [self.navigationController pushViewController:bookingView animated:YES];
}

@end
