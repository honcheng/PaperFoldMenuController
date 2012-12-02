/**
 * Copyright (c) 2012 Muh Hon Cheng
 * Created by honcheng on 26/10/12.
 *
 * Permission is hereby granted, free of charge, to any person obtaining
 * a copy of this software and associated documentation files (the
 * "Software"), to deal in the Software without restriction, including
 * without limitation the rights to use, copy, modify, merge, publish,
 * distribute, sublicense, and/or sell copies of the Software, and to
 * permit persons to whom the Software is furnished to do so, subject
 * to the following conditions:
 *
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT
 * WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR
 * PURPOSE AND NONINFRINGEMENT. IN NO EVENT
 * SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
 * LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
 * TORT OR OTHERWISE, ARISING FROM, OUT OF OR
 * IN CONNECTION WITH THE SOFTWARE OR
 * THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 *
 * @author 		Muh Hon Cheng <honcheng@gmail.com>
 * @copyright	2012	Muh Hon Cheng
 * @version
 *
 */

#import <UIKit/UIKit.h>
#import "PaperFoldView.h"
#import "PaperFoldMenuControllerDelegate.h"
#import "ShadowView.h"

@interface PaperFoldMenuController : UIViewController <PaperFoldViewDelegate, UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, weak) PaperFoldView *paperFoldView;
@property (nonatomic, strong) NSMutableArray *viewControllers;
@property (nonatomic, weak) UITableView *menuTableView;
@property (nonatomic, weak) UIView *contentView;
@property (nonatomic, weak) ShadowView *menuTableViewSideShadowView;
@property (nonatomic, weak) id<PaperFoldMenuControllerDelegate> delegate;
@property (nonatomic, assign) BOOL onlyAllowEdgeDrag;
/**
 * Set and return the current view controller;
 */
@property (nonatomic, strong) UIViewController *selectedViewController;
/**
 * Set and return the index of the current view controller
 */
@property (nonatomic, assign) NSUInteger selectedIndex;
@property (nonatomic, assign, readonly) float menuWidth;
@property (nonatomic, assign, readonly) int numberOfFolds;
/**
 * This method initialize the view controller with 
 * the width of the menu table view on the left
 */
- (id)initWithMenuWidth:(float)menuWidth numberOfFolds:(int)numberOfFolds;
/**
 * This method fold/unfolds to hide/reveal the menuTableView
 * @param show A boolean value to indicate if the menu should be shown or hidden
 * @param animated A boolean value to indicate if the folding/unfolding should be animated
 */
- (void)showMenu:(BOOL)show animated:(BOOL)animated;
@end
