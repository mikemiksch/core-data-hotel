//
//  RoomsViewController.h
//  core-data-hotel
//
//  Created by Mike Miksch on 4/24/17.
//  Copyright © 2017 Mike Miksch. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "AutoLayout.h"
#import "Hotel+CoreDataClass.h"
#import "Hotel+CoreDataProperties.h"

@interface RoomsViewController : UIViewController

@property(strong, nonatomic) Hotel *selectedHotel;

@end
