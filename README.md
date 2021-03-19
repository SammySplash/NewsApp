# PopularNews
News application using the API from https://newsapi.org/

API News Is JSON API for live news and blog articles from the media.
This project use URLSession.  
MVVM design pattern.
Render Articles inside in TableView.
Ditail view is basicly going to be SFSafariViewController (view website or webpage in Safari).
This newsApp built out completely programmatically inside UIKit (there's no use of storyboards, nibs, so it's very similar to enterprise level development where most of the companies don't adopt or don't actually go about using storyboards or nip files due to certain like issues, that the run into over in bigger teams)
Using NSCache to cahe images.
Custom ImageView with Shadow.
Breakdown by categories of news articles.

# Clone this project

Clone with HTTPS
https://github.com/haerulmuttaqin/PopularNews.git

# For start

Get your API key
https://newsapi.org/register

>Replace your API key in "Config" folder (parent NewsApp -> NewsApp -> Config )
```
struct APIKey {
    static let key = "your secret api key"
    
}

```

 
