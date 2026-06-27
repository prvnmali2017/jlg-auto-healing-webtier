FROM nginx:stable-alpine

RUN echo '<html><head><title>Welcome to Johns Lyng Group</title></head><body style="background-color:#ffffff; color:#1a1a1a; font-family:sans-serif; text-align:center; padding-top:20%"><h1>Johns Lyng Group - Web Tier</h1><p>Running securely inside an auto-healing Azure container.</p></body></html>' > /usr/share/nginx/html/index.html

EXPOSE 80
