# cpp-todo-backend

A ToDo application written in C++ using [Crowcpp](https://github.com/CrowCpp/Crow/tree/v1.0%2B3) and [sqlpp11](https://github.com/rbock/sqlpp11) for database connection.
  
## Build and Install (WIP)

### Docker
```bash
# Go to root directory
cd cpp-todo-backend

# Build docker image
docker build -t cpp-todo-backend .

# Run docker image
docker run -it -v `pwd`:/usr/builder/application -p 8080:18080 --name cpp-todo-backend cpp-todo-backend
```

## Usage

```bash
# Compile
sh compile.sh

# Run
./build/main
```

### Uninstall

```bash
# Uninstall build
sh uninstall.sh
```