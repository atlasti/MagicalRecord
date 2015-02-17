//
//  NSManagedObjectContext+MagicalErrorHandling.h
//  SSDModelKit
//
//  Created by Stephan Michels on 17.02.15.
//  Copyright (c) 2015 ATLAS.ti. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSManagedObjectContext (MagicalErrorHandling)

@property (nonatomic, copy, setter = MR_setErrorHandler:) MRErrorHandler MR_errorHandler;

- (void) MR_handleError:(NSError *)error
              inContext:(NSManagedObjectContext *)context;

@end
