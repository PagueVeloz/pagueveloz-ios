//
//  PagueVelozService.m
//  PagueVelozFramework
//
//  Created by João Paulo Ros on 28/06/15.
//  Copyright (c) 2015 PremierSoft. All rights reserved.
//

#import "PagueVelozService.h"
#import <objc/message.h>
@implementation PagueVelozService
static NSString *webserviceBase = @"https://www.pagueveloz.com.br/api/";
static NSString *sandboxWebserviceBase = @"https://sandbox.pagueveloz.com.br/api/";

+ (PagueVelozService*)sharedService {
    
    static dispatch_once_t onceToken;
    static PagueVelozService *sharedInstance;
    
    dispatch_once(&onceToken, ^{
        sharedInstance = [[PagueVelozService alloc] init];
    });
    
    return sharedInstance;
}

- (void)sendRequest:(PVFRequest *)request withCompletionBlock:( void(^)(BOOL success, id result, NSError *error))completionBlock {
    NSAssert(request, @"Request must not be nil.");
    NSAssert(!request.requiresSigning || self.key, @"For signed requests you have to set the Key.");
    NSAssert(!request.requiresSigning || self.email, @"For signed requests you have to set the Email.");
    
    NSMutableString *url = [NSMutableString string];
    
    if(self.sandboxEnabled)
        [url appendString:sandboxWebserviceBase];
    else
        [url appendString:webserviceBase];
    
    [url appendFormat:@"%@/%@", request.apiVersion, request.endpoint];
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    if([request.method isEqualToString:@"POST"])
        [urlRequest setHTTPMethod:@"POST"];
    
    if(request.data)
        [urlRequest setHTTPBody:request.data];
    
    [urlRequest setValue:@"application/json"  forHTTPHeaderField:@"content-type"];
    if(request.requiresSigning)
    {
        NSString *token = [[[NSString stringWithFormat:@"%@:%@", self.email, self.key] dataUsingEncoding:NSUTF8StringEncoding] base64EncodedStringWithOptions:0];
        [urlRequest setValue:[NSString stringWithFormat:@"Basic %@", token]  forHTTPHeaderField:@"Authorization"];
    }
    
    [NSURLConnection sendAsynchronousRequest:urlRequest
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                               NSLog(@"%@ NEW", response);
                               if(connectionError)
                               {
                                   completionBlock(NO, nil, connectionError);
                               }
                               else if ([(NSHTTPURLResponse *)response statusCode] == 400)
                               {
                                   NSError *error = nil;
                                   id object = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
                                   if(error != nil)
                                       completionBlock(NO, nil, nil);
                                   else
                                       completionBlock(NO, object, nil);
                               }
                               else
                               {
                                   id formatedData = data;
                                   if(request.returnClass != nil)
                                   {
                                       if([request.returnClass isSubclassOfClass:[NSString class]])
                                       {
                                           formatedData = [[NSString alloc] initWithData:data
                                                                                encoding:NSUTF8StringEncoding];
                                       }
                                       else
                                       {
                                           NSError *error = nil;
                                           formatedData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
                                           
                                           if(!error && formatedData)
                                           {
                                               if(class_getClassMethod(request.returnClass, NSSelectorFromString(@"parseResponse:")) != nil)
                                               {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

                                                   if([formatedData isKindOfClass:[NSArray class]])
                                                   {
                                                       NSMutableArray *array = [NSMutableArray array];
                                                       for(id obj in formatedData)
                                                       {
                                                           [array addObject:[request.returnClass performSelector:NSSelectorFromString(@"parseResponse:")
                                                                                                      withObject:obj]];
                                                       }
                                                       formatedData = [NSArray arrayWithArray:array];
                                                   }
                                                   else
                                                   {
                                                        formatedData = [request.returnClass performSelector:NSSelectorFromString(@"parseResponse:")
                                                                                        withObject:formatedData];
                                                   }
#pragma clang diagnostic pop
                                               }
                                           }
                                           else
                                               formatedData = data;
                                       }
                                   }
                                   completionBlock(YES, formatedData, nil);
                                   
                               }
                           }];
}
@end
