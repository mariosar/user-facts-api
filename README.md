# A simple API for two resources 'users' 'facts'

Built using rails --api database=postgresql

Create a database and user for development
```
sudo su postgres
psql
```

```
CREATE DATABASE user_facts_api_development;
CREATE USER user_facts_api WITH ENCRYPTED PASSWORD 'secretpass';
GRANT ALL PRIVILEGES ON DATABASE user_facts_api_development TO user_facts_api;
```
```
rake db:migrate
```
Generated User and Fact models with a user having many facts
Namespaced users and facts controller under api/v1/


