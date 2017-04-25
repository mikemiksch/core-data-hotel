//
//  RoomsViewController.m
//  core-data-hotel
//
//  Created by Mike Miksch on 4/24/17.
//  Copyright © 2017 Mike Miksch. All rights reserved.
//

#import "RoomsViewController.h"

@interface RoomsViewController () <UITableViewDataSource>

@property(strong, nonatomic) NSMutableArray *hotelRooms;

@property(strong, nonatomic) UITableView *roomsTableView;

@end

@implementation RoomsViewController

-(void)loadView {
    [super loadView];
    self.view.backgroundColor = [UIColor whiteColor];
    self.hotelRooms = [[NSMutableArray alloc]init];
    [self allRooms];
    self.roomsTableView = [[UITableView alloc]init];
    [self setupLayout];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.roomsTableView.dataSource = self;
    [self.roomsTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    NSLog(@"%@", NSStringFromClass([self.selectedHotel class]));
}

- (void)setupLayout {
    [self.view addSubview:self.roomsTableView];
    self.roomsTableView.translatesAutoresizingMaskIntoConstraints = NO;
    [AutoLayout fullScreenContraintsWithVFLForView:self.roomsTableView];
}


- (void)allRooms {
    for (Room *room in _selectedHotel.rooms) {
        [self.hotelRooms addObject:room];
        NSLog(@"%@", room[@"number"]);
    }
        NSLog(@"%@", self.hotelRooms);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section    {
    return [self.hotelRooms count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath  {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    NSDictionary *room = self.hotelRooms[indexPath.row];
    NSLog(@"%@", room[@"number"]);
    cell.textLabel.text = [NSString stringWithFormat:@"Room %@", room[@"number"]];
    return cell;
}

@end
