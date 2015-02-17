//
//  NSManagedObjectContext+MagicalErrorHandling.m
//  SSDModelKit
//
//  Created by Stephan Michels on 17.02.15.
//  Copyright (c) 2015 ATLAS.ti. All rights reserved.
//

#import "NSManagedObjectContext+MagicalErrorHandling.h"
#import "MagicalRecord+ErrorHandling.h"

static NSString * const kMagicalRecordNSManagedObjectContextErrorHandler = @"kNSManagedObjectContextErrorHandler";

@implementation NSManagedObjectContext (MagicalErrorHandling)

- (void) MR_setErrorHandler:(void (^)(NSManagedObjectContext *, NSError *))errorHandler;
{
    if (errorHandler)
    {
        [[self userInfo] setObject:[errorHandler copy]
                            forKey:kMagicalRecordNSManagedObjectContextErrorHandler];
    }
    else
    {
        [[self userInfo] removeObjectForKey:kMagicalRecordNSManagedObjectContextErrorHandler];
    }
}

- (void (^)(NSManagedObjectContext *, NSError *))MR_errorHandler;
{
    MRErrorHandler errorHandler = [[self userInfo] objectForKey:kMagicalRecordNSManagedObjectContextErrorHandler];
    return errorHandler;
}

- (void) MR_handleError:(NSError *)error
              inContext:(NSManagedObjectContext *)context
{
    if (error)
    {
        MRErrorHandler errorHandler = self.MR_errorHandler;
        if (errorHandler)
        {
            errorHandler(context, error);
        }
        else if (self.parentContext)
        {
            [self.parentContext MR_handleError:error
                                     inContext:context];
        }
        else
        {
            [MagicalRecord handleError:error
                             inContext:context];
        }
    }
}

@end
