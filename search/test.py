import datetime 
import sqlite3
import re 

# Connect to the SQLite database
db_path = '/home/duncan/podcasts/podcastindex_feeds.db'
connection = sqlite3.connect(db_path)

# Create a cursor object to interact with the database
cursor = connection.cursor()

# Query to select 10 rows from a table (replace 'your_table_name' with the actual table name)
query = "SELECT * FROM podcasts"

start_time = datetime.datetime.now()
words = {}

try:
    # Execute the query
    cursor.execute(query)
    # Fetch column names
    column_names = [description[0] for description in cursor.description]
    # Fetch the rows
    rows = cursor.fetchall()
    
    # Iterate through the rows and print them
    with open('titles.txt', 'w') as f:
        for row in rows:
            item = dict(zip(column_names, row))
            for word in re.findall(r'\b\w+\b', item['title'].lower()):
                words[word] = words.get(word, 0) + 1
            f.write(item['title'] + '\n')
finally:
    # Close the connection
    connection.close()

end_time = datetime.datetime.now()
print(f"Time taken: {end_time - start_time}")
# 13102 -> 10_000
# 73023 -> 100_000
print(len(words.keys()))