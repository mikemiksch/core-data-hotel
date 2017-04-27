//
//  HotelService.h
//  core-data-hotel
//
//  Created by Mike Miksch on 4/27/17.
//  Copyright © 2017 Mike Miksch. All rights reserved.
//

#import "AppDelegate.h"
#import "Room+CoreDataClass.h"
#import "Room+CoreDataProperties.h"
#import "Guest+CoreDataProperties.h"
#import "Guest+CoreDataClass.h"

@import UIKit;

@interface HotelService : NSObject

+ (void)makeReservation:(NSDate *)startDate to:(NSDate *)endDate in:(Room *)room for:(Guest *)guest appDelegate:(AppDelegate *)appDelegate context:(NSManagedObjectContext *)context;

@end
