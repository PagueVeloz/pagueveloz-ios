//
//  PVFSMSMessage.m
//  PagueVelozFramework
//
//  Created by João Paulo Ros on 29/06/15.
//  Copyright (c) 2015 PremierSoft. All rights reserved.
//

#import "PVFSMSMessage.h"

@implementation PVFSMSMessage
/*
 * Creates a request object to send the SMS Message with the given parameters.
 *
 * @param
 * @return          The request for this query.
 */
+ (PVFRequest *)sendMessageWithInternalId:(NSString *)internalId
                             andSenderPhone:(NSString *)senderPhone
                        andDestinationPhone:(NSString *)destinationPhone
                                 andContent:(NSString *)content
                          andScheduleToDate:(NSDate *)scheduleToDate {
    
    NSAssert(internalId, @"The internal id must not be nil");
    NSAssert(senderPhone, @"The sender phone must not be nil");
    NSAssert(destinationPhone, @"The destination phone must not be nil");
    NSAssert(content, @"The content must not be nil");
    
    
    NSMutableDictionary *data = [NSMutableDictionary dictionary];
    [data setObject:internalId forKey:@"SeuId"];
    [data setObject:senderPhone forKey:@"TelefoneRemetente"];
    [data setObject:destinationPhone forKey:@"TelefoneDestino"];
    [data setObject:content forKey:@"Conteudo"];
    
    if(scheduleToDate)
        [data setObject:scheduleToDate forKey:@"AgendarPara"];
    
    
    NSError *error = nil;
    NSData *json = [NSJSONSerialization dataWithJSONObject:data
                                                   options:0
                                                     error:&error];
    if(!error)
    {
        
        PVFRequest *request = [[PVFRequest alloc] init];
        [request setApiVersion:@"v1"];
        [request setEndpoint:@"MensagemSMS"];
        [request setRequiresSigning:YES];
        [request setMethod:@"POST"];
        [request setData:json];
        return request;
    }
    else
        return nil;
}

/*
 * Creates a request object to send the SMS Message with the object's properties.
 *
 * @return          The request for this query.
 */
- (PVFRequest *)sendMessage {
    return [PVFSMSMessage sendMessageWithInternalId:self.internalId
                                       andSenderPhone:self.senderPhone
                                  andDestinationPhone:self.destinationPhone
                                           andContent:self.content
                                    andScheduleToDate:self.scheduleToDate];
}

@end
