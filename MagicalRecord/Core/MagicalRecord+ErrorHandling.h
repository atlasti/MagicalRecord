//
//  MagicalRecord+ErrorHandling.h
//  Magical Record
//
//  Created by Saul Mora on 3/6/12.
//  Copyright (c) 2012 Magical Panda Software LLC. All rights reserved.
//

#import <MagicalRecord/MagicalRecordInternal.h>
#import <MagicalRecord/NSManagedObjectContext+MagicalErrorHandling.h>

@interface MagicalRecord (ErrorHandling)

+ (void) handleError:(NSError *)error
           inContext:(NSManagedObjectContext *)context;
- (void) handleError:(NSError *)error
           inContext:(NSManagedObjectContext *)context;

+ (void) setErrorHandler:(MRErrorHandler)handler;

@end
