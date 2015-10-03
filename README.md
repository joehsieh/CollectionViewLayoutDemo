# CustomizeCollectionViewLayout

### What is this repository for? ###

It is a demo for different kinds of customized collectionViewLayout.


### How to customize collectionViewLayout ?

#### Basic Concept ####

CollectionViewLayout customization is an interesting thing. If you look carefully at the layout, you might have two questions about the layout. First, what is the contentSize of the whole layout ? Second, what does the cell look like ? (The position of the cell ? Is the cell rotated ?) for each different indexPath.

In order to answer the questions, UICollectionViewLayout provides three important methods for us to customize the layout.

#### - (void)prepareLayout; ####

We describe the whole layout by creating an array of UICollectionViewLayoutAttributes's instance in prepareLayout. UICollectionViewLayoutAttributes is used to describe what the cell looks like.

#### - (NSArray *)layoutAttributesForElementsInRect:(CGRect)inRect; ####

The layout provides an array of UICollectionViewLayoutAttributes's instance in the specific area (Part of layoutAttributes we created in prepareLayout) to collectionView that we scrolled by layoutAttributesForElementsInRect.

#### - (CGSize)collectionViewContentSize; ####

Basically, the contentSize of layout is calculated in prepareLayout.

#### Layout of VerticalWaterfall <br/><br/> ![VerticalWaterfall](https://dl.dropboxusercontent.com/u/17691359/screenshots/VerticalWaterfall.gif)
#### Layout of HorizontalWaterfall <br/><br/> ![HorizontalWaterfall](https://dl.dropboxusercontent.com/u/17691359/screenshots/HonrizontalWaterfall.png)
