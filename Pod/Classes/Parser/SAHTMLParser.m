//
//  SAFormatter.m
//  Pods
//
//  Copyright (c) 2015 SuperAwesome Ltd. All rights reserved.
//
//  Created by Gabriel Coman on 12/10/2015.
//
//

// import header
#import "SAHTMLParser.h"

// import modelspace
#import "SAAd.h"
#import "SACreative.h"
#import "SADetails.h"

// import juciy aux functions
#import "SAUtils.h"

// import SA class
#import "SuperAwesome.h"

@implementation SAHTMLParser

+ (NSString*) formatCreativeDataIntoAdHTML:(SAAd*)ad {
    
    switch (ad.creative.format) {
        case image:{
            return [self formatCreativeIntoImageHTML:ad];
            break;
        }
        case video:{
            return nil;
            break;
        }
        case rich:{
            return [self formatCreativeIntoRichMediaHTML:ad];
            break;
        }
        case tag:{
            return [self formatCreativeIntoTagHTML:ad];
            break;
        }
        default:{
            return nil;
            break;
        }
    }
}

+ (NSString*) formatCreativeIntoImageHTML:(SAAd*)ad {
    // load template
    NSString *file = [SAUtils filePathForName:@"displayImage" type:@"html" andBundle:@"SuperAwesome" andClass:self.classForCoder];
    NSString *htmlString = [NSString stringWithContentsOfFile:file encoding:NSUTF8StringEncoding error:nil];
    
    // return the parametrized template
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"hrefURL" withString:ad.creative.clickURL];
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"imageURL" withString:ad.creative.details.image];
    return htmlString;
}

+ (NSString*) formatCreativeIntoRichMediaHTML:(SAAd*)ad {
    // load template
    NSString *file = [SAUtils filePathForName:@"displayRichMedia" type:@"html" andBundle:@"SuperAwesome" andClass:self.classForCoder];
    NSString *htmlString = [NSString stringWithContentsOfFile:file encoding:NSUTF8StringEncoding error:nil];
    
    // format template parameters
    NSMutableString *richMediaString = [[NSMutableString alloc] init];
    [richMediaString appendString:ad.creative.details.url];
    
    NSDictionary *richMediaDict = @{
        @"placement":[NSNumber numberWithInteger:ad.placementId],
        @"line_item":[NSNumber numberWithInteger:ad.lineItemId],
        @"creative":[NSNumber numberWithInteger:ad.creative.creativeId],
        @"rnd":[NSNumber numberWithInteger:[SAUtils getCachebuster]]
    };
    [richMediaString appendString:@"?"];
    [richMediaString appendString:[SAUtils formGetQueryFromDict:richMediaDict]];
    
    
    // return the parametrized template
    NSString *richString = [htmlString stringByReplacingOccurrencesOfString:@"richMediaURL" withString:richMediaString];
    
    richString = [richString stringByReplacingOccurrencesOfString:@"" withString:@""];
    
    return richString;
}

+ (NSString*) formatCreativeIntoTagHTML:(SAAd*)ad {
    // get template
    NSString *file = [SAUtils filePathForName:@"displayTag" type:@"html" andBundle:@"SuperAwesome" andClass:self.classForCoder];
    NSString *htmlString = [NSString stringWithContentsOfFile:file encoding:NSUTF8StringEncoding error:nil];
    
    // format template parameters
    NSString *tagString = ad.creative.details.tag;
    tagString = [tagString stringByReplacingOccurrencesOfString:@"[click]" withString:[NSString stringWithFormat:@"%@&redir=",ad.creative.trackingURL]];
    tagString = [tagString stringByReplacingOccurrencesOfString:@"[click_enc]" withString:[SAUtils encodeURI:ad.creative.trackingURL]];
    tagString = [tagString stringByReplacingOccurrencesOfString:@"[keywords]" withString:@""];
    tagString = [tagString stringByReplacingOccurrencesOfString:@"[timestamp]" withString:[NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970]]];
    tagString = [tagString stringByReplacingOccurrencesOfString:@"target=\"_blank\"" withString:@""];
    tagString = [tagString stringByReplacingOccurrencesOfString:@"“" withString:@"\""];
    
    // return the parametrized template
    return [htmlString stringByReplacingOccurrencesOfString:@"tagdata" withString:tagString];
}

@end
