# 1st Stage: Build the project
FROM node:22-alpine AS builder     

WORKDIR /app                      

COPY package.json ./              

RUN npm install                  

COPY . .                          

RUN npm run build                 


# 2nd Stage: Run using Nginx
FROM nginx:1.29                    

RUN rm -rf /usr/share/nginx/html/*

COPY --from=builder /app/dist /usr/share/nginx/html  
                                    
EXPOSE 80                         
