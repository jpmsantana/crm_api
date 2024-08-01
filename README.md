# CRM API

Welcome to the CRM API! This project aims to provide a comprehensive yet simple API to manage customer relationships. Whether you are building a new CRM system or enhancing an existing one, this API offers the tools needed to efficiently manage customer data.

## Features

- **Customer Management**: Easily create, read, update, and delete customer information.
- **Secure and Scalable**: Built with security best practices in mind and designed to scale with your needs.
- **Extensible**: Add new features and functionalities without hassle.

## Getting Started

### Prerequisites

Before you begin, ensure you have met the following requirements:
- [Ruby](https://www.ruby-lang.org/en/) (version 3.3.1)
- [Rails](https://rubyonrails.org/) (version 7.1.3.4)
- [PostgreSQL](https://www.postgresql.org/) (version 16.3)

### Installation

#### Local Installation

1. Clone the repository:
    ```sh
    git clone https://github.com/jpmsantana/crm-api.git
    ```
2. Navigate to the project directory:
    ```sh
    cd crm-api
    ```
3. Install the dependencies:
    ```sh
    bundle install
    ```

#### Docker Installation

1. Clone the repository:
    ```sh
    git clone https://github.com/jpmsantana/crm-api.git
    ```
2. Navigate to the project directory:
    ```sh
    cd crm-api
    ```
3. Build and start the containers using Docker Compose:
    ```sh
    docker-compose up --build
    ```
4. Run database migrations:
    ```sh
    docker-compose run web rake db:migrate
    ```

### Usage

1. Start the server:
    ```sh
    rails server
    ```
2. The API will be available at `http://localhost:3000`.

#### Usage with Docker

1. Start the containers:
    ```sh
    docker-compose up
    ```
2. The API will be available at `http://localhost:3000`.

## Running Tests

To ensure that everything is working correctly, you can run the RSpec tests provided in the project.

### Local Testing

1. Ensure you have the necessary test dependencies installed:
    ```sh
    bundle install
    ```
2. Run the RSpec tests:
    ```sh
    bundle exec rspec -fd
    ```

### Testing with Docker

1. Run the RSpec tests inside the Docker container:
    ```sh
    docker-compose run web bundle exec rspec -fd
    ```

The test results will be displayed in the console, showing which tests have passed and which have failed.

## Contributing

We welcome contributions from the community! To ensure a smooth process, please follow these guidelines:

1. **Fork the Repository**: Create a fork of the repository on GitHub.

2. **Clone Your Fork**: Clone your fork to your local machine.
    ```sh
    git clone https://github.com/jpmsantana/crm-api.git
    ```

3. **Create a Branch**: Create a new branch for your feature or bug fix.
    ```sh
    git checkout -b feature-or-bugfix-name
    ```

4. **Make Changes**: Make your changes in the new branch.

5. **Commit Changes**: Commit your changes with a clear and descriptive commit message.
    ```sh
    git commit -m "Description of the changes made"
    ```

6. **Push to GitHub**: Push your changes to your fork on GitHub.
    ```sh
    git push origin feature-or-bugfix-name
    ```

7. **Create a Pull Request**: Open a pull request (PR) from your branch to the `main` branch of the original repository. Make sure to provide a detailed description of your changes.

8. **Wait for Approval**: The repository owner will review your PR. Once approved, your changes will be merged into the main branch.

We appreciate your contributions and look forward to improving the CRM API together!
