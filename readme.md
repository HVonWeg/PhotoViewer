# PhotoViewer

Example Swift project for viewing photos from the fake API https://jsonplaceholder.typicode.com
It contains a Photo List Collection view and a detail view.
Tapping on an element in the list navigates to the detail view.

<p align="center">
<img height="300" src="https://github.com/HVonWeg/PhotoViewer/blob/master/screenshot.png" />
</p>


## Well done
- Using CollectionView instead of TableView.
- Fixed loading image issues with the "Network Link Conditioner" from Mac with "Very Bad Network" condition.
- Implemented image cache.
- FadeIn animation implemented for non-cached images.
- Canceling requests that are not necessary any more.
- Using activity indicator for showing downloading process for very bad network.
- Supporting landscape and portrait mode.

## Improving things
- Add unit and UI Tests.
- Create an abstract CollectionView which supports various kind of Cells (CollectionViewCellModel).
- Using async/wait (current iOS target is 13.0, Xcode: 13.1 - but first included in 13.2).
- Add progress screen for PhotoViewController.
- Add error handler for PhotoViewController.
- Refactore quick and dirty DetailViewController.
- Calculating best size for collection view items.
- DetailView: creating better layout for landscape mode.
- Rename the bad project name :)
