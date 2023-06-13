# cinefly_internship_app

This is a simple Flutter application so that cinefly managers can assess my skills and decide if I can meet the internship requirements.

## Creating a Dev Environment
I followed the Flutter official website to install a Flutter **Dev environment**. As My computer's system is Windows 11, I chose the **Android Studio** as my development platform.

## Analysis & Planning
I read through the internship requirement documents and identified the functions I should complete.
There are two parts:
1. **Basic functions** (Product Listing Page, Product Detail Page, and Shopping Cart Page).
2. **Extra functions** (A search feature, an animation feature, and an quantity selection feature).

As this is my first time to develop a Flutter application, I planned to spend **2 hours** on learning some **basic knowledge** before coding. I read through the Flutter documentation and watch three videos.
After that, I planned to finish all the functions in two days (**basic functions: high priority, extra functions: low priority**).

## Find a good project structure
I looked at two videos to identify a popular **Flutter project structure**. I created some folders, such as **auth, pages, services (sub-folders: functions, models, providers, settings), utils, widgets (sub-folders: global and features), and assets (sub-folders: data, fonts, icons, and images)**.
Each folder has its unique use. I tried to use the **MVC model** to implement this project.

## Basic Functions
Firstly, I created a **data model** for products based on the structure of the **JSON file** and designed a cart data model as well.
Secondly, I created a **provider** to **add, update, remove items** from the cart.
Thirdly, I designed **four pages** for the Home Page, the Product Listing Page, the Product Detail Page, and the Shopping Cart Page.
Fourthly, I linked them together and called functions/methods to achieve the business requirements.
Finally, after a testing, I found **a bug** (one image url is invalid and could not access to the image). I **analysed this bug will affect three pages** (the Product Listing Page, the Product Detail Page, and the Shopping Cart Page) and used a placeholder image to solve this issue.

## Extra Functions
For the extra functions, I decided to implement them one by one.
Firstly, I created a method to **filter the products based on the product name**.
Secondly, I used a **Hero()** to add an animation when users click an item in the Product Listing Page.
Thirdly, I used two IconButtons and one Text to implement a quantity selector, and added two new methods in the cart provider which are **incrementItem()** and **decrementItem()**.

## Git Hub
I am used to creating a new branch for each iteration. For example, in this internship project, I created **four branches: basic_functions, feature1, feature2, and feature3**.
After I finished a task, I **merged the branch** into the origin/master branch and **added a tag**.

## Doc Comments and Comments
I also write **Doc Comments and Comments** for my codes in order to improve the maintenance of codes.