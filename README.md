# Gossip - CVWO web forum submission backend.
This is repo contains the source code for the backend implementation of the CVWO project for submission.

Name: Tan Jing Xu, Derek\
Matriculation Number: A0196465N

## Link to deployed app on Netlify: https://heartfelt-rugelach-c1701b.netlify.app
This project is implemented with Ruby on Rails, using PostgreSQL as the database. Currently working version is deployed on Render.

This servers as the REST api backend for a web forum. Endpoints are provided for the following main operations:

1. Create, Read, Update, and Delete operations for Users, posts, and replies.
2. Create and Delete operations for like, dislike and save posts.
3. Create and Delete operations for like and dislike replies.

Additional endpoints are provided to retrieve posts and replies sorted by created_date, likes and dislikes. Posts can also be retrieved by categories.

To run the project locally, use the command ```rails server```. Ensure that you have postgreSQL and rails installed on locally.
