//
//  ImgurAPI.m
//  ImgurAPI
//
//  Created by Kodam Shindo on 12/04/21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ImgurAPI.h"
#import "NSData+Base64.h"
#import "NSString+URLEncoding.h"

@implementation ImgurAPI

- (id)init
{
	if(self=[super init]){
		APIKey = @"your api key";
	}
	return self;
}

- (NSString*)uploadImage:(UIImage*)image
{
	NSData *data = UIImagePNGRepresentation(image);
	NSString* post_data = [NSString stringWithFormat:@"key=%@&image=%@&type=base64"
						   ,APIKey
						   ,[[data base64EncodingWithLineLength:0] encodedURLString]
						   ];
	NSURL *url = [NSURL URLWithString:@"http://api.imgur.com/2/upload.json"];
	
	NSMutableURLRequest* urlRequest = [[NSMutableURLRequest alloc]initWithURL:url];
	[urlRequest setHTTPMethod:@"POST"];
	[urlRequest setHTTPBody:[post_data dataUsingEncoding:NSUTF8StringEncoding]];
	
	NSURLResponse* response;
	NSError* error = nil;
	NSData* result = [NSURLConnection sendSynchronousRequest:urlRequest
										   returningResponse:&response
													   error:&error];
	if(error){
		NSLog(@"error = %@",[error description]);
		return @"";
	}
	
	NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:result options:NSJSONReadingMutableContainers error:nil];
	if([dict objectForKey:@"error"]){
		NSLog(@"%@",[dict objectForKey:@"error"]);
		return @"error";
	}
	
	//NSLog(@"%@",[dict description]);
	
	return (NSString*)[dict valueForKeyPath:@"upload.links.original"];
}
@end
