//
//  NSString+QMValidation.h
//  Q-municate
//
//  Created by Injoit on 8/25/17.
//  Copyright © 2017 QuickBlox. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (QMValidation)

- (BOOL)qm_validateForNotAcceptableCharacters:(NSString *)notAcceptableCharacters
                                        error:(NSError **)error;

- (BOOL)qm_validateForCharactersCountWithMinLength:(NSUInteger)minLength
                                         maxLength:(NSUInteger)maxLength
                                             error:(NSError **)error;

- (BOOL)qm_validateForEmailFormat:(NSError **)error;

@end
