//
//  Created by Felipe Cypriano on 16/05/13.
//
//


#import <Foundation/Foundation.h>

/**
* Helper methods to NSString. All of them prefixed with `fcy_` to avoid conflicts
*/
@interface NSString (FCYStringAdditions)

/**
* Returns a trimmed string. Removes spaces from both sides.
*/
- (NSString *)fcy_trim;

@end