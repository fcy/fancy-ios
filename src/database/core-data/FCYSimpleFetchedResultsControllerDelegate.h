/**
 * @file FCYSimpleFetchedResultsControllerDelegate
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
     FCYSimpleFetchedResultsControllerDelegate *delegate = [[FCYSimpleFetchedResultsControllerDelegate alloc] initWithTableView:[self tableView]];
     fetchedController.delegate = delegate;
 * </code>
 */
@interface FCYSimpleFetchedResultsControllerDelegate : NSObject <NSFetchedResultsControllerDelegate>

@property (nonatomic, assign, readonly) UITableView *tableView; 
@property (nonatomic) UITableViewRowAnimation insertAnimation;
@property (nonatomic) UITableViewRowAnimation deleteAnimation;
@property (nonatomic) UITableViewRowAnimation updateAnimation;

- (id)initWithTableView:(UITableView *)tableView;

@end
