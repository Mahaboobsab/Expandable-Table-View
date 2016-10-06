//
//  ViewController.h
//  ExpandableTableView
//
//  Created by test on 04/10/16.
//  Copyright © 2016 com.NeoRays. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@end

