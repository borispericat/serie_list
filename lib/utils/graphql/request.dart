String requestApi = """
query (\$page: Int, \$perPage: Int) { 
  Page (page: \$page, perPage: \$perPage) {
    pageInfo {
       total
      currentPage
      lastPage
      hasNextPage
      perPage
    }
     activities(isFollowing: true, sort: ID_DESC) {
      ... on TextActivity {
        id
        userId
        type
        replyCount
        text
        createdAt
        user {
          id
          name
          avatar {
            large
          }
        }
        likes {
          id
          name
          avatar {
            large
          }
        }
        replies {
          id
          text
          createdAt
          user {
            id
            name
            avatar {
              large
            }
          }
          likes {
            id
            name
            avatar {
              large
            }
          }
        }
      }
      ... on ListActivity {
        id
        userId
        type
        status
        progress
        replyCount
        createdAt
        user {
          id
          name
          avatar {
            large
          }
        }
        media {
          id
          title {
            userPreferred
          }
          coverImage {
            large
            medium
            color
          }
        }
        likes {
          id
          name
          avatar {
            large
          }
        }
        replies {
          id
          text
          createdAt
          user {
            id
            name
            avatar {
              large
            }
          }
          likes {
            id
            name
            avatar {
              large
            }
          }
        }
      }
      ... on MessageActivity {
        id
        type
        replyCount
        createdAt
        messenger {
          id
          name
          avatar {
            large
          }
        }
        likes {
          id
          name
          avatar {
            large
          }
        }
        replies {
          id
          text
          createdAt
          user {
            id
            name
            avatar {
              large
            }
          }
          likes {
            id
            name
            avatar {
              large
            }
          }
        }
      }
    }
  
  }

}
""";

