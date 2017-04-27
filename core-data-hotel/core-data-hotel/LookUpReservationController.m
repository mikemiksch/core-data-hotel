//
//  LookUpReservationController.m
//  core-data-hotel
//
//  Created by Mike Miksch on 4/26/17.
//  Copyright © 2017 Mike Miksch. All rights reserved.
//

#import "LookUpReservationController.h"
#import "Hotel+CoreDataClass.h"
#import "Hotel+CoreDataProperties.h"
#import "Room+CoreDataClass.h"
#import "Room+CoreDataProperties.h"
#import "Guest+CoreDataClass.h"
#import "Guest+CoreDataProperties.h"
#import "Reservation+CoreDataClass.h"
#import "Reservation+CoreDataProperties.h"
#import "AppDelegate.h"
#import "AutoLayout.h"

@interface LookUpReservationController () <UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate>

@property(strong, nonatomic) NSFetchedResultsController *allReservations;
@property(strong, nonatomic) UITableView *reservationsTableView;
@property(strong, nonatomic) UISearchBar *searchBar;

@end

@implementation LookUpReservationController

- (NSFetchedResultsController *)reservations {
    if (!_allReservations) {
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
        
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Reservation"];
//        request.predicate = [NSPredicate predicateWithFormat:@"fullName %@", self.searchBar.text];
        NSError *reservationFetchError;
        NSArray *results = [appDelegate.persistentContainer.viewContext executeRequest:request error:&reservationFetchError];
        NSSortDescriptor *guestSortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"guest.fullName" ascending:YES];
        NSSortDescriptor *roomSortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"hotel" ascending:YES];
        request.sortDescriptors = @[guestSortDescriptor, roomSortDescriptor];
        NSError *reservationListError;
        
        _allReservations = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:appDelegate.persistentContainer.viewContext sectionNameKeyPath:@"guest.fullName" cacheName:nil];
        
        [_allReservations performFetch:&reservationListError];
    }
    
    return _allReservations;
}

- (void)loadView {
    [super loadView];
    [self setupTableView];
    [self.view setBackgroundColor:[UIColor whiteColor]];
}

- (void)setupTableView {
    self.reservationsTableView = [[UITableView alloc]init];
    self.reservationsTableView.dataSource = self;
    self.reservationsTableView.delegate = self;
    [self.view addSubview:self.reservationsTableView];
    [self.reservationsTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.reservationsTableView.translatesAutoresizingMaskIntoConstraints - NO;
    [AutoLayout fullScreenContraintsWithVFLForView:self.reservationsTableView];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id<NSFetchedResultsSectionInfo> sectionInfo = [[self.reservationsTableView sections]objectAtIndex: section];
    return [sectionInfo numberOfObjects];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    Reservation *currentReservation = [self.allReservations objectAtIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ Room: %i", currentReservation.room.hotel, currentReservation.room.number];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    [self.view endEditing:YES];
}



@end
