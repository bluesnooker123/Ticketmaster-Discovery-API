# Ticketmaster-Discovery-API
PHP script that using Ticketmaster API's that can check, monitor, and insert data into a MySQL database.

- Pull event info from their discovery API and loop through all available pages
- Enter the information into a mysql database.
- Compare the current call data to prior call data and send or record a summary of changes (X new events, X changed, X removed, etc)
