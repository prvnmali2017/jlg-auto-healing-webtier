FROM nginx:stable-alpine
RUN echo '<html><head><title>Johns Lyng Group</title></head><body style="background-color:#1a1a1a; color:#ffffff; font-family:sans-serif; text-align:center; padding-top:20%"><h1>Johns Lyng Group - Web Tier</h1><p>Running securely inside an auto-healing AWS container.</p></body></html>' > /usr/share/nginx/html/index.html
