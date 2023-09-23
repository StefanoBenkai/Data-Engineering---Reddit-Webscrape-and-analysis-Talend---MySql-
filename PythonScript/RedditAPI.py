import praw
import mysql.connector


# MYSQl Conn Parameters
host = 'localhost'
user = 'root'
password = ''
database = 'WebScrapeDB'

#connection
conn = mysql.connector.connect(host=host, user=user, password=password, database=database)


reddit=praw.Reddit(client_id = "",
                    client_secret = "",
                    user_agent = "",
                    username = "",
                    password = "",  )



url = "https://www.reddit.com/r/dataengineering/comments/16o883v/python_pareto_principle_what_is_the_20_algos/"

submission = reddit.submission(url=url)

from praw.models import MoreComments

for top_level_comment in submission.comments:
    if isinstance(top_level_comment, MoreComments):
        continue
    words = top_level_comment.body.split()  #
    for word in words:
        word = ''.join(word.split())

        cursor = conn.cursor()
        insert_query = "INSERT INTO t_RedditAPI (comment) VALUES (%s)"
        cursor.execute(insert_query, (word,))
        conn.commit()

# Close Conn
conn.close()
