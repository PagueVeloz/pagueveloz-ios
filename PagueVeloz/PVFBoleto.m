//
//  PVFBoleto.m
//  PagueVelozFramework
//
//  Created by João Paulo Ros on 28/06/15.
//  Copyright (c) 2015 PremierSoft. All rights reserved.
//

#import "PVFBoleto.h"
@interface PVFBoleto ()
@property (nonatomic, assign) BOOL canceled;
@property (nonatomic, assign) BOOL hasPayment;
@property (nonatomic, strong) NSDate *paymentDate;
@property (nonatomic, assign) double totalPayed;
@property (nonatomic, strong) NSString *url;
@end

@implementation PVFBoleto

NSString *const PVFBoletoFilterInitialDate = @"DataInicio";
NSString *const PVFBoletoFilterFinalDate = @"DataFim";
NSString *const PVFBoletoFilterStatus = @"Status";
NSString *const PVFBoletoFilterDraweeDocumentNumber = @"Documento";
NSString *const PVFBoletoFilterYourNumber = @"SeuNumero";
NSString *const PVFBoletoFilterIncludeCanceled = @"IncluirCancelados";

+ (PVFRequest *)submitBoletoWithEmail:(NSString *)email
                               andPDF:(BOOL)pdf
                             andValue:(double)value
                           andDueDate:(NSDate *)dueDate
                        andYourNumber:(NSString *)yourNumber
                            andDrawee:(NSString *)drawee
              andDraweeDocumentNumber:(NSString *)draweeDocumentNumber
                       andInstallment:(NSString *)installment
                             andLine1:(NSString *)line1
                             andLine2:(NSString *)line2
                  andAssignorDocument:(NSString *)assignorDocument
                          andAssignor:(NSString *)assignor{
    
    NSAssert(email, @"The email must not be nil");
    NSAssert(value > 0, @"The value must be greater than 0");
    NSAssert(dueDate, @"The dueDate must not be nil");
    NSAssert(yourNumber, @"The yourNumber must not be nil");
    NSAssert(drawee, @"The drawee must not be nil");
    NSAssert(draweeDocumentNumber, @"The draweeDocumentNumber must not be nil");
    NSAssert(assignorDocument, @"The assignorDocument must not be nil");
    NSAssert(assignor, @"The assignor must not be nil");
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSMutableDictionary *data = [NSMutableDictionary dictionary];
    [data setObject:email forKey:@"Email"];
    [data setObject:@(pdf) forKey:@"Pdf"];
    [data setObject:@(value) forKey:@"Valor"];
    [data setObject:[dateFormatter stringFromDate:dueDate] forKey:@"Vencimento"];
    [data setObject:yourNumber forKey:@"SeuNumero"];
    [data setObject:drawee forKey:@"Sacado"];
    [data setObject:draweeDocumentNumber forKey:@"CPFCNPJSacado"];
    [data setObject:installment forKey:@"Parcela"];
    [data setObject:assignorDocument forKey:@"CPFCNPJCedente"];
    [data setObject:assignor forKey:@"Cedente"];

    
    if(line1)
        [data setObject:line1 forKey:@"Linha1"];
    if(line2)
        [data setObject:line2 forKey:@"Linha2"];
    
    NSError *error = nil;
    NSData *json = [NSJSONSerialization dataWithJSONObject:data
                                                   options:0
                                                     error:&error];
    
    if(!error)
    {
        PVFRequest *request = [[PVFRequest alloc] init];
        [request setApiVersion:@"v3"];
        [request setEndpoint:@"Boleto"];
        [request setRequiresSigning:YES];
        [request setMethod:@"POST"];
        [request setData:json];
        [request setReturnClass:[NSString class]];
        
        return request;
    }
    else
        return nil;
}

- (PVFRequest *)submitBoleto {
    return [PVFBoleto submitBoletoWithEmail:self.email
                                     andPDF:self.pdf
                                   andValue:self.value
                                 andDueDate:self.dueDate
                              andYourNumber:self.yourNumber
                                  andDrawee:self.drawee
                    andDraweeDocumentNumber:self.draweeDocumentNumber
                             andInstallment:self.installment
                                   andLine1:self.line1
                                   andLine2:self.line2
                        andAssignorDocument:self.assignorDocument
                                andAssignor:self.assignor];
}


