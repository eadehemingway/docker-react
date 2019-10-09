FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . . 
RUN npm run build 

# a second from statment terminates the previous block and says we are on a new step
# this step uses a new base image and just copies everything from the build folder to the 
# folder in nginx that it serves from
FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html

