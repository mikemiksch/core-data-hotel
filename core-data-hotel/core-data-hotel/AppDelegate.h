//
//  AppDelegate.h
//  core-data-hotel
//
//  Created by Mike Miksch on 4/24/17.
//  Copyright © 2017 Mike Miksch. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

