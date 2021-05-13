class UrlHelper {
  static String urlForTopStories() {
    return "https://cerbo.glitch.me/v1/news";
  }

  static String urlForCommentById(int commentId) {
    return "https://hacker-news.firebaseio.com/v0/item/${commentId}.json?print=pretty";
  }
}
