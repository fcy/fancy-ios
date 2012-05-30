//    Copyright 2011 Felipe Cypriano
// 
//    Licensed under the Apache License, Version 2.0 (the "License");
//    you may not use this file except in compliance with the License.
//    You may obtain a copy of the License at
// 
//        http://www.apache.org/licenses/LICENSE-2.0
// 
//    Unless required by applicable law or agreed to in writing, software
//    distributed under the License is distributed on an "AS IS" BASIS,
//    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//    See the License for the specific language governing permissions and
//    limitations under the License.

/**
 * @file FCSimpleFetchedResultsControllerDelegate
 * A simple, yet useful, implementation of NSFetchedResultsControllerDelegate
 *
 * @author Felipe Cypriano
 * @date 2011
 */

#import <Foundation/Foundation.h>


/**
 * @brief A delegate to handle NSFetchedResultsChangeInsert, NSFetchedResultsChangeDelete, NSFetchedResultsChangeUpdate and NSFetchedResultsChangeMove
 *
 * <p>A implementation of NSFetchedResultsControllerDelegate that handles
 * the basics operations insert, update, delete and move. This class doesn't retain itself, you should maintain ownership on your calling code.</p>
 *
 * <p>Use it when you don't need any special cases to handle
 * changes from NSManagedObjectContext. Example:</p>
 *
 * <code>
     NSFetchedResultsController *fetchedController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:moc sectionNameKeyPath:nil cacheName:nil];
     FCSimpleFetchedResultsControllerDelegate *delegate = [[FCSimpleFetchedResultsControllerDelegate alloc] initWithTableView:[self tableView]];
     fetchedController.delegate = delegate;
 * </code>
 */
@interface FCSimpleFetchedResultsControllerDelegate : NSObject <NSFetchedResultsControllerDelegate>

@property (nonatomic, assign, readonly) UITableView *tableView; 
@property (nonatomic) UITableViewRowAnimation insertAnimation;
@property (nonatomic) UITableViewRowAnimation deleteAnimation;
@property (nonatomic) UITableViewRowAnimation updateAnimation;

- (id)initWithTableView:(UITableView *)tableView;

@end
