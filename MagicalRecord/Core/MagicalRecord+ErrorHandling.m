//
//  MagicalRecord+ErrorHandling.m
//  Magical Record
//
//  Created by Saul Mora on 3/6/12.
//  Copyright (c) 2012 Magical Panda Software LLC. All rights reserved.
//

#import "MagicalRecord+ErrorHandling.h"
#import "MagicalRecordLogging.h"


static MRErrorHandler errorHandler = nil;


@implementation MagicalRecord (ErrorHandling)

+ (void) cleanUpErrorHanding;
{
    errorHandler = nil;
}

+ (void) defaultErrorHandler:(NSError *)error
                   inContext:(NSManagedObjectContext *)context
{
    NSDictionary *userInfo = [error userInfo];
    for (NSArray *detailedError in [userInfo allValues])
    {
        if ([detailedError isKindOfClass:[NSArray class]])
        {
            for (NSError *e in detailedError)
            {
                if ([e respondsToSelector:@selector(userInfo)])
                {
                    MRLogError(@"Error Details: %@", [e userInfo]);
                }
                else
                {
                    MRLogError(@"Error Details: %@", e);
                }
            }
        }
        else
        {
            MRLogError(@"Error: %@", detailedError);
        }
    }
    MRLogError(@"Error Message: %@", [error localizedDescription]);
    MRLogError(@"Error Domain: %@", [error domain]);
    MRLogError(@"Recovery Suggestion: %@", [error localizedRecoverySuggestion]);
    if (context)
    {
        MRLogError(@"Occured In Context: %@", context);
    }
}

+ (void) handleError:(NSError *)error
           inContext:(NSManagedObjectContext *)context
{
	if (error)
	{
        // If a custom error handler is set, call that
        if (errorHandler != nil)
		{
            errorHandler(context, error);
        }
		else
		{
	        // Otherwise, fall back to the default error handling
	        [self defaultErrorHandler:error
                            inContext:context];
		}
    }
}

- (void) handleError:(NSError *)error
           inContext:(NSManagedObjectContext *)context
{
    [[self class] handleError:error
                    inContext:context];
}

+ (void) setErrorHandler:(MRErrorHandler)handler
{
    errorHandler = handler;
}


@end
