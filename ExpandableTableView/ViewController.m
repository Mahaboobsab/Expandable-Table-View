//
//  ViewController.m
//  ExpandableTableView
//
//  Created by test on 04/10/16.
//  Copyright © 2016 com.NeoRays. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController{
    
    NSArray *sectionTitleArray;
    NSMutableArray *arrayForBool;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    sectionTitleArray=@[
                       @"Apple",
                       @"Strawberry",
                       @"Grapes",
                       @"Orange",
                       @"Banana",
                       @"Papaya",
                       @"Guava",
                       @"pineapple"];
    
    
    
   // arrayForBool=[[NSMutableArray alloc]init];
    
    for (int i=0; i<[sectionTitleArray count]; i++) {
        [arrayForBool addObject:[NSNumber numberWithBool:NO]];
        
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if ([[arrayForBool objectAtIndex:section] boolValue]) {
        return section+2;
    }
    else
        return 0;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static NSString *cellid=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellid];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellid];
    }
    
    
    BOOL manyCells  = [[arrayForBool objectAtIndex:indexPath.section] boolValue];
    
    /********** If the section supposed to be closed *******************/
    if(!manyCells)
    {
        cell.backgroundColor=[UIColor clearColor];
        
        cell.textLabel.text=@"";
    }
    /********** If the section supposed to be Opened *******************/
    else
    {
        cell.textLabel.text=[NSString stringWithFormat:@"%@ %ld",[sectionTitleArray objectAtIndex:indexPath.section],indexPath.row+1];
        cell.textLabel.font=[UIFont systemFontOfSize:15.0f];
        cell.backgroundColor=[UIColor whiteColor];
        cell.imageView.image=[UIImage imageNamed:@"point.png"];
        cell.selectionStyle=UITableViewCellSelectionStyleNone ;
    }
    cell.textLabel.textColor=[UIColor blackColor];
    
    /********** Add a custom Separator with cell *******************/
    UIView* separatorLineView = [[UIView alloc] initWithFrame:CGRectMake(15, 40, self.myTableView.frame.size.width-15, 1)];
    separatorLineView.backgroundColor = [UIColor blackColor];
    [cell.contentView addSubview:separatorLineView];
    
    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [sectionTitleArray count];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    /*************** Close the section, once the data is selected ***********************************/
    [arrayForBool replaceObjectAtIndex:indexPath.section withObject:[NSNumber numberWithBool:NO]];
    
    [self.myTableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationAutomatic];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[arrayForBool objectAtIndex:indexPath.section] boolValue]) {
        return 40;
    }
    return 0;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView *sectionView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 280,40)];
    sectionView.tag=section;
    UILabel *viewLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, self.myTableView.frame.size.width-10, 40)];
    viewLabel.backgroundColor=[UIColor clearColor];
    viewLabel.textColor=[UIColor blackColor];
    viewLabel.font=[UIFont systemFontOfSize:15];
    viewLabel.text=[NSString stringWithFormat:@"List of %@",[sectionTitleArray objectAtIndex:section]];
    [sectionView addSubview:viewLabel];
    /********** Add a custom Separator with Section view *******************/
    UIView* separatorLineView = [[UIView alloc] initWithFrame:CGRectMake(15, 40, self.myTableView.frame.size.width-15, 1)];
    separatorLineView.backgroundColor = [UIColor blackColor];
    [sectionView addSubview:separatorLineView];
    
    /********** Add UITapGestureRecognizer to SectionView   **************/
    
    UITapGestureRecognizer  *headerTapped   = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sectionHeaderTapped:)];
    [sectionView addGestureRecognizer:headerTapped];
    
    return  sectionView;
    
    
}
- (void)sectionHeaderTapped:(UITapGestureRecognizer *)gestureRecognizer{
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:gestureRecognizer.view.tag];
    if (indexPath.row == 0) {
        BOOL collapsed  = [[arrayForBool objectAtIndex:indexPath.section] boolValue];
        for (int i=0; i<[sectionTitleArray count]; i++) {
            if (indexPath.section==i) {
                [arrayForBool replaceObjectAtIndex:i withObject:[NSNumber numberWithBool:!collapsed]];
            }
        }
        [self.myTableView reloadSections:[NSIndexSet indexSetWithIndex:gestureRecognizer.view.tag] withRowAnimation:UITableViewRowAnimationAutomatic];
        
    }
}

@end
