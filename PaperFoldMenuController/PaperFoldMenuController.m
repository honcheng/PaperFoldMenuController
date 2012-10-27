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

#import "PaperFoldMenuController.h"

@interface PaperFoldMenuController ()
/**
 * A UIView with shadow at joint between the menu and content view
 */
@property (nonatomic, strong) ShadowView *menuTableViewSideShadowView;
/**
 * This method reloads the menu on the left
 * and refresh the screenshot of the menu used in 
 * PaperFold
 */
- (void)reloadMenu;
@end

@implementation PaperFoldMenuController

- (id)initWithMenuWidth:(float)menuWidth
{
    self = [super init];
    if (self)
    {
        _paperFoldView = [[PaperFoldView alloc] initWithFrame:CGRectMake(0, 0, [self.view bounds].size.width, [self.view bounds].size.height)];
        [_paperFoldView setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth];
        [_paperFoldView setDelegate:self];
        [_paperFoldView setUseOptimizedScreenshot:NO];
        [self.view addSubview:_paperFoldView];
        
        _contentView = [[UIView alloc] initWithFrame:_paperFoldView.frame];
        [_contentView setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth];
        [_paperFoldView setCenterContentView:_contentView];
        
        _menuTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, menuWidth, [self.view bounds].size.height)];
        [_paperFoldView setLeftFoldContentView:_menuTableView foldCount:3 pullFactor:0.9];
        [_menuTableView setDelegate:self];
        [_menuTableView setDataSource:self];
        
        _menuTableViewSideShadowView = [[ShadowView alloc] initWithFrame:CGRectMake(_menuTableView.frame.size.width-3,0,3,[self.view bounds].size.height) foldDirection:FoldDirectionHorizontal];
        [_menuTableViewSideShadowView setColorArrays:@[[UIColor clearColor],[UIColor colorWithWhite:0 alpha:0.6]]];
        /**
         * added to the leftFoldView instead of leftFoldView.contentView bec
         * so that the shadow does not appear while folding
         */
        [_paperFoldView.leftFoldView addSubview:_menuTableViewSideShadowView];
        
    }
    return self;
}

- (void)setViewControllers:(NSMutableArray *)viewControllers
{
    _viewControllers = viewControllers;
    if ([_viewControllers count]>0) [self setSelectedIndex:0];
    [self reloadMenu];
}

- (void)addViewController:(UIViewController*)viewController;
{
    if (!_viewControllers) _viewControllers = [NSMutableArray array];
    [self.viewControllers addObject:viewController];
    [self reloadMenu];
}

- (void)reloadMenu
{
    [self.menuTableView reloadData];
    [self.paperFoldView.leftFoldView.contentView setHidden:NO];
    [self.paperFoldView.leftFoldView drawScreenshotOnFolds];
    [self.paperFoldView.leftFoldView.contentView setHidden:YES];
}

#define TAG_CURRENT_VIEWCONTROLLER 1212

- (void)setSelectedIndex:(NSUInteger)selectedIndex
{
    _selectedIndex = selectedIndex;
    
    [self.menuTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:_selectedIndex inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
    
    UIView *lastView = (UIView*)[self.contentView viewWithTag:TAG_CURRENT_VIEWCONTROLLER];
    if (lastView)
    {
        UIViewController *lastViewController = nil;
        for (UIViewController *viewController in self.viewControllers)
        {
            if (viewController.view == lastView) lastViewController = viewController;
        }
        [lastViewController willMoveToParentViewController:nil];
        [lastViewController.view removeFromSuperview];
        [lastViewController removeFromParentViewController];
    }
    
    _selectedViewController = self.viewControllers[_selectedIndex];
    [_selectedViewController.view setFrame:self.contentView.frame];
    [_selectedViewController.view setTag:TAG_CURRENT_VIEWCONTROLLER];
    [self addChildViewController:_selectedViewController];
    [self.contentView addSubview:_selectedViewController.view];
    [_selectedViewController didMoveToParentViewController:self];
    
    if (self.paperFoldView.state!=PaperFoldStateLeftUnfolded)
    {
        [self reloadMenu];
    }
    
}

- (void)setSelectedViewController:(UIViewController *)selectedViewController
{
    _selectedViewController = selectedViewController;
    int index = [self.viewControllers indexOfObject:_selectedViewController];
    [self setSelectedIndex:index];
}

#pragma mark table view delegates and datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==self.menuTableView) return [self.viewControllers count];
    else return 0;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==self.menuTableView)
    {
        static NSString *identifier = @"identifier";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        
        UIViewController *viewController = self.viewControllers[indexPath.row];
        [cell.textLabel setText:viewController.title];
        
        if (indexPath.row==self.selectedIndex)
        {
            [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        }
        
        return cell;
    }
    else return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==self.menuTableView)
    {
        BOOL shouldSelect = YES;
        if ([self.delegate respondsToSelector:@selector(paperFoldMenuController:shouldSelectViewController:)])
        {
            shouldSelect = [self.delegate paperFoldMenuController:self shouldSelectViewController:self.viewControllers[indexPath.row]];
        }
        if (shouldSelect)
        {
            [self setSelectedIndex:indexPath.row];
            if ([self.delegate respondsToSelector:@selector(paperFoldMenuController:didSelectViewController:)])
            {
                [self.delegate paperFoldMenuController:self didSelectViewController:_selectedViewController];
            }
        }
        
    }
}

@end
