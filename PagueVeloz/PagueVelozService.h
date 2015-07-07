//
//  PagueVelozService.h
//  PagueVelozFramework
//
//  Created by João Paulo Ros on 28/06/15.
//  Copyright (c) 2015 PremierSoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PVFRequest.h"

@interface PagueVelozService : NSObject

/**
 * Enable the sandbox mode
 */
@property (nonatomic, assign) BOOL      sandboxEnabled;

/**
 * Set the email to use in signed request, ie, every method except SignIn and CEP
 *
 * @param email   A string with the email provided by PagueVeloz.
 */
@property (nonatomic, strong) NSString  *email;

/**
 * Set the key to use in signed request, ie, every method except SignIn and CEP
 *
 * @param key   A string with the key provided by PagueVeloz.
 */
@property (nonatomic, strong) NSString  *key;


/**
 * Returns the singleton PagueVelozService.
 *
 * @return The shared PagueVelozService.
 */
+ (PagueVelozService*)sharedService;


/**
 * Execute a request and calls the completion block when it finishes.
 *
 * @param request           The request object to be executed.
 * @param completionBlock   The completion block to return the execution result, it can be successfully executed or not. If successfully executed, the result is returned in "result" parameter, else the error is returned in "error" parameter.
 */
- (void)sendRequest:(PVFRequest *)request withCompletionBlock:( void(^)(BOOL success, id result, NSError *error))completionBlock;

@end
