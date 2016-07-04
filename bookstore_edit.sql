# Exercise 1
# Fetch ISBN of all book editions published by the publisher "Random House". You should have 3 results.

SELECT e.isbn FROM editions AS e, publishers AS p WHERE
e.publisher_id = p.id AND p.name = 'Random House';

# Exercise 2
# Instead of just their ISBN number, fetch their Book Title as well. You should still have the same 3 results but with more information. But instead of just one column, we should have 2 columns in the result set.

SELECT b.title, e.isbn FROM books AS b, editions AS e, publishers AS p WHERE b.id = e.book_id AND
e.publisher_id = p.id AND p.name = 'Random House';

# Exercise 3
# Also include their stock information (available stock and retail price for each book 
# edition). You should still have the same 3 results but with more information. 
# But instead of just 2 columns, we should have 4 columns in the result set.

SELECT b.title, e.isbn, s.retail, s.stock FROM books AS b, editions AS e, publishers AS p, stock AS s WHERE e.isbn = s.isbn AND b.id = e.book_id AND e.publisher_id = p.id AND p.name = 'Random House';

# Exercise 4
# Note how one of the of books has 0 stock. Modify the query to only return books that are in stock.

SELECT b.title, e.isbn, s.retail, s.stock FROM books AS b, editions AS e, publishers AS p, stock AS s WHERE e.isbn = s.isbn AND b.id = e.book_id AND e.publisher_id = p.id AND p.name = 'Random House' AND s.stock > 0;

# Exercise 5
# Hardcover vs Paperback
# Editions has a column called "type". Include the print type but instead of just displaying "h" or "p" (the values in the column) output the human readable types ("hardcover" and "paperback" accordingly)

# Hint: Use a CASE statement to manipulate your result set, as in this example.

SELECT title, CASE WHEN type = 'p' THEN 'paperback' WHEN type = 'h' THEN 'hardcover' END FROM editions INNER JOIN books ON books.id = editions.book_id;

# Exercise 6
# List all book titles along with their publication dates (column on the editions dates) That's 2 columns: "title" and "publication"

# Important Notes:

# Certain books (such as "Learning Python") don't have any editions but we still want to see those books in the results. They just shouldn't have a publication date associated with them.
# Certain other books (such as "Dune") have multiple editions and they will be repeated multiple times in the result set.

SELECT title, publication FROM 
editions RIGHT JOIN books
ON books.id = editions.book_id;

# Aggregate Functions
# You can read about how to perform aggregate functions here: https://webcache.googleusercontent.com/search?q=cache:V-8O5PgOO_0J:https://www.commandprompt.com/ppbook/x8973#AGGREGATEFUNCTIONSTABLE

# Exercise 7
# What's the total inventory of books in this library (i.e. how many total copies are in stock)?

SELECT SUM(stock) FROM stock;

# Exercise 8
# What is the overall average cost and retail price for all books for sale? Return three columns "Average cost", "Average Retail" and "Average Profit"

SELECT AVG(cost) as "Average Cost", AVG(retail) AS "Average Retail", AVG(retail-cost) AS "Average Profit" FROM stock

# Exercise 9
# Which book ID has the most pieces in stock?

# Hints:

# Use an aggregate function combined with LIMIT and ORDER BY clauses.
# No need to join with the books table since we just want the ID which is already in the editions table.
# Grouping results
# Read about grouping here: https://webcache.googleusercontent.com/search?q=cache:V-8O5PgOO_0J:https://www.commandprompt.com/ppbook/x5802#USINGGROUPBY

SELECT book_id, stock
FROM editions, stock
ORDER BY stock DESC;

# Exercise 10
# List author ID along with the full name and the number of books they have written. Output 3 columns: "ID", "Full name" and "Number of Books"

SELECT authors.id as "ID", (authors.last_name || ' ' || authors.first_name) AS "Full Name", COUNT(title) AS "Number of Books" 
FROM authors, books 
WHERE books.author_id = authors.id
GROUP BY "ID", "Full Name";

# Exericse 11
# Order the result set above by number of books so that authors with most number of books appear atop the list (descending order).

SELECT authors.id as "ID", (authors.last_name || ' ' || authors.first_name) AS "Full Name", COUNT(title) AS "Number of Books" 
FROM authors, books 
WHERE books.author_id = authors.id
GROUP BY "ID", "Full Name"
ORDER BY "Number of Books" DESC;

------------------------------------------------------------------------------


-- Advanced, Bonus Exercises
-- Exercise 12
-- List books that have both paperback and hardcover editions. That means at least one edition of the book in both formats.

-- The result contains four books:

-- The Shining
-- Dune
-- 2001: A Space Odyssey
-- The Cat in the Hat
-- Exercise 13
-- For each publisher, list their average book sale price, number of editions published.