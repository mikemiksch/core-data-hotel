//
//  HotelsViewController.m
//  core-data-hotel
//
//  Created by Mike Miksch on 4/24/17.
//  Copyright © 2017 Mike Miksch. All rights reserved.
//

#import "HotelsViewController.h"
#import <Crashlytics/Crashlytics.h>

@interface HotelsViewController ()<UITableViewDataSource, UITableViewDelegate>

@property(strong, nonatomic) NSArray *allHotels;

@property(strong, nonatomic) UITableView *hotelsTableView;

@end

@implementation HotelsViewController


- (void)loadView {
    [super loadView];
    self.view.backgroundColor = [UIColor whiteColor];
    [self allHotels];
    self.hotelsTableView = [[UITableView alloc]init];
    [self setupLayout];
    NSLog(@"%@", _allHotels);
        //add hotelsTableView as subview and apply constraints
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.hotelsTableView.dataSource = self;
    self.hotelsTableView.delegate = self;
    [self.hotelsTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}

- (void)setupLayout {
    [self.view addSubview:self.hotelsTableView];
    self.hotelsTableView.translatesAutoresizingMaskIntoConstraints = NO;
    [AutoLayout fullScreenContraintsWithVFLForView:self.hotelsTableView];
    
}

- (NSArray *)allHotels {
    if (!_allHotels) {
        
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
        
        NSManagedObjectContext *context = appDelegate.persistentContainer.viewContext;
        
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Hotel"];
        
        NSError *fetchError;
        NSArray *hotels = [context executeFetchRequest:request error:&fetchError];
        
        if (fetchError) {
            NSLog(@"There was an error fetching hotels from Core Data!");
            [Answers logCustomEventWithName:@"There was an error fetching hotels from Core Data" customAttributes:nil];
        }
        
        _allHotels = hotels;
        
    }
    return _allHotels;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_allHotels count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    Hotel *hotel = _allHotels[indexPath.row];
    cell.textLabel.text = hotel.name;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Hotel *selectedHotel = _allHotels[indexPath.row];
    RoomsViewController *rooms = [[RoomsViewController alloc]init];
    rooms.selectedHotel = selectedHotel;
    [self.navigationController pushViewController:rooms animated:YES];
    
}


@end
