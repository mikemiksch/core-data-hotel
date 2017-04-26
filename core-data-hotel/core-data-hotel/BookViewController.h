//
//  BookViewController.h
//  core-data-hotel
//
//  Created by Mike Miksch on 4/25/17.
//  Copyright © 2017 Mike Miksch. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Room+CoreDataClass.h"
#import "Room+CoreDataProperties.h"

@interface BookViewController : UIViewController

@property(strong, nonatomic) Room *selectedRoom;

@end
