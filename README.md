# Go-To-Application
Main application of Go-To - A photo based social media platform\
\
"Archive" folder contains nothing that is relevant anymore.\
\
Even more importantly, "database_login.csv" must not have read permissions for anyone not involved in hosting the website as it stores the username and password required to access it.\
\
Possibly most importantly of all though, reset.php should never be accessible to anyone who shouldn't have the power to reset all data stored in the database, and all uploaded content. This can be used to start the tables of the database, however. So long as a database called "userfiles" exists, and the login credentials in database_login.csv are correct.\
\
It is easy to change the login details for the database if required, by just changing the contents of database_login.csv. Seperated by commas should be the host name, username, password and default database to use.
