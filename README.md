Here you see the application that is a web shop for Pies.
Ashish's pie shop has a landing page where a selection pies of the week is shown. I can click on any of these pies, and then I'll go to the detail page of that particular pie. 
I can then add that to my shopping cart. We can also browse the entire catalog of pies by clicking on the Pies menu that will then expand all the pies per category.
When you check out, you see a order form to fill out the details and your order will be on your way!

This application is developed in **ASP.NET Core 5 MVC C#**. **Entitiy Framework** is used here for data modeling. 
- Shopping cart system is developed. **Authorization and Authentication** like user Register and user login are done using **.NET Core Identity**. 
- At least one reviewer is required to approve the pull request before merging the changes in. YAML file will also be added as **Continous Integration (CI)** of project to build and test .NET solution.

Project Structure

├── .github

│   └── workflows

│       └── build-and-deploy.yml   # GitHub Actions workflow

├── docker-compose.yml             # Docker Compose configuration

├── Dockerfile                     # Dockerfile for .NET app

├── src/                           # .NET project source code
