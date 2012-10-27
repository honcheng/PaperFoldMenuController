PaperFoldMenuController
=======================

PaperFoldMenuController is a UITabBarController replacement, but displays the view controllers in a table view on the left side of the screen. This table view is shown/hidden using [PaperFold-for-iOS](https://github.com/honcheng/PaperFold-for-iOS). Selecting from the menu on the left changes the view controller on the right. PaperFoldMenuController uses view controller containment. 


<img src="https://github.com/honcheng/PaperFoldMenuController/raw/master/Screenshots/demo.png"/>


<img src="https://github.com/honcheng/PaperFoldMenuController/raw/master/Screenshots/demo.gif"/>

Usage
-----

#PaperFoldMenuController

##initWithMenuWidth:numberOfFolds
Initialize PaperFoldMenuController

	- (id)initWithMenuWidth:(float)menuWidth numberOfFolds:(int)numberOfFolds
	
####Parameters
#####menuWidth
This value specifies the width of the table view in the left menu
#####numberOfFolds
This value specifies the number of folds in the menu table view

##setViewControllers:
Sets the root view controllers. Title for each view controllers appears in the menu table view

	- (void)setViewControllers:(NSMutableArray *)viewControllers

####Parameters
#####viewControllers
The array of custom view controllers to display on screen. The title of each view controllers are shown in the menu table view on the left. 

##setSelectedIndex:
Sets the current root view controller in contentView by index

	- (void)setSelectedIndex:(NSUInteger)selectedIndex
	
####Parameters
#####selectedIndex
An integer value which is the index of the root  view controller in the viewControllers array.

##showMenu:animated:
Show or hide the menu table view. 

	- (void)showMenu:(BOOL)show animated:(BOOL)animated

####Parameters
#####show
A boolean value to indicate if the menu should be shown or hidden
#####animated
A boolean value to indicate if the folding/unfolding should be animated
#####Discussion
This method is automatically called with show=YES and animated=YES when a cell in menu table view is selected. 

#PaperFoldMenuControllerDelegate

##paperFoldMenuController:shouldSelectViewController:
Ask the delegate whether the specified view controller should be made active

	- (BOOL)paperFoldMenuController:(PaperFoldMenuController *)paperFoldMenuController shouldSelectViewController:(UIViewController *)viewController

####Parameters
#####paperFoldMenuController
The paperfold menu controller containing the viewController.
#####viewController
The view controller selected in the menu
#####Discussion
The paperfold menu controller calls this method in response to the user tapping on the left menu. You can use this method to dynamically decide whether the view controller should be made active.

##paperFoldMenuController:didSelectViewController:
The paperfold menu controller calls this method in response to the user tapping the left menu, after the viewController is made active.

	- (void)paperFoldMenuController:(PaperFoldMenuController *)paperFoldMenuController didSelectViewController:(UIViewController *)viewController

####Parameters
#####paperFoldMenuController
The paperfold menu controller containing the viewController.
#####viewController
The view controller selected in the menu


##paperFoldMenuController:shouldFoldMenuToRevealViewController:
Ask the delegate if the menu table view should be folded to reveal the selected view controller

	- (BOOL)paperFoldMenuController:(PaperFoldMenuController *)paperFoldMenuController shouldFoldMenuToRevealViewController:(UIViewController *)viewController;

####Parameters
#####paperFoldMenuController
The paperfold menu controller containing the viewController.
#####viewController
The view controller selected in the menu

	
Requirements
---

This project uses ARC. If you are not using ARC in your project, add '-fobjc-arc' as a compiler flag for all the files in this project.

XCode 4.4 is required for auto-synthesis.

iOS 5.0 and above is required because the project uses view controller containment.

Contact
------

[twitter.com/honcheng](http://twitter.com/honcheng)
[honcheng.com](http://honcheng.com)

![](http://www.cocoacontrols.com/analytics/honcheng/paperfoldmenucontroller.png)