+ (PVFRequest *)deleteBoletoWithHandle:(int)handle {
    NSAssert(handle > 0, @"The handle must be greater than 0");
    
    PVFRequest *request = [[PVFRequest alloc] init];
    [request setApiVersion:@"v3"];
    [request setEndpoint:[NSString stringWithFormat:@"Boleto/%i", handle]];
    [request setRequiresSigning:YES];
    [request setMethod:@"DELETE"];
    
    return request;

}
- (PVFRequest *)deleteBoleto {
    return [PVFBoleto deleteBoletoWithHandle:self.handle];
}

+ (PVFRequest *)queryBoletosWithFilters:(NSDictionary*)filter;
{
    
    NSMutableString *filterString = [NSMutableString new];
    if(filter)
    {
        for(NSString *key in [filter allKeys])
        {
            if(filterString.length > 0)
                [filterString appendString:@"&"];
            
            [filterString appendFormat:@"%@=%@",key, [filter objectForKey:key]];
        }
    }
    
    
    PVFRequest *request = [[PVFRequest alloc] init];
    [request setApiVersion:@"v3"];
    [request setEndpoint:[NSString
                          stringWithFormat:@"Boleto?%@", filterString]];
    [request setRequiresSigning:YES];
    [request setMethod:@"GET"];
    [request setReturnClass:[PVFBoleto class]];
    
    return request;
}

+ (id)parseResponse:(id)object {
    PVFBoleto *boleto = [[PVFBoleto alloc] init];
    
    if([object objectForKey:@"Valor"] && [object objectForKey:@"Valor"] != [NSNull null])
        [boleto setValue:[[object objectForKey:@"Valor"] doubleValue]];
    
    if([object objectForKey:@"Documento"] && [object objectForKey:@"Documento"] != [NSNull null])
        [boleto setDraweeDocumentNumber:[object objectForKey:@"Documento"]];
    
    if([object objectForKey:@"Sacado"] && [object objectForKey:@"Sacado"] != [NSNull null])
        [boleto setDrawee:[object objectForKey:@"Sacado"]];
    
    if([object objectForKey:@"Linha1"] && [object objectForKey:@"Linha1"] != [NSNull null])
        [boleto setLine1:[object objectForKey:@"Linha1"]];
    
    if([object objectForKey:@"Linha2"] && [object objectForKey:@"Linha2"] != [NSNull null])
        [boleto setLine2:[object objectForKey:@"Linha2"]];
    
    if([object objectForKey:@"SeuNumero"] && [object objectForKey:@"SeuNumero"] != [NSNull null])
        [boleto setYourNumber:[object objectForKey:@"SeuNumero"]];
    
    if([object objectForKey:@"Id"] && [object objectForKey:@"Id"] != [NSNull null])
        [boleto setHandle:[[object objectForKey:@"Id"] intValue]];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    
    if([object objectForKey:@"Vencimento"] && [object objectForKey:@"Vencimento"] != [NSNull null])
        [boleto setDueDate:[dateFormatter dateFromString:[object objectForKey:@"Vencimento"]]];
    
    if([object objectForKey:@"DataPagamento"] && [object objectForKey:@"DataPagamento"] != [NSNull null])
        [boleto setPaymentDate:[dateFormatter dateFromString:[object objectForKey:@"DataPagamento"]]];
    
    if([object objectForKey:@"Cancelado"] && [object objectForKey:@"Cancelado"] != [NSNull null])
        [boleto setCanceled:[[object objectForKey:@"Cancelado"] boolValue]];
    
    if([object objectForKey:@"TemPagamento"] && [object objectForKey:@"TemPagamento"] != [NSNull null])
        [boleto setHasPayment:[[object objectForKey:@"TemPagamento"] boolValue]];
    
    if([object objectForKey:@"ValorPago"] && [object objectForKey:@"ValorPago"] != [NSNull null])
        [boleto setTotalPayed:[[object objectForKey:@"ValorPago"] doubleValue]];
    
    if([object objectForKey:@"Url"] && [object objectForKey:@"Url"] != [NSNull null])
        [boleto setUrl:[object objectForKey:@"Url"]];
    
    
    
    return boleto;
}

@end
