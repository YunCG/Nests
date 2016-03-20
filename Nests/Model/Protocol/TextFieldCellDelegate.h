//
//  TextFieldCellDelegate.h
//  Nests
//
//  Created by 🐠 on 12/5/15.
//  Copyright © 2015 Daisy. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TextFieldCellDelegate <NSObject>
- (void)textFieldCellDidEndEditing:(NSString*)text
                            section:(NSInteger)section
                               row:(NSInteger)row

;
@end
