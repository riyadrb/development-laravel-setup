# Automated Laravel Environment Setup and Deployment

Welcome to the automated Laravel environment setup and deployment system designed for Unix-like operating systems. This system is designed to save you time and streamline the setup and deployment process for Laravel development, both locally and in a production environment. 

**Supported PHP Versions:** PHP '^7.4' and '^8.0'.

**Prerequisites:** Basic knowledge of Linux commands.


## Local Development

To set up your local development environment, follow these steps:

1. Open your terminal and run the following command:
   
    ```bash
    bash local.sh
    ```

2. The system will prompt you to provide the following information:
   - Project name
   - MySQL database name
   - MySQL password

3. Once you've provided the necessary information, the local development environment will be configured for you. 


## Production Environment Deployment

To deploy your Laravel project to a production server, follow these steps:

1. Open your terminal and run the following command:

    ```bash
    bash remote.sh
    ```

2. The system will prompt you to provide the following information:
   - Project name
   - MySQL database name
   - MySQL password
   - Your GitHub/Bitbucket/GitLab repository URL
   - *Assumption*: You have root privileges.

3. After entering the required information, the system will automate the deployment process on the production server. It's essential to test your project on your local server before deploying it to production.



## Collaborate with a Team

To collaborate with a team on your Laravel project, use the following command:

1. Open your terminal and run the following command:

    ```bash
    bash team.sh
    ```

2. The system will prompt you to provide the following information:
   - Project name
   - MySQL database name
   - MySQL password
   - Repository URL

3. After entering the required information, the system will set up the environment for collaboration with your team.

This automated system simplifies the Laravel development process, making it more efficient and hassle-free. It is designed to enhance your productivity and help you focus on your project's core development tasks. Enjoy your Laravel development journey!
