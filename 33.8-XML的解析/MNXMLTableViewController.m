//
//  MNXMLTableViewController.m
//  33.8-XML的解析
//
//  Created by Mac on 14-10-31.
//  Copyright (c) 2014年 MN. All rights reserved.
//

#import "MNXMLTableViewController.h"

@interface MNXMLTableViewController ()

@end

@implementation MNXMLTableViewController


-(void)setVideoList:(NSArray *)VideoList{

    _VideoList = VideoList;
    
    [self.tableView reloadData];

}


- (void)viewDidLoad {
    [super viewDidLoad];
    }


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

   
    return  1;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   return  self.VideoList.count;}



-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
        static NSString *identifier = @"ID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    Video *video = self.VideoList[indexPath.row];
    
    cell.textLabel.text = video.name;
    
    cell.detailTextLabel.text = video.desc;

    return  cell;
}
@end
