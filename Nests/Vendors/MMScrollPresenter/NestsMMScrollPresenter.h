//
//  NestsMMScrollPresenter.h
//  NestsMMScrollPresenter
//
//  Created by Malleo, Mitch on 10/31/14.
//

#import <UIKit/UIKit.h>
#import "NestsMMScrollPage.h"

@interface NestsMMScrollPresenter : UIScrollView <UIScrollViewDelegate>

- (void)addMMScrollPage:(NestsMMScrollPage *)page;
- (void)addMMScrollPageArray:(NSArray *)array;
-(void)refreshMMScrollPageArray:(NSMutableArray *)array;

- (int)currentPage;
- (void)animateToPageAtIndex:(int)index;

@end
