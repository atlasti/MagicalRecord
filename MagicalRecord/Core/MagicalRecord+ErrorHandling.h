//
//  MagicalRecord+ErrorHandling.h
//  Magical Record
//
//  Created by Saul Mora on 3/6/12.
//  Copyright (c) 2012 Magical Panda Software LLC. All rights reserved.
//

#import "MagicalRecord.h"

typedef void (^MRErrorHandler)(NSManagedObjectContext *context, NSError *error);

@interface MagicalRecord (ErrorHandling)

+ (void) handleError:(NSError *)error
           inContext:(NSManagedObjectContext *)context;
- (void) handleError:(NSError *)error
           inContext:(NSManagedObjectContext *)context;

+ (void) setErrorHandler:(MRErrorHandler)handler;

@end
