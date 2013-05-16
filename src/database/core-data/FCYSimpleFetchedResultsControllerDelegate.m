
#import "FCYSimpleFetchedResultsControllerDelegate.h"

@implementation FCYSimpleFetchedResultsControllerDelegate

@synthesize tableView;
@synthesize insertAnimation;
@synthesize updateAnimation;
@synthesize deleteAnimation;

- (id)initWithTableView:(UITableView *)newTableView {
    self = [super init];
    if (self) {
        tableView = newTableView;
        insertAnimation = UITableViewRowAnimationTop;
        deleteAnimation = insertAnimation;
        updateAnimation = UITableViewRowAnimationFade;        
    }
    
    return self;
}

#pragma mark -
#pragma mark NSFetchedResultsControllerDelegate

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [[self tableView] beginUpdates];    
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [[self tableView] insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:insertAnimation];
            break;
        case NSFetchedResultsChangeDelete:
            [[self tableView] deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:deleteAnimation];
            break;
        case NSFetchedResultsChangeUpdate:
            [[self tableView] reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:updateAnimation];
            break;
        case NSFetchedResultsChangeMove:
            [[self tableView] deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:deleteAnimation];
            [[self tableView] insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:insertAnimation];
            break;
        default:
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [[self tableView] endUpdates];
}

@end
