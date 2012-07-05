//
//  ImgurAPI.h
//  ImgurAPI
//
//  Created by Kodam Shindo on 12/04/21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImgurAPI : NSObject
{
	NSString *APIKey;
}
- (NSString*)uploadImage:(UIImage*)image;
@end
