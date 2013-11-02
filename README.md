iOS Card UI Library
=========

Background
-----
I like making card games for iOS for my friends and family. When I started
doing this, I noticed that there were no nice libraries available for rendering
attractive looking playing cards. Furthermore, the few that I found used static
images for cards, which is frustrating when you, e.g., want to render different
card sizes on iPhones and iPads.

I found a nice open source package of playing cards in vector format
(https://code.google.com/p/vectorized-playing-cards/), but iOS has limited
support for vector graphics.

To work around these issues, I modified the playing card graphics to be pages
in a PDF document and use the native PDF rendering capabilities in iOS to
render the playing cards at any resolution.

This library is the end result of that series of hacks, and I hope it will
be useful to other folks making card games for iOS.

Usage
-----

Draw a single card:

```objc
CGFloat width = 100;
CGFloat height = [CardView heightForWidth:width];
CardView *cardView = [[CardView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
cardView.card = [[Card alloc] initWithSuit:Hearts number:King];
```

See all the cards in a grid:

```objc
[self.navigationController pushViewController:[CardsController new]];
```

Screenshots
-----
Drawn a simple grid at a couple different sizes:

![Small](https://f.cloud.github.com/assets/58667/1460146/04aaa856-4415-11e3-882d-4c5e0a09570d.png)

![Big](https://f.cloud.github.com/assets/58667/1460147/04abd1ae-4415-11e3-8aa9-e15a282b9be4.png)

License
-----
This library is available under the Apache License, Version 2.0
(http://www.apache.org/licenses/LICENSE-2.0.html).

The library includes card images released under the LGPL. See
https://code.google.com/p/vectorized-playing-cards/.
