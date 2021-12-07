# docker_test_env

This is the dockerfile for building a test environment of my codes. I am using this environment to check the operation of my codes. The test environment uses the docker image of Ubuntu 20.04. The packages needed to run my codes are automatically installed so you can compile and run the code and visualize the results by only starting the container image. Intel C compiler is also available. The image size becomes about 9GB. 

## Usage  

1. change the user settings (user name and IDs) in the Dockerfile as needed.  
   The default settings are "user" for the user name, "user" for the group name, "1000" for the user ID, and "1000" for the group ID. 
   
2. type 'docker build . -t image_name' to build image.  
   image_name is an arbitrary.

3. type 'docker run -itd --name container_name image_name' to run the container as detached mode.  
   container_name is an arbitrary.
   
4. type 'docker exec -it container_name /bin/bash' to login the container with bash shell.  
   type 'docker exec -it -u root container_name /bin/bash' to login as root user.  
   type 'exit' to logout.  

5. type 'docker stop container_name' to stop the container.  
   type 'docker start container_name' to restart the container.  
   
6. type 'docker rm container_name' to remove (delete) the container.  
   
7. type 'docker rmi image_name' to remove the image.  


The file docker.sh is the script I'm using, please refer to it. 
