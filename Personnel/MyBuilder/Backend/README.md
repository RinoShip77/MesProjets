
# MyBuilder (Backend)
This is for my server in NodeJS.

### Too test this project:
1. Install a **Mysql instance locally** (like Wampserver).

2. Import the **'./data/my_builder.sql'** file in the *'./data'* folder to create the databsase and import data.

3. Open a **terminal** and go to the *'Backend'* folder.

4. This project require a [Stripe](https://dashboard.stripe.com/login) account to complete the checkout.

5. To correctly run the server you need to add a *'.env'* file at the root of the project with these variables
````
PORT={{THE PORT OF THE SERVER}}
DB_HOST={{WHERE YOUR DATABASE IS LOCATED}}
DB_USER={{THE USERNAME TO ENTER MYSQL}}
DB_PASSWORD={{THE PASSWORD TO ENTER MYSQL}}
DB_DATABASE={{THE NAME OF YOUR DATABASE}}
STRIPE_KEY={{YOUR STRIPE SECRET KEY}}
````

1. Type these **commands** to start the *NodeJS* server:

>***
> - ````npm install````
>
> - ````npm start````
> ***